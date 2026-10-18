import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade_context.dart';
import 'package:gearforce/domain/entities/unit/upgrade_option.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart'
    show DamageSizeBands;
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_mode.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

void main() {
  group('Upgrade', () {
    test('should apply modifications to a model using UpgradeContext', () {
      // Arrange
      const baseModel = ModelBase(
        'Test Model',
        unitId: 'test-unit',
        tv: 10,
        roles: {Role.gp},
        movement: Movement([MovementType.walker], 6),
        armor: Armor(5),
        hullStructure: HullStructure(hull: 4, structure: 3),
        actions: UnitActions(2),
        gu: Skill(4),
        pi: Skill(5),
        ew: Skill(6),
        height: 1.5,
        subtype: '',
        classification: Classification.gear,
      );

      final initialModel = Model(
        id: 0,
        base: baseModel,
        variant: const Variant('Test Model', id: '1', tv: 0),
      );

      final upgrade = ModelUpgrade(
        'Test Upgrade',
        id: 'upgrade-001',
        type: UpgradeType.profile,
        description: 'A test upgrade',
        nameMod: (name, context) => 'Modified ${context.model.name}',
        tvMod: (tv, context) => tv + 5,
        rolesMod: (roles, context) => {...roles, Role.sk},
        movementMod: (movement, context) => const Movement([MovementType.ground], 8),
        armorMod: (armor, context) => const Armor(6),
        hullStructureMod: (hullStructure, context) =>
            hullStructure.copyWith(hull: 5, structure: 4),
        actionsMod: (actions, context) => const UnitActions(3),
        guMod: (gu, context) => const Skill(5),
        piMod: (pi, context) => const Skill(6),
        ewMod: (ew, context) => const Skill(7),
        weaponsMod: (weapons, context) => [
          ...weapons,
          const SingleWeaponSpec(
            weapon: Weapon(
              code: 'W001',
              name: 'Test Weapon',
              size: WeaponSize.light,
              range: WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
              damageBands: DamageSizeBands(l: 7, m: 8, h: 9),
              modes: {WeaponMode.direct},
            ),
          ),
        ],
        traitsMod: (traits, context) => [
          ...traits,
          const Trait(name: 'Test Trait', description: 'A test trait'),
        ],
      );

      final context = ModelUpgradeContext(initialModel, upgrade);

      // Assert
      expect(
        upgrade.nameMod(initialModel.name, context),
        'Modified Test Model',
      );
      expect(upgrade.tvMod(initialModel.tv, context), 15);
      expect(upgrade.rolesMod(initialModel.roles, context), {Role.gp, Role.sk});
      expect(upgrade.movementMod(initialModel.movement, context).value, 8);
      expect(upgrade.movementMod(initialModel.movement, context).types, [
        MovementType.ground,
      ]);
      expect(upgrade.armorMod(initialModel.armor, context).value, 6);
      expect(
        upgrade.hullStructureMod(initialModel.hullStructure, context).hull,
        5,
      );
      expect(
        upgrade.hullStructureMod(initialModel.hullStructure, context).structure,
        4,
      );
      expect(upgrade.actionsMod(initialModel.actions, context).value, 3);
      expect(upgrade.guMod(initialModel.gu, context).value, 5);
      expect(upgrade.piMod(initialModel.pi, context).value, 6);
      expect(upgrade.ewMod(initialModel.ew, context).value, 7);
      expect(upgrade.weaponsMod(initialModel.weapons, context).length, 1);
      expect(
        upgrade.weaponsMod(initialModel.weapons, context).first.weapons[0].name,
        'Test Weapon',
      );
      expect(upgrade.traitsMod(initialModel.traits, context).length, 1);
      expect(
        upgrade.traitsMod(initialModel.traits, context).first.name,
        'Test Trait',
      );
    });

    test('should not modify fields if no modifications are provided', () {
      // Arrange
      const modelBase = ModelBase(
        'Test Model',
        unitId: 'test-unit',
        tv: 10,
        roles: {Role.gp},
        movement: Movement([MovementType.walker], 6),
        armor: Armor(5),
        hullStructure: HullStructure(hull: 4, structure: 3),
        actions: UnitActions(2),
        gu: Skill(4),
        pi: Skill(5),
        ew: Skill(6),
        height: 1.5,
        classification: Classification.gear,
      );

      final initialModel = Model(
        id: 0,
        base: modelBase,
        variant: const Variant('Test Model', id: '1', tv: 0),
      );

      const upgrade = ModelUpgrade(
        'No-Op Upgrade',
        id: 'upgrade-002',
        type: UpgradeType.profile,
        description: 'A no-op upgrade',
      );

      final context = ModelUpgradeContext(initialModel, upgrade);

      // Assert
      expect(upgrade.nameMod(initialModel.name, context), initialModel.name);
      expect(upgrade.tvMod(initialModel.tv, context), initialModel.tv);
      expect(upgrade.rolesMod(initialModel.roles, context), initialModel.roles);
      expect(
        upgrade.movementMod(initialModel.movement, context),
        initialModel.movement,
      );
      expect(upgrade.armorMod(initialModel.armor, context), initialModel.armor);
      expect(
        upgrade.hullStructureMod(initialModel.hullStructure, context),
        initialModel.hullStructure,
      );
      expect(
        upgrade.actionsMod(initialModel.actions, context),
        initialModel.actions,
      );
      expect(upgrade.guMod(initialModel.gu, context), initialModel.gu);
      expect(upgrade.piMod(initialModel.pi, context), initialModel.pi);
      expect(upgrade.ewMod(initialModel.ew, context), initialModel.ew);
      expect(
        upgrade.weaponsMod(initialModel.weapons, context),
        initialModel.weapons,
      );
      expect(
        upgrade.traitsMod(initialModel.traits, context),
        initialModel.traits,
      );
    });

    test('should handle modOption correctly', () {
      // Arrange
      final modOption = UpgradeOption(
        optionsGenerator: () => ['Option 1', 'Option 2'],
        selectedOption: 'Option 1',
      );

      final upgrade = ModelUpgrade(
        'Test Upgrade with Option',
        id: 'upgrade-003',
        type: UpgradeType.profile,
        upgradeOption: modOption,
      );

      // Assert
      expect(upgrade.upgradeOption, isNotNull);
      expect(upgrade.upgradeOption!.optionsGenerator(), [
        'Option 1',
        'Option 2',
      ]);
      expect(upgrade.upgradeOption!.selectedOption, 'Option 1');
    });

    test('should create a modified copy using copyWith', () {
      // Arrange
      final upgrade = ModelUpgrade(
        'Original Upgrade',
        id: 'upgrade-004',
        type: UpgradeType.profile,
        description: 'Original description',
        tvMod: (tv, context) => tv + 2,
      );

      // Act
      final updatedUpgrade = upgrade.copyWith(
        name: 'Updated Upgrade',
        description: 'Updated description',
        tvMod: (tv, context) => tv + 5,
      );

      // Assert
      expect(updatedUpgrade.name, 'Updated Upgrade');
      expect(updatedUpgrade.id, 'upgrade-004'); // ID should remain unchanged
      expect(updatedUpgrade.description, 'Updated description');
      expect(
        updatedUpgrade.tvMod(
          10,
          ModelUpgradeContext(
            Model(
              id: 0,
              base: const ModelBase(
                'Test Model',
                unitId: 'test-unit',
                tv: 10,
                roles: {Role.gp},
                movement: Movement([MovementType.walker], 6),
                armor: Armor(5),
                hullStructure: HullStructure(hull: 4, structure: 3),
                actions: UnitActions(2),
                gu: Skill(4),
                pi: Skill(5),
                ew: Skill(6),
                height: 1.5,
                classification: Classification.gear,
              ),
              variant: const Variant('Test Model', id: '1', tv: 0),
            ),
            updatedUpgrade,
          ),
        ),
        15,
      ); // Updated tvMod logic
    });

    test('should create a modified copy with updated modOption', () {
      // Arrange
      final modOption = UpgradeOption(
        optionsGenerator: () => ['Option 1', 'Option 2'],
        selectedOption: 'Option 1',
      );

      final upgrade = ModelUpgrade(
        'Upgrade with Option',
        id: 'upgrade-005',
        type: UpgradeType.profile,
        upgradeOption: modOption,
      );

      // Act
      final updatedUpgrade = upgrade.copyWith(
        upgradeOption: modOption.copyWith(selectedOption: 'Option 2'),
      );

      // Assert
      expect(updatedUpgrade.upgradeOption!.selectedOption, 'Option 2');
      expect(updatedUpgrade.upgradeOption!.optionsGenerator(), [
        'Option 1',
        'Option 2',
      ]);
    });
  });
}
