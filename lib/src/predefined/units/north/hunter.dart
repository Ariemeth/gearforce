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
import 'package:gearforce/src/models/roster/weapon/weapon.dart' show Weapon;
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:gearforce/src/predefined/mod_functions.dart';
import 'package:gearforce/src/predefined/units/north/unit_ids.dart';

Unit createHunter() {
  const baseModel = ModelBase(
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
    weapons: [],
    traits: [Trait.hands()],
    height: 1.5,
  );

  return Unit(
    baseModel,
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
        weapons: const [
          SingleWeaponSpec(weapon: Weapon.ac(WeaponSize.light, hasReact: true)),
          SingleWeaponSpec(weapon: Weapon.vb(WeaponSize.light, hasReact: true)),
          SingleWeaponSpec(weapon: Weapon.rp(WeaponSize.light)),
          SingleWeaponSpec(weapon: Weapon.apgl(WeaponSize.light)),
        ],
      ),
      Variant(
        'Mountain',
        id: '1',
        tv: 1,
        weapons: const [
          SingleWeaponSpec(weapon: Weapon.ac(WeaponSize.light, hasReact: true)),
          SingleWeaponSpec(
            weapon: Weapon.mw(WeaponSize.medium, hasReact: true),
          ),
          SingleWeaponSpec(weapon: Weapon.rp(WeaponSize.light)),
          SingleWeaponSpec(weapon: Weapon.apgl(WeaponSize.light)),
        ],
        traits: const [Trait.climb()],
      ),
      Variant(
        'Pathfinder',
        id: '2',
        tv: 1,
        ew: const Skill(5),
        weapons: const [
          SingleWeaponSpec(weapon: Weapon.ac(WeaponSize.light, hasReact: true)),
          SingleWeaponSpec(weapon: Weapon.vb(WeaponSize.light, hasReact: true)),
        ],
        traits: const [Trait.sensor(level: 24)],
      ),
      Variant(
        'Assault',
        id: '3',
        tv: 1,
        weapons: const [
          SingleWeaponSpec(
            weapon: Weapon.sc(WeaponSize.medium, hasReact: true),
          ),
          SingleWeaponSpec(weapon: Weapon.vb(WeaponSize.light, hasReact: true)),
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
          const Trait.satUp(),
          const Trait.eccm(),
          const Trait.initPlus(),
          const Trait.vuln(type: TraitType.h),
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
