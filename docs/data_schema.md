# Gearforce Data Schema

This document describes the JSON structure for unit and weapon data used in the Gearforce application.

## Units

Unit data is stored in `assets/data/units/[faction_id].json`.

### Root Object (List)
The root of each file is a list of Unit objects.

### Unit Object
| Field          | Type         | Description                                            |
|----------------|--------------|--------------------------------------------------------|
| id             | String       | Unique identifier for the unit (e.g., "north-hunter"). |
| name           | String       | Display name of the unit.                              |
| tv             | Integer      | Base Threat Value.                                     |
| roles          | List<String> | List of role abbreviations (e.g., "GP", "SK").         |
| movement       | Object       | Movement definition (see below).                       |
| armor          | Integer      | Armor value.                                           |
| hull           | Integer      | Hull points.                                           |
| structure      | Integer      | Structure points.                                      |
| actions        | Integer      | Action points.                                         |
| gu             | Integer      | Gunnery skill (e.g., 4 for 4+).                        |
| pi             | Integer      | Piloting skill.                                        |
| ew             | Integer      | Electronic Warfare skill.                              |
| weapons        | List<String> | List of weapon codes (e.g., "LAC", "LLC/LFC").         |
| traits         | List<String> | List of traits (e.g., "Hands", "Sensor:24").           |
| height         | Number       | Unit height in inches.                                 |
| classification | String       | e.g., "Gear", "Strider", "Vehicle".                    |
| subtype        | String       | (Optional) Description of unit type.                   |
| manufacturer   | String       | (Optional) Unit manufacturer.                          |
| description    | String       | (Optional) Background text.                            |
| variants       | List<Object> | List of Variant objects.                               |
| upgrades       | List<Object> | List of Upgrade objects.                               |

### Movement Object
| Field | Type         | Description                                             |
|-------|--------------|---------------------------------------------------------|
| types | List<String> | Abbreviations: "W" (Walker), "G" (Ground), "H" (Hover). |
| value | Integer      | Movement speed in inches.                               |

### Variant Object
Overrides or adds to base unit fields.
| Field | Type | Description |
|---|---|---|
| id | String | Unique identifier for the variant (e.g., "north-hunter-stock"). |
| name | String | Display name. |
| tv | Integer | TV cost adjustment relative to base (can be 0). |
| roles | List<String> | (Optional) Overrides base roles. |
| movement | Object | (Optional) Overrides base movement. |
| armor | Integer | (Optional) Overrides base armor. |
| ... | ... | Other fields follow the same pattern as Unit. |

### Upgrade Object
| Field       | Type         | Description                                          |
|-------------|--------------|------------------------------------------------------|
| id          | String       | Unique identifier (e.g., "north-hunter-flakjacket"). |
| name        | String       | Display name.                                        |
| description | String       | (Optional) Description of the upgrade.               |
| tv          | Integer      | TV cost adjustment.                                  |
| hull        | Integer      | (Optional) New hull value.                           |
| structure   | Integer      | (Optional) New structure value.                      |
| traits      | List<String> | (Optional) Traits to add.                            |
| weapons     | List<String> | (Optional) Weapons to add.                           |

## Weapons

Weapon data is stored in `assets/data/weapons/weapons.json`.

### Root Object (List)
The root is a list of Weapon objects.

### Weapon Object
| Field     | Type         | Description                                                   |
|-----------|--------------|---------------------------------------------------------------|
| code      | String       | Base weapon code without size prefix (e.g., "AC", "LLC").     |
| name      | String       | Display name of the weapon.                                   |
| range     | Object       | Range definition (see below).                                 |
| damage    | Object       | Damage bands by size (see below).                             |
| modes     | List<String> | List of weapon modes: "direct", "indirect".                   |
| traits    | List<String> | List of primary traits (e.g., "AP:1", "Guided").              |
| altTraits | List<String> | List of alternate traits that can be used instead of primary. |

### Weapon Range Object
| Field | Type    | Description                                            |
|-------|---------|--------------------------------------------------------|
| min   | Integer | Minimum range in inches.                               |
| opt   | Integer | Optimal/Normal range in inches.                        |
| max   | Integer | Maximum range in inches (can be `null` for unlimited). |

### Weapon Damage Object
Damage values assigned based on the weapon's size prefix (L, M, H).
| Field | Type | Description |
|---|---|---|
| l | Integer | Damage for Light (L) version. |
| m | Integer | Damage for Medium (M) version. |
| h | Integer | Damage for Heavy (H) version. |
