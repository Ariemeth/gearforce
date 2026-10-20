import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';

void main(List<String> args) {
  final String excelPath = args.isNotEmpty
      ? args.first
      : r'C:\Users\ariem\OneDrive\Games\Miniatures\Heavy Gear\Beta\4.0 Beta\2026 - 06\4.0 Profiles 29 Jun 2026.xlsx';

  final scriptDir = File(Platform.script.toFilePath()).parent;
  final projectRoot = scriptDir.parent;
  final outputDir = Directory('${projectRoot.path}/assets/data/units');

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // Copy to temp file to avoid file locks
  final tempFile = File(
    '${Directory.systemTemp.path}/gearforce_excel_copy.xlsx',
  );
  try {
    File(excelPath).copySync(tempFile.path);
  } catch (e) {
    print('Copy warning: $e');
  }

  final bytes = (tempFile.existsSync() ? tempFile : File(excelPath))
      .readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);

  final sheetConfig = [
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
    ('Terrain', 'terrain.json', 'terrain'),
  ];

  for (final config in sheetConfig) {
    final sheetName = config.$1;
    final fileName = config.$2;
    final prefix = config.$3;

    if (!excel.tables.containsKey(sheetName)) {
      continue;
    }

    final sheet = excel.tables[sheetName]!;
    final units = parseFactionSheet(sheet, sheetName, prefix);

    final targetFile = File('${outputDir.path}/$fileName');
    const encoder = JsonEncoder.withIndent('  ');
    targetFile.writeAsStringSync(encoder.convert(units));
    print('Generated $fileName: ${units.length} units');
  }
}

const validRoles = {'GP', 'SK', 'RC', 'FS', 'SO', 'EG', 'MB', 'AS', 'FT'};
const notePrefixes = [
  'REACT',
  'MOUNTED',
  'TRAITS',
  'GUNNERY',
  'PILOTING',
  'SWAP',
  'ADD ',
  'REMOVE',
  'REPLACE',
  'CHOOSE',
  'REQUIRED',
  'OPTIONAL',
  'HAVING',
  'PACKS',
  'NOTE',
  'UPGRADE',
  'WEAPON',
  'EQUIPMENT',
  'FEAT',
  'PERK',
  'SPECIAL',
];

String cleanClassification(String? text) {
  if (text == null || text.isEmpty) return 'Gear';
  final tUpper = text.toUpperCase();
  if (tUpper.contains('STRIDER')) return 'Strider';
  if (tUpper.contains('INFANTRY')) return 'Infantry';
  if (tUpper.contains('CAVALRY')) return 'Cavalry';
  if (tUpper.contains('TERRAIN')) return 'Terrain';
  if (tUpper.contains('FORTIFICATION') ||
      tUpper.contains('STRUCTURE') ||
      tUpper.contains('BUILDING')) {
    return 'Fortifications';
  }
  if (tUpper.contains('COUNTER')) return 'Counter';
  return 'Gear';
}

List<String> filterRoles(List<String> rolesList) {
  final List<String> valid = [];
  for (final r in rolesList) {
    final clean = r.trim().toUpperCase();
    if (validRoles.contains(clean)) {
      valid.add(clean);
    }
  }
  return valid;
}

Map<String, dynamic>? parseMovement(dynamic val) {
  if (val == null) return null;
  final str = val.toString().trim();
  if (str.isEmpty || str == '-') return null;

  int speed = 0;
  List<String> rawTypes = [];

  if (str.contains(':')) {
    final parts = str.split(':');
    rawTypes = parts[0]
        .split('/')
        .map((e) => e.trim().toUpperCase())
        .where((e) => e.isNotEmpty)
        .toList();
    if (parts.length > 1) {
      speed = parseInt(parts[1], 0);
    }
  } else {
    rawTypes = [str.toUpperCase()];
  }

  const validMovementTypes = {
    'W': 'W',
    'G': 'G',
    'H': 'H',
    'WALKER': 'W',
    'GROUND': 'G',
    'HOVER': 'H',
  };
  final List<String> mappedTypes = [];

  for (final t in rawTypes) {
    if (validMovementTypes.containsKey(t)) {
      mappedTypes.add(validMovementTypes[t]!);
    } else if (t.contains('W')) {
      mappedTypes.add('W');
    } else if (t.contains('G') || t.contains('T')) {
      mappedTypes.add('G');
    } else if (t.contains('H') || t.contains('VTOL') || t.contains('F')) {
      mappedTypes.add('H');
    }
  }

  if (mappedTypes.isEmpty) return null;

  final uniqueTypes = mappedTypes.toSet().toList();
  return {'types': uniqueTypes, 'value': speed};
}

