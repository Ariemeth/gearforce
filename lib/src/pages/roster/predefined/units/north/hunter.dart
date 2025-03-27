import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/trait/trait_type.dart';
import 'package:gearforce/src/pages/roster/models/unit/armor.dart';
import 'package:gearforce/src/pages/roster/models/unit/classification.dart';
import 'package:gearforce/src/pages/roster/models/unit/hull_structure.dart';
import 'package:gearforce/src/pages/roster/models/unit/movement.dart';
import 'package:gearforce/src/pages/roster/models/unit/movement_type.dart';
import 'package:gearforce/src/pages/roster/models/unit/skill.dart';
import 'package:gearforce/src/pages/roster/models/unit/unit.dart';
import 'package:gearforce/src/pages/roster/models/unit/unit_actions.dart';
import 'package:gearforce/src/pages/roster/models/unit/unit_base.dart';
import 'package:gearforce/src/pages/roster/models/unit/upgrade.dart';
import 'package:gearforce/src/pages/roster/models/unit/upgrade_option.dart';
import 'package:gearforce/src/pages/roster/models/unit/variant.dart';
import 'package:gearforce/src/pages/roster/models/weapon/weapon_size.dart';
import 'package:gearforce/src/pages/roster/predefined/mod_functions.dart';
import 'package:gearforce/src/pages/roster/predefined/trait_factory.dart';
import 'package:gearforce/src/pages/roster/predefined/units/north/unit_ids.dart'
    show hunterId;
import 'package:gearforce/src/pages/roster/predefined/weapon_factory.dart';

Unit createHunter() {
  return Unit(
    UnitBase(
      'Hunter',
      tv: 6,
      roles: {Role.gp, Role.sk, Role.fs},
      movement: Movement([MovementType.walker, MovementType.ground], 6),
      armor: Armor(6),
      hullStructure: HullStructure(hull: 4, structure: 2),
      actions: UnitActions(1),
      gu: Skill(4),
      pi: Skill(4),
      ew: Skill(6),
      weapons: const [],
      traits: [TraitFactory.hands()],
      height: 1.5,
    ),
    name: 'Hunter',
    id: hunterId,
    classification: Classification.gear,
    subtype: 'Trooper Gear',
    manufacturer: 'Northco',
    description:
        'The Hunter Gear was the first purpose-built combat walker on Terra Nova. It is THE forerunner for all other gear designs on the planet. It remains among the most produced gears still in active service. Refitted several times to keep it competitive, its greatest strengths have always been simplicity and ruggedness.',
    variants: [
      Variant(
        'Stock',
        id: '0',
        tv: 0,
        weapons: [
          WeaponFactory.createAC(WeaponSize.light, hasReact: true),
          WeaponFactory.createVB(WeaponSize.light, hasReact: true),
          WeaponFactory.createRP(WeaponSize.light),
          WeaponFactory.createAPGL(WeaponSize.light),
        ],
      ),
      Variant(
        'Mountain',
        id: '1',
        tv: 1,
        weapons: [
          WeaponFactory.createAC(WeaponSize.light, hasReact: true),
          WeaponFactory.createMW(WeaponSize.medium, hasReact: true),
          WeaponFactory.createRP(WeaponSize.light),
          WeaponFactory.createAPGL(WeaponSize.light)
        ],
        traits: [TraitFactory.climb()],
      ),
      Variant(
        'Pathfinder',
        id: '2',
        tv: 1,
        ew: Skill(5),
        weapons: [
          WeaponFactory.createAC(WeaponSize.light, hasReact: true),
          WeaponFactory.createVB(WeaponSize.light, hasReact: true),
        ],
        traits: [TraitFactory.sensor(level: 24)],
      ),
      Variant(
        'Assault',
        id: '3',
        tv: 1,
        weapons: [
          WeaponFactory.createSC(WeaponSize.medium, hasReact: true),
          WeaponFactory.createVB(WeaponSize.light, hasReact: true),
        ],
      ),
    ],
    upgrades: [
      Upgrade(
        'Armored Jacket',
        id: '0',
        tvMod: createIntAdjustmentMod(1),
        hullStructureMod: createHullStructureSetMod(h: 6, s: 2),
      ),
      Upgrade('Spearhead',
          id: '1',
          tvMod: createIntAdjustmentMod(2),
          ewMod: createSkillAdjustmentMod(5),
          traitsMod: createAddTraitsMod([
            TraitFactory.satUp(),
            TraitFactory.eccm(),
            TraitFactory.initPlus(),
            TraitFactory.vuln(type: TraitType.h),
          ])),
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
        'Swap4',
        id: '5',
        description: 'Swap the LRP for one of the following weapons:',
        tvMod: createIntAdjustmentMod(2),
        weaponsMod: createSwapWeaponsFromOptionsMod('LRP', false),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['MRP']),
      ),
      Upgrade(
        'Swap5',
        id: '6',
        description: 'Swap the LRP for one of the following weapons:',
        tvMod: createIntAdjustmentMod(2),
        weaponsMod: createSwapWeaponsFromOptionsMod('LRP', false),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['LATM (LA:2)']),
      ),
      Upgrade(
        'Add HIM',
        id: '7',
        description: 'Add the following weapon: HIM',
        tvMod: createIntAdjustmentMod(1),
        weaponsMod:
            createAddWeaponsMod([WeaponFactory.createIM(WeaponSize.heavy)]),
      ),
      Upgrade('Add Supply',
          id: '8',
          description: 'Add the following trait: Supply',
          tvMod: createIntAdjustmentMod(1),
          traitsMod: createAddTraitsMod([TraitFactory.supply()]))
    ],
  );
}
