import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/model_base.dart';
import 'package:gearforce/src/models/roster/unit/unit_upgrade.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';
import 'package:gearforce/src/predefined/units/north/unit_ids.dart';

Unit createX() {
  const baseModel = ModelBase(
    'x',
    tv: 0,
    roles: {},
    movement: Movement([], 0),
    armor: Armor(0),
    hullStructure: HullStructure(hull: 0, structure: 0),
    actions: UnitActions(0),
    gu: Skill(0),
    pi: Skill(0),
    ew: Skill(0),
    weapons: [],
    traits: [],
    height: 0,
    classification: Classification.gear,
    subtype: '',
    manufacturer: '',
    description: '',
  );

  return Unit(
    baseModel,
    id: hunterId,
    variants: [Variant('Stock', id: '0', tv: 0, weapons: const [])],
    upgrades: [UnitUpgrade('', id: '0')],
  );
}
