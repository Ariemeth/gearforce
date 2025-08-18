import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement_type.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/unit_base.dart';
import 'package:gearforce/src/models/roster/unit/upgrade.dart';
import 'package:gearforce/src/models/roster/unit/upgrade_option.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:gearforce/src/predefined/mod_functions.dart';
import 'package:gearforce/src/predefined/trait_factory.dart';
import 'package:gearforce/src/predefined/units/blackTalons/unit_ids.dart';
import 'package:gearforce/src/predefined/weapon_factory.dart';

Unit createDarkWarrior() {
  return Unit(
    UnitBase(
      'Dark Warrior',
      tv: 7,
      roles: {Role.gp, Role.sk, Role.fs},
      movement: Movement([MovementType.walker, MovementType.ground], 6),
      armor: Armor(6),
      hullStructure: HullStructure(hull: 4, structure: 2),
      actions: UnitActions(1),
      gu: Skill(4),
      pi: Skill(4),
      ew: Skill(6),
      weapons: [
        WeaponFactory.createLC(WeaponSize.light, hasReact: true),
        WeaponFactory.createFC(WeaponSize.light, hasReact: true),
        WeaponFactory.createRP(WeaponSize.light, hasReact: false),
        WeaponFactory.createAPGL(WeaponSize.light, hasReact: false)
      ],
      traits: [TraitFactory.hands(), TraitFactory.stealth(isAux: true)],
      height: 1.5,
    ),
    name: 'Dark Warrior',
    id: darkWarriorId,
    classification: Classification.gear,
    subtype: 'Trooper Gear',
    manufacturer: 'Black Talon Werks',
    description:
        'Talon commanders have noticed a need to have the option to at least hold territory for extended periods of time. So, they looked at more mass produced option so that they can get the numbers needed to hold positions without utilizing some of their higher end assets. The Dark Warrior does this in spades.',
    variants: [Variant('Stock', id: '0', tv: 0)],
    upgrades: [
      Upgrade('Spectre',
          id: '0',
          tvMod: createIntAdjustmentMod(1),
          ewMod: createSkillAdjustmentMod(4),
          traitsMod: createAddTraitsMod([
            TraitFactory.ecm(),
            TraitFactory.sensor(isAux: true, level: 24),
          ])),
      Upgrade(
        'Flak Jacket',
        id: '1',
        tvMod: createIntAdjustmentMod(1),
        hullStructureMod: createHullStructureSetMod(h: 6, s: 2),
      ),
      Upgrade(
        'Swap1',
        id: '2',
        description: 'Swap the LAC for one of the following weapons:',
        tvMod: createIntAdjustmentMod(0),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['MFC', 'LSMG']),
      ),
      Upgrade(
        'Swap2',
        id: '3',
        description: 'Swap the LAC for one of the following weapons:',
        tvMod: createIntAdjustmentMod(1),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
        upgradeOption: UpgradeOption(
            optionsGenerator: () => ['MAC', 'MRF', 'LGL', 'MBZ', 'LRBZ']),
      ),
      Upgrade(
        'Swap3',
        id: '4',
        description: 'Swap the LAC for one of the following weapons:',
        tvMod: createIntAdjustmentMod(2),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
        upgradeOption:
            UpgradeOption(optionsGenerator: () => ['HAC', 'MSC', 'MGL']),
      ),
      Upgrade(
        'Add LBZ',
        id: '5',
        description: 'Add the following weapon: LBZ',
        tvMod: createIntAdjustmentMod(1),
        weaponsMod:
            createAddWeaponsMod([WeaponFactory.createBZ(WeaponSize.light)]),
      ),
      Upgrade(
        'Swap4',
        id: '6',
        description: 'Swap the LRP for the following weapon:',
        tvMod: createIntAdjustmentMod(1),
        weaponsMod: createSwapWeaponsFromOptionsMod('LRP', false),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['MRP']),
      ),
      Upgrade(
        'Swap5',
        id: '7',
        description: 'Swap the LRP for the following weapon:',
        tvMod: createIntAdjustmentMod(2),
        weaponsMod: createSwapWeaponsFromOptionsMod('LRP', false),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['LATM (LA:2)']),
      ),
      Upgrade(
        'Add HIM',
        id: '8',
        description: 'Add the following weapon: HIM',
        tvMod: createIntAdjustmentMod(1),
        weaponsMod:
            createAddWeaponsMod([WeaponFactory.createIM(WeaponSize.heavy)]),
      ),
      Upgrade('Add Supply',
          id: '9',
          description: 'Add the following trait: Supply',
          tvMod: createIntAdjustmentMod(1),
          traitsMod: createAddTraitsMod([TraitFactory.supply()]))
    ],
  );
}
