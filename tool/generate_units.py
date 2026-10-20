import zipfile
import xml.etree.ElementTree as ET
import json
import re
import os
import tempfile
import subprocess
import sys

def main():
    if len(sys.argv) <= 1:
        print("Error: Path to Excel profiles spreadsheet is required.")
        print('Usage: python tool/generate_units.py "path/to/profiles.xlsx"')
        sys.exit(1)

    excel_path = sys.argv[1]
    if not os.path.exists(excel_path):
        print(f"Error: Specified Excel file does not exist: {excel_path}")
        sys.exit(1)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, '..'))
    output_dir = os.path.join(project_root, 'assets', 'data', 'units')

    temp_excel_path = os.path.join(tempfile.gettempdir(), 'gearforce_excel_copy.xlsx')

    try:
        subprocess.run([
            'powershell', '-Command',
            f"Copy-Item -Path '{excel_path}' -Destination '{temp_excel_path}' -Force"
        ], check=True)
    except Exception as e:
        print(f"Copy warning: {e}")
        temp_excel_path = excel_path

    sheet_config = [
        ('North', 'north.json', 'north'),
        ('South', 'south.json', 'south'),
        ('NuCoal', 'nucoal.json', 'nucoal'),
        ('Peace River', 'peaceriver.json', 'peaceriver'),
        ('Black Talon', 'blacktalons.json', 'bt'),
        ('CEF', 'cef.json', 'cef'),
        ('Caprice', 'caprice.json', 'caprice'),
        ('Utopia', 'utopia.json', 'utopia'),
        ('Eden', 'eden.json', 'eden'),
        ('New Jerusalem', 'newjerusalem.json', 'nj'),
        ('Uni Gears', 'unigears.json', 'unigear'),
        ('Uni Vehicles', 'univehicles.json', 'univeh'),
        ('Infantry', 'infantry.json', 'infantry'),
        ('Terrain', 'terrain.json', 'terrain')
    ]

    VALID_ROLES = {'GP', 'SK', 'RC', 'FS', 'SO', 'EG', 'MB', 'AS', 'FT'}

    NOTE_PREFIXES = (
        'REACT', 'MOUNTED', 'TRAITS', 'GUNNERY', 'PILOTING', 'SWAP', 'ADD ',
        'REMOVE', 'REPLACE', 'CHOOSE', 'REQUIRED', 'OPTIONAL', 'HAVING', 'PACKS',
        'NOTE', 'UPGRADE', 'WEAPON', 'EQUIPMENT', 'FEAT', 'PERK', 'SPECIAL'
    )

    def clean_classification(text):
        if not text:
            return 'Gear'
        t_upper = text.upper()
        if 'STRIDER' in t_upper:
            return 'Strider'
        if 'INFANTRY' in t_upper:
            return 'Infantry'
        if 'CAVALRY' in t_upper:
            return 'Cavalry'
        if 'TERRAIN' in t_upper:
            return 'Terrain'
        if 'FORTIFICATION' in t_upper or 'STRUCTURE' in t_upper or 'BUILDING' in t_upper:
            return 'Fortifications'
        if 'COUNTER' in t_upper:
            return 'Counter'
        if 'GEAR' in t_upper:
            return 'Gear'
        return 'Gear'

    def filter_roles(roles_list):
        valid = []
        for r in roles_list:
            r_clean = r.strip().upper()
            if r_clean in VALID_ROLES:
                valid.append(r_clean)
        return valid

    def parse_movement(val):
        if not val or val == '-' or str(val).strip() in ['', '-']:
            return None
        val = str(val).strip()
        speed = 0
        raw_types = []
        if ':' in val:
            types_str, speed_str = val.split(':', 1)
            raw_types = [t.strip().upper() for t in types_str.split('/') if t.strip()]
            speed = parse_int(speed_str, 0)
        else:
            raw_types = [val.upper()]

        valid_movement_types = {'W': 'W', 'G': 'G', 'H': 'H', 'WALKER': 'W', 'GROUND': 'G', 'HOVER': 'H'}
        mapped_types = []
        for t in raw_types:
            if t in valid_movement_types:
                mapped_types.append(valid_movement_types[t])
            elif 'W' in t:
                mapped_types.append('W')
            elif 'G' in t or 'T' in t:
                mapped_types.append('G')
            elif 'H' in t or 'VTOL' in t or 'F' in t:
                mapped_types.append('H')

        if not mapped_types:
            return None

        unique_types = list(dict.fromkeys(mapped_types))
        return {"types": unique_types, "value": speed}

    def get_sheet_rows(path_to_excel, sheet_name):
        with zipfile.ZipFile(path_to_excel, 'r') as z:
            shared_strings = []
            if 'xl/sharedStrings.xml' in z.namelist():
                ss_root = ET.fromstring(z.read('xl/sharedStrings.xml'))
                for si in ss_root.findall('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}si'):
                    t = si.find('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}t')
                    if t is not None and t.text:
                        shared_strings.append(t.text)
                    else:
                        text_parts = [t.text for t in si.findall('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}t') if t.text]
                        shared_strings.append(''.join(text_parts))

            workbook_xml = z.read('xl/workbook.xml')
            root = ET.fromstring(workbook_xml)
            sheets = root.findall('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}sheets/{http://schemas.openxmlformats.org/spreadsheetml/2006/main}sheet')

            rId = None
            for s in sheets:
                if s.attrib['name'] == sheet_name:
                    rId = s.attrib['{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id']
                    break

            if not rId:
                return {}

            rels_root = ET.fromstring(z.read('xl/_rels/workbook.xml.rels'))
            rel_dict = {r.attrib['Id']: r.attrib['Target'] for r in rels_root.findall('{http://schemas.openxmlformats.org/package/2006/relationships}Relationship')}

            target = rel_dict[rId]
            sheet_path = 'xl/' + target if not target.startswith('xl/') else target
            sheet_root = ET.fromstring(z.read(sheet_path))
            sheetData = sheet_root.find('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}sheetData')

            row_map = {}
            for r in sheetData.findall('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}row'):
                row_num = int(r.attrib['r'])
                row_cells = {}
                for c in r.findall('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}c'):
                    cell_ref = c.attrib['r']
                    col_name = ''.join(filter(str.isalpha, cell_ref))
                    t_type = c.attrib.get('t')
                    v = c.find('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}v')
                    val = v.text if v is not None else ''
                    if t_type == 's' and val != '':
                        val = shared_strings[int(val)]
                    row_cells[col_name] = val.strip() if isinstance(val, str) else str(val)
                row_map[row_num] = row_cells
            return row_map

    def parse_num(val, default=0):
        if not val or val == '-':
            return default
        try:
            val_str = str(val).replace('"', '').replace('+', '').strip()
            if '.' in val_str:
                f = float(val_str)
                return int(f) if f.is_integer() else f
            return int(val_str)
        except:
            return default

    def clean_tv(val):
        import math
        num_v = parse_num(val)
        if num_v > 0:
            frac = num_v - math.floor(num_v)
            if frac >= 0.5:
                return math.ceil(num_v)
            elif frac > 0:
                return math.floor(num_v)
        return num_v

    def parse_int(val, default=0):
        n = parse_num(val, default)
        if isinstance(n, float):
            return int(n)
        return n

    def parse_list(val):
        if not val or val == '-':
            return []
        val_str = str(val).strip()
        parts = []
        current = []
        paren_depth = 0
        for char in val_str:
            if char == '(':
                paren_depth += 1
                current.append(char)
            elif char == ')':
                paren_depth = max(0, paren_depth - 1)
                current.append(char)
            elif char == ',' and paren_depth == 0:
                part = ''.join(current).strip()
                if part and part != '-':
                    parts.append(part)
                current = []
            else:
                current.append(char)
        if current:
            part = ''.join(current).strip()
            if part and part != '-':
                parts.append(part)
        return parts

    def clean_trait_string(t):
        t = t.strip()
        if t.lower() in ['hand', 'hand (aux)']:
            t = re.sub(r'\bhand\b', 'Hands', t, flags=re.IGNORECASE)

        m = re.match(r'^Transport:\s*(\d+)\s*(Cadre|Gear|Armiger|Team|Drone|N-KIDU|Cadres|Gears|Armigers|Teams|Drones|N-KIDUs)$', t, re.IGNORECASE)
        if m:
            level, t_type = m.groups()
            if not t_type.endswith('s') and t_type.lower() != 'n-kidus':
                t_type = t_type + 's'
            t = f"Transport:{level} {t_type}"
        return t

    def parse_traits_list(val):
        raw = parse_list(val)
        valid = []
        for t in raw:
            if re.search(r'[a-zA-Z]', t):
                valid.append(clean_trait_string(t))
        return valid

    def clean_weapon_code(w):
        w = w.strip()
        is_linked = False
        if w.startswith('Linked-'):
            is_linked = True
            w = w[len('Linked-'):].strip()
        elif w.startswith('Linked '):
            is_linked = True
            w = w[len('Linked '):].strip()

        w = re.sub(r'\s*\([LMH]\)$', '', w, flags=re.IGNORECASE)

        m = re.match(r'^(?:(\d+\s*x\s*))?([a-zA-Z]+)(?:/([a-zA-Z]+))?\s*(\(.*\))?$', w)
        if m:
            qty, c1, c2, traits = m.groups()

            if is_linked and not qty:
                qty = '2 x '
            else:
                qty = qty or ''

            if c1 and len(c1) > 2 and c1.endswith('s') and not c1.endswith('ss'):
                c1 = c1[:-1]
            if c2 and len(c2) > 2 and c2.endswith('s') and not c2.endswith('ss'):
                c2 = c2[:-1]

            trait_list = []
            if traits and traits.startswith('(') and traits.endswith(')'):
                raw_t = traits[1:-1].strip()
                if raw_t:
                    trait_list = [t.strip() for t in raw_t.split(',')]

            if is_linked and 'Link' not in trait_list and 'Linked' not in trait_list:
                trait_list.append('Link')

            traits_str = f"({', '.join(trait_list)})" if trait_list else ''
            combo_str = f"/{c2}" if c2 else ''
            w = f"{qty}{c1}{combo_str}{(' ' + traits_str) if traits_str else ''}".strip()

        return w

    def parse_weapons_list(val):
        raw = parse_list(val)
        valid = []
        for w in raw:
            if not w.isdigit() and w not in ['-', '0', '1', '2'] and re.search(r'[a-zA-Z]', w):
                cw = clean_weapon_code(w)
                valid.append(cw)
        return valid

    def parse_height(val):
        if not val or val == '-':
            return 0
        val_str = str(val).replace('"', '').strip()
        try:
            f = float(val_str)
            return int(f) if f.is_integer() else f
        except:
            return 0

    def clean_id(text):
        text = re.sub(r'[^a-zA-Z0-9\s]', '', text)
        words = text.split()
        if not words:
            return 'unknown'
        return words[0].lower() + ''.join(w.capitalize() for w in words[1:])

    def is_note_line(a_val):
        if not a_val:
            return True
        if len(a_val) > 35:
            return True
        if ' TV)' in a_val or ' TV):' in a_val:
            return True
        upper_a = a_val.upper()
        for prefix in NOTE_PREFIXES:
            if upper_a.startswith(prefix):
                return True
        return False

    def parse_faction_sheet(f_excel_path, sheet_name, faction_prefix):
        row_map = get_sheet_rows(f_excel_path, sheet_name)
        if not row_map:
            return []

        header_rows = []
        for r_num in sorted(row_map.keys()):
            cell_a = row_map[r_num].get('A', '')
            if cell_a in ['Unit', 'Base Model']:
                header_rows.append(r_num)

        units = []
        used_ids = set()

        meta_keys = {'Manufacturer:', 'Classification:', 'Subtype:', 'Crew'}

        for i, h_row in enumerate(header_rows):
            # Find metadata rows above h_row
            first_meta_row = h_row
            manufacturer = ""
            classification = ""
            subtype = ""

            for r in range(h_row - 1, max(1, h_row - 10), -1):
                cells = row_map.get(r, {})
                a_val = cells.get('A', '')
                b_val = cells.get('B', '')
                if a_val in meta_keys:
                    if r < first_meta_row:
                        first_meta_row = r
                    if a_val == 'Manufacturer:': manufacturer = b_val
                    elif a_val == 'Classification:': classification = b_val
                    elif a_val == 'Subtype:': subtype = b_val

            # Unit name is on the row above first_meta_row
            unit_name = ""
            unit_name_row = h_row
            for r in range(first_meta_row - 1, max(1, h_row - 12), -1):
                cells = row_map.get(r, {})
                a_val = cells.get('A', '')
                b_val = cells.get('B', '')
                if a_val and not b_val and a_val != sheet_name and not a_val.startswith('Required:') and not a_val.startswith('Optional:'):
                    unit_name = a_val
                    unit_name_row = r
                    break

            base_cells = row_map.get(h_row + 1, {})
            if not unit_name:
                unit_name = base_cells.get('A', f'Unit_{i+1}')

            # Description lines are rows strictly BETWEEN unit_name_row and h_row
            desc_lines = []
            if unit_name_row < h_row:
                for r in range(unit_name_row + 1, h_row):
                    cells = row_map.get(r, {})
                    a_val = cells.get('A', '')
                    if a_val and a_val not in meta_keys and not a_val.startswith('Manufacturer:') and not a_val.startswith('Classification:') and not a_val.startswith('Subtype:') and not a_val.startswith('Crew'):
                        desc_lines.append(a_val)

            hs_str = base_cells.get('F', '0/0')
            hull, struct = 0, 0
            if '/' in hs_str:
                h_parts = hs_str.split('/')
                hull = parse_int(h_parts[0])
                struct = parse_int(h_parts[1])

            base_id = f"{faction_prefix}-{clean_id(unit_name)}"
            unit_id = base_id
            counter = 2
            while unit_id in used_ids:
                unit_id = f"{base_id}{counter}"
                counter += 1
            used_ids.add(unit_id)

            move_obj = parse_movement(base_cells.get('D'))
            if not move_obj:
                move_obj = {"types": ["G"], "value": 0}

            roles = filter_roles(parse_list(base_cells.get('C')))

            unit = {
                "id": unit_id,
                "name": unit_name,
                "tv": clean_tv(base_cells.get('B')),
                "roles": roles,
                "movement": move_obj,
                "armor": max(0, parse_int(base_cells.get('E'))),
                "hull": max(0, hull),
                "structure": max(0, struct),
                "actions": max(0, parse_int(base_cells.get('G'))),
                "gu": max(0, parse_int(base_cells.get('H'))),
                "pi": max(0, parse_int(base_cells.get('I'))),
                "ew": max(0, parse_int(base_cells.get('J'))),
                "reactWeapons": parse_weapons_list(base_cells.get('K')),
                "mountedWeapons": parse_weapons_list(base_cells.get('L')),
                "traits": parse_traits_list(base_cells.get('M')),
                "height": parse_height(base_cells.get('N')),
                "classification": clean_classification(classification),
                "subtype": subtype,
                "manufacturer": manufacturer,
                "description": " ".join(desc_lines),
                "variants": [],
                "upgrades": []
            }

            if not unit["reactWeapons"]: del unit["reactWeapons"]
            if not unit["mountedWeapons"]: del unit["mountedWeapons"]
            if not unit["description"]: del unit["description"]
            if not unit["subtype"]: del unit["subtype"]
            if not unit["manufacturer"]: del unit["manufacturer"]

            next_h = header_rows[i+1] if i+1 < len(header_rows) else max(row_map.keys()) + 1
            block_end = next_h - 1
            for r in range(next_h - 1, h_row, -1):
                a_val = row_map.get(r, {}).get('A', '')
                if a_val in ['Manufacturer:', 'Classification:', 'Subtype:', 'Crew'] or (a_val and len(a_val) < 35 and not row_map.get(r, {}).get('B') and r < next_h - 1):
                    block_end = r - 1

            current_section = "variants"
            last_parsed_row = h_row + 1

            for r in range(h_row + 2, block_end + 1):
                if r == last_parsed_row + 1:
                    continue

                cells = row_map.get(r, {})
                a_val = cells.get('A', '')

                if not a_val:
                    continue

                if a_val.startswith('Required:') or 'Variant' in a_val:
                    current_section = "variants"
                    continue
                elif a_val.startswith('Optional:') or 'Upgrade' in a_val:
                    current_section = "upgrades"
                    continue

                if is_note_line(a_val):
                    continue

                item_name = a_val
                if item_name in ['Factory Stock', 'Base Model']:
                    item_name = 'Stock'

                item_base_id = f"{unit_id}-{clean_id(item_name)}"
                item_id = item_base_id
                item_counter = 2
                while item_id in used_ids:
                    item_id = f"{item_base_id}{item_counter}"
                    item_counter += 1
                used_ids.add(item_id)

                b_val = cells.get('B', '0')

                item_obj = {
                    "id": item_id,
                    "name": item_name,
                    "tv": clean_tv(b_val)
                }

                roles = filter_roles(parse_list(cells.get('C')))
                if roles: item_obj["roles"] = roles

                move = parse_movement(cells.get('D'))
                if move and move.get("types"):
                    item_obj["movement"] = move

                arm = cells.get('E')
                if arm and arm != '-':
                    arm_num = parse_int(arm)
                    if arm_num >= 0:
                        item_obj["armor"] = arm_num

                v_hs = cells.get('F', '-')
                if '/' in v_hs:
                    p = v_hs.split('/')
                    v_h = parse_int(p[0])
                    v_s = parse_int(p[1])
                    if v_h >= 0 and v_s >= 0:
                        item_obj["hull"] = v_h
                        item_obj["structure"] = v_s

                act = cells.get('G')
                if act and act != '-':
                    act_num = parse_int(act)
                    if act_num >= 0:
                        item_obj["actions"] = act_num

                gu = cells.get('H')
                if gu and gu != '-':
                    gu_num = parse_int(gu)
                    if gu_num >= 0:
                        item_obj["gu"] = gu_num

                pi = cells.get('I')
                if pi and pi != '-':
                    pi_num = parse_int(pi)
                    if pi_num >= 0:
                        item_obj["pi"] = pi_num

                ew = cells.get('J')
                if ew and ew != '-':
                    ew_num = parse_int(ew)
                    if ew_num >= 0:
                        item_obj["ew"] = ew_num

                rw = parse_weapons_list(cells.get('K'))
                if rw: item_obj["reactWeapons"] = rw

                mw = parse_weapons_list(cells.get('L'))
                if mw: item_obj["mountedWeapons"] = mw

                tr = parse_traits_list(cells.get('M'))
                if tr: item_obj["traits"] = tr

                if current_section == "variants":
                    unit["variants"].append(item_obj)
                else:
                    unit["upgrades"].append(item_obj)

                last_parsed_row = r

            if not unit["variants"]:
                stock_id = f"{unit_id}-stock"
                if stock_id in used_ids:
                    stock_id = f"{unit_id}-stock2"
                used_ids.add(stock_id)
                unit["variants"].append({
                    "id": stock_id,
                    "name": "Stock",
                    "tv": 0
                })

            units.append(unit)

        return units

    for sheet_name, filename, prefix in sheet_config:
        units = parse_faction_sheet(temp_excel_path, sheet_name, prefix)
        target_path = os.path.join(output_dir, filename)
        with open(target_path, 'w', encoding='utf-8') as f:
            json.dump(units, f, indent=2)
        print(f"Generated {filename}: {len(units)} units")

if __name__ == '__main__':
    main()