num parseNum(dynamic val, [num defaultValue = 0]) {
  if (val == null) return defaultValue;
  final str = val.toString().replaceAll('"', '').replaceAll('+', '').trim();
  if (str.isEmpty || str == '-') return defaultValue;
  final n = num.tryParse(str);
  if (n == null) return defaultValue;
  return n.toDouble() == n.toInt() ? n.toInt() : n;
}

int parseInt(dynamic val, [int defaultValue = 0]) {
  final n = parseNum(val, defaultValue);
  return n.toInt();
}

num parseTv(
  Sheet sheet,
  int rowIndex,
  int colIndex, {
  bool isBaseUnit = false,
}) {
  if (rowIndex >= sheet.maxRows) return 0;
  final row = sheet.rows[rowIndex];
  if (colIndex >= row.length) return 0;
  final cell = row[colIndex];
  if (cell == null || cell.value == null) return 0;

  num value = 0;
  final val = cell.value;
  if (val is FormulaCellValue) {
    final formulaRowIndex = rowIndex + 1;
    if (formulaRowIndex < sheet.maxRows) {
      num sum = 0;
      final fRow = sheet.rows[formulaRowIndex];
      for (int col = 0; col <= 13; col++) {
        if (col < fRow.length &&
            fRow[col] != null &&
            fRow[col]!.value != null) {
          sum += parseNum(fRow[col]!.value);
        }
      }
      value = sum;
    }
  } else {
    value = parseNum(val);
  }

  if (value > 0) {
    final frac = value - value.floor();
    if (frac >= 0.5) {
      return value.ceil();
    } else if (frac > 0) {
      return value.floor();
    }
  }

  return value.toDouble() == value.toInt() ? value.toInt() : value;
}

List<String> parseList(dynamic val) {
  if (val == null) return [];
  final valStr = val.toString().trim();
  if (valStr.isEmpty || valStr == '-') return [];

  final List<String> parts = [];
  final List<String> current = [];
  int parenDepth = 0;

  for (int i = 0; i < valStr.length; i++) {
    final char = valStr[i];
    if (char == '(') {
      parenDepth++;
      current.add(char);
    } else if (char == ')') {
      if (parenDepth > 0) parenDepth--;
      current.add(char);
    } else if (char == ',' && parenDepth == 0) {
      final part = current.join().trim();
      if (part.isNotEmpty && part != '-') {
        parts.add(part);
      }
      current.clear();
    } else {
      current.add(char);
    }
  }

  if (current.isNotEmpty) {
    final part = current.join().trim();
    if (part.isNotEmpty && part != '-') {
      parts.add(part);
    }
  }

  return parts;
}

String cleanTraitString(String t) {
  var str = t.trim();
  if (str.toLowerCase() == 'hand' || str.toLowerCase() == 'hand (aux)') {
    str = str.replaceAll(RegExp(r'\bhand\b', caseSensitive: false), 'Hands');
  }

  final transportRegex = RegExp(
    r'^Transport:\s*(\d+)\s*(Cadre|Gear|Armiger|Team|Drone|N-KIDU|Cadres|Gears|Armigers|Teams|Drones|N-KIDUs)$',
    caseSensitive: false,
  );
  final match = transportRegex.firstMatch(str);
  if (match != null) {
    final level = match.group(1);
    var type = match.group(2)!;
    if (!type.endsWith('s') && type.toLowerCase() != 'n-kidus') {
      type = '${type}s';
    }
    str = 'Transport:$level $type';
  }

  return str;
}

List<String> parseTraitsList(dynamic val) {
  final raw = parseList(val);
  final List<String> valid = [];
  for (final t in raw) {
    if (RegExp(r'[a-zA-Z]').hasMatch(t)) {
      valid.add(cleanTraitString(t));
    }
  }
  return valid;
}

