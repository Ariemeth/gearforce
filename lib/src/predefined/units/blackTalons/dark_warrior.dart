import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement_type.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/model_base.dart';
import 'package:gearforce/src/models/roster/unit/unit_upgrade.dart';
import 'package:gearforce/src/models/roster/unit/upgrade_option.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';
import 'package:gearforce/src/models/roster/weapon/weapon.dart' show Weapon;
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:gearforce/src/predefined/mod_functions.dart';
import 'package:gearforce/src/predefined/units/blackTalons/unit_ids.dart';

Unit createDarkWarrior() {
  final base = ModelBase(
    'Dark Warrior',
    tv: 7,
    roles: {Role.gp, Role.sk, Role.fs},
    movement: Movement([MovementType.walker, MovementType.ground], 6),
    armor: Armor(6),
    hullStructure: HullStructure(hull: 4, structure: 2),
    actions: UnitActions(1),
    gu: Skill(4),
    pi: Skill(4),
    ew: Skill(5),
    weapons: [
      Weapon.lc(WeaponSize.light, hasReact: true),
      Weapon.fc(WeaponSize.light, hasReact: true),
      Weapon.rp(WeaponSize.light, hasReact: false),
      Weapon.apgl(WeaponSize.light, hasReact: false),
    ],
    traits: [Trait.hands(), Trait.stealth(isAux: true)],
    height: 1.5,
  );

  return Unit(
    base,
    name: 'Dark Warrior',
    id: darkWarriorId,
    classification: Classification.gear,
    subtype: 'Trooper Gear',
    manufacturer: 'Black Talon Werks',
    description:
        'Talon commanders have noticed a need to have the option to at least hold territory for extended periods of time. So, they looked at more mass produced option so that they can get the numbers needed to hold positions without utilizing some of their higher end assets. The Dark Warrior does this in spades.',
    variants: [Variant('Stock', id: '0', tv: 0)],
    upgrades: [
      UnitUpgrade(
        'Spectre',
        id: '0',
        tvMod: createIntAdjustmentMod(1),
        ewMod: createSkillAdjustmentMod(4),
        traitsMod: createAddTraitsMod([
          Trait.ecm(),
          Trait.sensor(isAux: true, level: 24),
        ]),
      ),
      UnitUpgrade(
        'Flak Jacket',
        id: '1',
        tvMod: createIntAdjustmentMod(1),
        hullStructureMod: createHullStructureSetMod(h: 6, s: 2),
      ),
      UnitUpgrade(
        'Swap1',
        id: '2',
        description: 'Swap the LAC for one of the following weapons:',
        tvMod: createIntAdjustmentMod(0),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['MFC', 'LSMG']),
      ),
    ],
  );
}
