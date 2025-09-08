import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/trait/trait_type.dart';
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
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:gearforce/src/predefined/mod_functions.dart';
import 'package:gearforce/src/predefined/units/north/unit_ids.dart';
import 'package:gearforce/src/predefined/weapon_factory.dart';

Unit createHunter() {
  final baseModel = ModelBase(
    'Hunter',
    tv: 6,
    roles: const {Role.gp, Role.sk, Role.fs},
    movement: const Movement([MovementType.walker, MovementType.ground], 6),
    armor: const Armor(6),
    hullStructure: const HullStructure(hull: 4, structure: 2),
    actions: const UnitActions(1),
    gu: const Skill(4),
    pi: const Skill(4),
    ew: const Skill(6),
    weapons: const [],
    traits: [Trait.hands()],
    height: 1.5,
  );

  return Unit(
    baseModel,
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
          WeaponFactory.createAPGL(WeaponSize.light),
        ],
        traits: [Trait.climb()],
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
        traits: [Trait.sensor(level: 24)],
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
      UnitUpgrade(
        'Flak Jacket',
        id: '0',
        tvMod: createIntAdjustmentMod(1),
        hullStructureMod: createHullStructureSetMod(h: 6, s: 2),
      ),
      UnitUpgrade(
        'Spearhead',
        id: '1',
        tvMod: createIntAdjustmentMod(1),
        traitsMod: createAddTraitsMod([
          Trait.satUp(),
          Trait.eccm(),
          Trait.initPlus(),
          Trait.vuln(type: TraitType.h),
        ]),
      ),
      UnitUpgrade(
        'Swap1',
        id: '2',
        description: 'Swap the LAC for one of the following weapons:',
        tvMod: createIntAdjustmentMod(0),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
        upgradeOption: UpgradeOption(optionsGenerator: () => ['MFC', 'LSMG']),
      ),
      // Upgrade(
      //   'Swap2',
      //   id: '3',
      //   description: 'Swap the LAC for one of the following weapons:',
      //   tvMod: createIntAdjustmentMod(1),
      //   weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
      //   upgradeOption: UpgradeOption(
      //     optionsGenerator: () => ['MAC', 'MRF', 'LGL', 'MBZ', 'LRBZ'],
      //   ),
      // ),
      // Upgrade(
      //   'Swap3',
      //   id: '4',
      //   description: 'Swap the LAC for one of the following weapons:',
      //   tvMod: createIntAdjustmentMod(2),
      //   weaponsMod: createSwapWeaponsFromOptionsMod('LAC', true),
      //   upgradeOption: UpgradeOption(
      //     optionsGenerator: () => ['HAC', 'MSC', 'MGL'],
      //   ),
      // ),
      // Upgrade(
      //   'Add LBZ',
      //   id: '5',
      //   description: 'Add the following weapon: LBZ',
      //   tvMod: createIntAdjustmentMod(1),
      //   weaponsMod: createAddWeaponsMod([
      //     WeaponFactory.createBZ(WeaponSize.light),
      //   ]),
      // ),
      // Upgrade(
      //   'Swap4',
      //   id: '6',
      //   description: 'Swap the LRP for the following weapon:',
      //   tvMod: createIntAdjustmentMod(1),
      //   weaponsMod: createSwapWeaponsFromOptionsMod('LRP', false),
      //   upgradeOption: UpgradeOption(optionsGenerator: () => ['MRP']),
      // ),
      // Upgrade(
      //   'Swap5',
      //   id: '7',
      //   description: 'Swap the LRP for the following weapon:',
      //   tvMod: createIntAdjustmentMod(2),
      //   weaponsMod: createSwapWeaponsFromOptionsMod('LRP', false),
      //   upgradeOption: UpgradeOption(optionsGenerator: () => ['LATM (LA:2)']),
      // ),
      // Upgrade(
      //   'Add HIM',
      //   id: '8',
      //   description: 'Add the following weapon: HIM',
      //   tvMod: createIntAdjustmentMod(1),
      //   weaponsMod: createAddWeaponsMod([
      //     WeaponFactory.createIM(WeaponSize.heavy),
      //   ]),
      // ),
      // Upgrade(
      //   'Add Supply',
      //   id: '9',
      //   description: 'Add the following trait: Supply',
      //   tvMod: createIntAdjustmentMod(1),
      //   traitsMod: createAddTraitsMod([Trait.supply()]),
      // ),
    ],
  );
}