String cleanWeaponCode(String w) {
  var str = w.trim();
  bool isLinked = false;
  if (str.startsWith('Linked-')) {
    isLinked = true;
    str = str.substring('Linked-'.length).trim();
  } else if (str.startsWith('Linked ')) {
    isLinked = true;
    str = str.substring('Linked '.length).trim();
  }

  str = str.replaceAll(RegExp(r'\s*\([LMH]\)$', caseSensitive: false), '');

  final match = RegExp(
    r'^(?:(\d+\s*x\s*))?([a-zA-Z]+)(?:/([a-zA-Z]+))?\s*(\(.*\))?$',
  ).firstMatch(str);
  if (match != null) {
    var qty = match.group(1) ?? '';
    var c1 = match.group(2)!;
    var c2 = match.group(3);
    final traits = match.group(4);

    if (isLinked && qty.isEmpty) {
      qty = '2 x ';
    }

    if (c1.length > 2 && c1.endsWith('s') && !c1.endsWith('ss')) {
      c1 = c1.substring(0, c1.length - 1);
    }
    if (c2 != null && c2.length > 2 && c2.endsWith('s') && !c2.endsWith('ss')) {
      c2 = c2.substring(0, c2.length - 1);
    }

    List<String> traitList = [];
    if (traits != null && traits.startsWith('(') && traits.endsWith(')')) {
      final rawT = traits.substring(1, traits.length - 1).trim();
      if (rawT.isNotEmpty) {
        traitList = rawT.split(',').map((e) => e.trim()).toList();
      }
    }

    if (isLinked &&
        !traitList.contains('Link') &&
        !traitList.contains('Linked')) {
      traitList.add('Link');
    }

    final traitsStr = traitList.isNotEmpty ? '(${traitList.join(', ')})' : '';
    final comboStr = c2 != null ? '/$c2' : '';
    str = '$qty$c1$comboStr${traitsStr.isNotEmpty ? ' $traitsStr' : ''}'.trim();
  }

  return str;
}

List<String> parseWeaponsList(dynamic val) {
  final raw = parseList(val);
  final List<String> valid = [];
  for (final w in raw) {
    if (!RegExp(r'^\d+$').hasMatch(w) &&
        !['-', '0', '1', '2'].contains(w) &&
        RegExp(r'[a-zA-Z]').hasMatch(w)) {
      valid.add(cleanWeaponCode(w));
    }
  }
  return valid;
}

num parseHeight(dynamic val) {
  if (val == null) return 0;
  final str = val.toString().replaceAll('"', '').trim();
  if (str.isEmpty || str == '-') return 0;
  final n = num.tryParse(str);
  if (n == null) return 0;
  return n.toDouble() == n.toInt() ? n.toInt() : n;
}

String cleanId(String text) {
  final clean = text.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  final words = clean.split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
  if (words.isEmpty) return 'unknown';
  final first = words.first.toLowerCase();
  final rest = words
      .skip(1)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join();
  return '$first$rest';
}

bool isNoteLine(String? aVal) {
  if (aVal == null || aVal.isEmpty) return true;
  if (aVal.length > 35) return true;
  if (aVal.contains(' TV)') || aVal.contains(' TV):')) return true;
  final upper = aVal.toUpperCase();
  for (final prefix in notePrefixes) {
    if (upper.startsWith(prefix)) return true;
  }
  return false;
}

