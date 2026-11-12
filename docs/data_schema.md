# Gearforce Data Schema

This document describes the JSON structure for unit and weapon data used in the Gearforce application.

---

## Units

Unit data is stored in `assets/data/units/[faction_id].json`.

### Root Object (List)
The root of each file is a list of Unit objects.

### Unit Object
| Field          | Type               | Description                                                                 |
|----------------|--------------------|-----------------------------------------------------------------------------|
| id             | String             | Unique identifier for the unit (e.g., `"north-hunter"`).                    |
| name           | String             | Display name of the unit (e.g., `"Hunter"`).                                |
| tv             | Integer            | Base Threat Value.                                                          |
| roles          | List&lt;String&gt; | List of role abbreviations (e.g., `["GP", "SK", "FS"]`).                    |
| movement       | Object             | Movement definition (see below).                                            |
| armor          | Integer            | Armor value.                                                                |
| hullStructure  | Object or Ints     | `{"hull": 2, "structure": 2}` or top-level `hull` and `structure` integers. |
| actions        | Integer            | Action points available to the unit.                                        |
| gu             | Integer            | Gunnery skill threshold (e.g., `4` for 4+).                                 |
| pi             | Integer            | Piloting skill threshold.                                                   |
| ew             | Integer            | Electronic Warfare skill threshold.                                         |
| reactWeapons   | List&lt;String&gt; | List of reaction weapon notation codes (e.g., `["LAC", "VB"]`).             |
| mountedWeapons | List&lt;String&gt; | List of mounted weapon notation codes (e.g., `["LRP"]`).                    |
| traits         | List&lt;String&gt; | List of traits (e.g., `["Hands", "Sensor:24"]`).                            |
| height         | Number             | Unit height in inches.                                                      |
| classification | String             | Unit category (e.g., `"Gear"`, `"Strider"`, `"Vehicle"`, `"Infantry"`).     |
| subtype        | String             | (Optional) Subtype description (e.g., `"Automaton"`, `"Drone"`).            |
| manufacturer   | String             | (Optional) Unit manufacturer.                                               |
| description    | String             | (Optional) Lore background text.                                            |
| variants       | List&lt;Object&gt; | List of Variant objects (see below).                                        |
| upgrades       | List&lt;Object&gt; | List of Upgrade objects (see below).                                        |

---

### Movement Object
| Field | Type               | Description                                                                                         |
|-------|--------------------|-----------------------------------------------------------------------------------------------------|
| types | List&lt;String&gt; | Movement types: `"W"` (Walker), `"G"` (Ground/Wheeled/Tracked), `"H"` (Hover), `"V"` (VTOL/Flight). |
| value | Integer            | Movement speed in inches.                                                                           |

---

### Variant Object
Overrides or adds to base unit fields for a specific variant.

| Field          | Type               | Description                                                              |
|----------------|--------------------|--------------------------------------------------------------------------|
| id             | String             | Unique identifier for the variant (e.g., `"north-hunter-stock"`).        |
| name           | String             | Display name of the variant.                                             |
| tv             | Integer            | TV cost relative to base unit (or absolute TV depending on parser mode). |
| roles          | List&lt;String&gt; | (Optional) Overrides base roles.                                         |
| movement       | Object             | (Optional) Overrides base movement.                                      |
| armor          | Integer            | (Optional) Overrides base armor.                                         |
| hullStructure  | Object             | (Optional) Overrides hull & structure (`{"hull": X, "structure": Y}`).   |
| actions        | Integer            | (Optional) Overrides action points.                                      |
| gu             | Integer            | (Optional) Overrides Gunnery skill.                                      |
| pi             | Integer            | (Optional) Overrides Piloting skill.                                     |
| ew             | Integer            | (Optional) Overrides EW skill.                                           |
| reactWeapons   | List&lt;String&gt; | (Optional) Overrides reaction weapons.                                   |
| mountedWeapons | List&lt;String&gt; | (Optional) Overrides mounted weapons.                                    |
| traits         | List&lt;String&gt; | (Optional) Overrides traits.                                             |

---

### Upgrade Object
Defines profile or unit upgrades that modify a model's statistics, weapons, or traits.

| Field       | Type               | Description                                                                                 |
|-------------|--------------------|---------------------------------------------------------------------------------------------|
| id          | String             | Unique upgrade identifier (e.g., `"north-hunter-flakjacket"`).                              |
| name        | String             | Display name of the upgrade.                                                                |
| type        | String             | (Optional) Upgrade type: `"unit"`, `"squad"`, `"command"`, `"duelist"` (default: `"unit"`). |
| description | String             | (Optional) Description of what the upgrade changes.                                         |
| tv          | Integer            | (Optional) TV cost adjustment (e.g., `0`, `1`, `2`).                                        |
| armor       | Integer            | (Optional) New armor value.                                                                 |
| hull        | Integer            | (Optional) New hull value.                                                                  |
| structure   | Integer            | (Optional) New structure value.                                                             |
| actions     | Integer            | (Optional) New action points.                                                               |
| gu          | Integer            | (Optional) Gunnery skill modifier or absolute value.                                        |
| pi          | Integer            | (Optional) Piloting skill modifier or absolute value.                                       |
| ew          | Integer            | (Optional) EW skill modifier or absolute value.                                             |
| movement    | Object             | (Optional) New movement definition.                                                         |
| roles       | List&lt;String&gt; | (Optional) New roles allowed by this upgrade.                                               |
| traits      | List&lt;String&gt; | (Optional) Traits added by this upgrade.                                                    |
| weapons     | List&lt;String&gt; | (Optional) Weapons added by this upgrade.                                                   |

---

## Weapons

Weapon data is stored in `assets/data/weapons/weapons.json`.

### Root Object (List)
The root is a list of Weapon objects.

### Weapon Object
| Field     | Type               | Description                                                          |
|-----------|--------------------|----------------------------------------------------------------------|
| code      | String             | Base weapon code without size prefix (e.g., `"AC"`, `"LLC"`, `"RP"`) |
| name      | String             | Display name of the weapon.                                          |
| range     | Object             | Range definition (see below).                                        |
| damage    | Object             | Damage bands by size (see below).                                    |
| modes     | List&lt;String&gt; | List of weapon modes: `"direct"`, `"indirect"`.                      |
| traits    | List&lt;String&gt; | List of primary traits (e.g., `["AP:1", "Guided"]`).                 |
| altTraits | List&lt;String&gt; | List of alternate traits that can be used instead of primary traits. |

---

### Weapon Range Object
| Field | Type    | Description                                            |
|-------|---------|--------------------------------------------------------|
| min   | Integer | Minimum range in inches.                               |
| opt   | Integer | Optimal/Normal range in inches.                        |
| max   | Integer | Maximum range in inches (can be `null` for unlimited). |

---

### Weapon Damage Object
Damage values assigned based on the weapon's size prefix (`L` = Light, `M` = Medium, `H` = Heavy).

| Field | Type    | Description                    |
|-------|---------|--------------------------------|
| l     | Integer | Damage for Light (L) version.  |
| m     | Integer | Damage for Medium (M) version. |
| h     | Integer | Damage for Heavy (H) version.  |