List<Map<String, dynamic>> parseFactionSheet(
  Sheet sheet,
  String sheetName,
  String factionPrefix,
) {
  final Map<int, Map<int, String>> rowMap = {};

  for (int r = 0; r < sheet.maxRows; r++) {
    final row = sheet.rows[r];
    final Map<int, String> rowCells = {};
    for (int c = 0; c < row.length; c++) {
      final cell = row[c];
      if (cell != null && cell.value != null) {
        rowCells[c] = cell.value.toString().trim();
      }
    }
    if (rowCells.isNotEmpty) {
      rowMap[r + 1] = rowCells;
    }
  }

  final List<int> headerRows = [];
  for (final entry in rowMap.entries) {
    final cellA = entry.value[0] ?? '';
    if (cellA == 'Unit' || cellA == 'Base Model') {
      headerRows.add(entry.key);
    }
  }

  final List<Map<String, dynamic>> units = [];
  final Set<String> usedIds = {};
  const metaKeys = {'Manufacturer:', 'Classification:', 'Subtype:', 'Crew'};

  for (int i = 0; i < headerRows.length; i++) {
    final hRow = headerRows[i];

    int firstMetaRow = hRow;
    String manufacturer = '';
    String classification = '';
    String subtype = '';

    for (int r = hRow - 1; r >= (hRow - 10 > 1 ? hRow - 10 : 1); r--) {
      final cells = rowMap[r] ?? {};
      final aVal = cells[0] ?? '';
      final bVal = cells[1] ?? '';
      if (metaKeys.contains(aVal)) {
        if (r < firstMetaRow) firstMetaRow = r;
        if (aVal == 'Manufacturer:') manufacturer = bVal;
        if (aVal == 'Classification:') classification = bVal;
        if (aVal == 'Subtype:') subtype = bVal;
      }
    }

    String unitName = '';
    int unitNameRow = hRow;
    for (int r = firstMetaRow - 1; r >= (hRow - 12 > 1 ? hRow - 12 : 1); r--) {
      final cells = rowMap[r] ?? {};
      final aVal = cells[0] ?? '';
      final bVal = cells[1] ?? '';
      if (aVal.isNotEmpty &&
          bVal.isEmpty &&
          aVal != sheetName &&
          !aVal.startsWith('Required:') &&
          !aVal.startsWith('Optional:')) {
        unitName = aVal;
        unitNameRow = r;
        break;
      }
    }

    final baseCells = rowMap[hRow + 1] ?? {};
    if (unitName.isEmpty) {
      unitName = baseCells[0] ?? 'Unit_${i + 1}';
    }

    final List<String> descLines = [];
    if (unitNameRow < hRow) {
      for (int r = unitNameRow + 1; r < hRow; r++) {
        final cells = rowMap[r] ?? {};
        final aVal = cells[0] ?? '';
        if (aVal.isNotEmpty &&
            !metaKeys.contains(aVal) &&
            !aVal.startsWith('Manufacturer:') &&
            !aVal.startsWith('Classification:') &&
            !aVal.startsWith('Subtype:') &&
            !aVal.startsWith('Crew')) {
          descLines.add(aVal);
        }
      }
    }

    final hsStr = baseCells[5] ?? '0/0';
    int hull = 0;
    int struct = 0;
    if (hsStr.contains('/')) {
      final parts = hsStr.split('/');
      hull = parseInt(parts[0]);
      struct = parseInt(parts[1]);
    }

    final baseId = '$factionPrefix-${cleanId(unitName)}';
    var unitId = baseId;
    int counter = 2;
    while (usedIds.contains(unitId)) {
      unitId = '$baseId$counter';
      counter++;
    }
    usedIds.add(unitId);

    var moveObj = parseMovement(baseCells[3]);
    moveObj ??= {
      'types': ['G'],
      'value': 0,
    };

    final roles = filterRoles(parseList(baseCells[2]));

    final Map<String, dynamic> unit = {
      'id': unitId,
      'name': unitName,
      'tv': parseTv(sheet, hRow, 1, isBaseUnit: true),
      'roles': roles,
      'movement': moveObj,
      'armor': (parseInt(baseCells[4]) < 0 ? 0 : parseInt(baseCells[4])),
      'hull': (hull < 0 ? 0 : hull),
      'structure': (struct < 0 ? 0 : struct),
      'actions': (parseInt(baseCells[6]) < 0 ? 0 : parseInt(baseCells[6])),
      'gu': (parseInt(baseCells[7]) < 0 ? 0 : parseInt(baseCells[7])),
      'pi': (parseInt(baseCells[8]) < 0 ? 0 : parseInt(baseCells[8])),
      'ew': (parseInt(baseCells[9]) < 0 ? 0 : parseInt(baseCells[9])),
      'reactWeapons': parseWeaponsList(baseCells[10]),
      'mountedWeapons': parseWeaponsList(baseCells[11]),
      'traits': parseTraitsList(baseCells[12]),
      'height': parseHeight(baseCells[13]),
      'classification': cleanClassification(classification),
      if (subtype.isNotEmpty) 'subtype': subtype,
      if (manufacturer.isNotEmpty) 'manufacturer': manufacturer,
      if (descLines.isNotEmpty) 'description': descLines.join(' '),
      'variants': <Map<String, dynamic>>[],
      'upgrades': <Map<String, dynamic>>[],
    };

    if ((unit['reactWeapons'] as List).isEmpty) unit.remove('reactWeapons');
    if ((unit['mountedWeapons'] as List).isEmpty) unit.remove('mountedWeapons');

    final nextH = i + 1 < headerRows.length
        ? headerRows[i + 1]
        : (rowMap.keys.isNotEmpty
              ? rowMap.keys.reduce((a, b) => a > b ? a : b) + 1
              : 1);
    int blockEnd = nextH - 1;
    for (int r = nextH - 1; r > hRow; r--) {
      final aVal = rowMap[r]?[0] ?? '';
      if (metaKeys.contains(aVal) ||
          (aVal.isNotEmpty &&
              aVal.length < 35 &&
              (rowMap[r]?[1] ?? '').isEmpty &&
              r < nextH - 1)) {
        blockEnd = r - 1;
      }
    }

    var currentSection = 'variants';
    int lastParsedRow = hRow + 1;

    for (int r = hRow + 2; r <= blockEnd; r++) {
      if (r == lastParsedRow + 1) {
        continue;
      }

      final cells = rowMap[r] ?? {};
      final aVal = cells[0] ?? '';

      if (aVal.isEmpty) continue;

      if (aVal.startsWith('Required:') || aVal.contains('Variant')) {
        currentSection = 'variants';
        continue;
      } else if (aVal.startsWith('Optional:') || aVal.contains('Upgrade')) {
        currentSection = 'upgrades';
        continue;
      }

      if (isNoteLine(aVal)) continue;

      var itemName = aVal;
      if (itemName == 'Factory Stock' || itemName == 'Base Model') {
        itemName = 'Stock';
      }

      final itemBaseId = '$unitId-${cleanId(itemName)}';
      var itemId = itemBaseId;
      int itemCounter = 2;
      while (usedIds.contains(itemId)) {
        itemId = '$itemBaseId$itemCounter';
        itemCounter++;
      }
      usedIds.add(itemId);

      final Map<String, dynamic> itemObj = {
        'id': itemId,
        'name': itemName,
        'tv': parseTv(sheet, r - 1, 1, isBaseUnit: false),
      };

      final itemRoles = filterRoles(parseList(cells[2]));
      if (itemRoles.isNotEmpty) itemObj['roles'] = itemRoles;

      final itemMove = parseMovement(cells[3]);
      if (itemMove != null && (itemMove['types'] as List).isNotEmpty) {
        itemObj['movement'] = itemMove;
      }

      final arm = cells[4];
      if (arm != null && arm != '-') {
        final armNum = parseInt(arm);
        if (armNum >= 0) itemObj['armor'] = armNum;
      }

      final vHs = cells[5] ?? '-';
      if (vHs.contains('/')) {
        final parts = vHs.split('/');
        final vH = parseInt(parts[0]);
        final vS = parseInt(parts[1]);
        if (vH >= 0 && vS >= 0) {
          itemObj['hull'] = vH;
          itemObj['structure'] = vS;
        }
      }

      final act = cells[6];
      if (act != null && act != '-') {
        final actNum = parseInt(act);
        if (actNum >= 0) itemObj['actions'] = actNum;
      }

      final gu = cells[7];
      if (gu != null && gu != '-') {
        final guNum = parseInt(gu);
        if (guNum >= 0) itemObj['gu'] = guNum;
      }

      final pi = cells[8];
      if (pi != null && pi != '-') {
        final piNum = parseInt(pi);
        if (piNum >= 0) itemObj['pi'] = piNum;
      }

      final ew = cells[9];
      if (ew != null && ew != '-') {
        final ewNum = parseInt(ew);
        if (ewNum >= 0) itemObj['ew'] = ewNum;
      }

      final rw = parseWeaponsList(cells[10]);
      if (rw.isNotEmpty) itemObj['reactWeapons'] = rw;

      final mw = parseWeaponsList(cells[11]);
      if (mw.isNotEmpty) itemObj['mountedWeapons'] = mw;

      final tr = parseTraitsList(cells[12]);
      if (tr.isNotEmpty) itemObj['traits'] = tr;

      if (currentSection == 'variants') {
        (unit['variants'] as List).add(itemObj);
      } else {
        (unit['upgrades'] as List).add(itemObj);
      }

      lastParsedRow = r;
    }

    if ((unit['variants'] as List).isEmpty) {
      var stockId = '$unitId-stock';
      if (usedIds.contains(stockId)) stockId = '$unitId-stock2';
      usedIds.add(stockId);
      (unit['variants'] as List).add({'id': stockId, 'name': 'Stock', 'tv': 0});
    }

    units.add(unit);
  }

  return units;
}
