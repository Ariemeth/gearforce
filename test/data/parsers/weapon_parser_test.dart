import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/parsers/weapon_parser.dart';
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
import 'package:gearforce/domain/entities/unit/upgrade_option.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/modifiers/mod_functions.dart';

void main() {
  group('WeaponParser.parseWeaponString', () {
    test('should parse a weapon string without traits', () {
      // Arrange
      const input = 'LAC'; // Light Autocannon

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      expect(weapons.length, 1);
      final weapon = weapons.first;
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
      );
    });

    test('should parse a weapon string with traits', () {
      // Arrange
      const input = 'LAC (Precise, LA:2)';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      expect(weapons.length, 1);
      final weapon = weapons.first;
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.primaryTraits.length,
        greaterThan(0),
        reason: 'Weapon should have primary traits',
      );
      expect(
        weapon.weapons.first.primaryTraits.any(
          (trait) => trait.name == 'Precise',
        ),
        true,
        reason: 'Weapon should have the "Precise" trait',
      );
      expect(
        weapon.weapons.first.primaryTraits.any((trait) => trait.name == 'LA'),
        true,
        reason: 'Weapon should have the "LA" trait',
      );
    });

    test('should parse a weapon string with "2 x" prefix into 2 weapons', () {
      // Arrange
      const input = '2 x LAC';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      expect(weapons.length, 2, reason: '2x weapon should count as 2 weapons');
      expect(weapons[0].code, 'LAC');
      expect(weapons[1].code, 'LAC');
      expect(
        weapons[0].weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
      );
      expect(
        weapons[1].weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
      );
    });

    test('should parse "2x" prefix with traits into 2 weapons', () {
      // Arrange
      const input = '2x LATM (LA:2)';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons.length, 2, reason: '2x weapon should count as 2 weapons');
      expect(weapons[0].code, 'LATM');
      expect(weapons[1].code, 'LATM');
      expect(
        weapons[0].weapons.first.primaryTraits.any((t) => t.name == 'LA'),
        true,
      );
      expect(
        weapons[1].weapons.first.primaryTraits.any((t) => t.name == 'LA'),
        true,
      );
    });

    test('should throw ArgumentError for an invalid weapon code', () {
      // Arrange
      const input = 'INVALID';

      // Act & Assert
      expect(
        () => WeaponParser.parseWeaponString(input),
        throwsA(isA<ArgumentError>()),
        reason: 'Invalid weapon code should throw ArgumentError',
      );
    });

    test('should parse a weapon string with alternate traits', () {
      // Arrange
      const input = 'LAC (Precise, LA:2)';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      final weapon = weapons.first;
      expect(
        weapon.weapons.first.alternateTraits,
        isNotNull,
        reason: 'Weapon should have alternate traits',
      );
      expect(
        weapon.weapons.first.alternateTraits.any(
          (trait) => trait.name == 'Precise',
        ),
        true,
        reason: 'Weapon should have the "Precise" alternate trait',
      );
    });

    test('should handle a weapon string with no traits', () {
      // Arrange
      const input = 'MAC'; // Medium Autocannon

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      final weapon = weapons.first;
      expect(weapon.code, 'MAC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
      );
    });

    test('should parse a weapon with alternate traits', () {
      // Arrange
      const input = 'LAC (AA, LA:2)';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      final weapon = weapons.first;
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.alternateTraits,
        isNotNull,
        reason: 'Weapon should have alternate traits',
      );
      expect(
        weapon.weapons.first.alternateTraits.any(
          (trait) => trait.name == 'Precise',
        ),
        true,
        reason: 'Weapon should have the "Precise" alternate trait',
      );
      expect(
        weapon.weapons.first.alternateTraits.any((trait) => trait.name == 'LA'),
        true,
        reason: 'Weapon should have the "LA" alternate trait',
      );
      expect(
        weapon.weapons.first.alternateTraits.any((trait) => trait.name == 'AA'),
        true,
        reason: 'Weapon should have the "AA" alternate trait',
      );
    });

    test('should handle a combo weapon string with no traits', () {
      // Arrange
      const input = 'LAC/LFC';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      final weapon = weapons.first;
      expect(weapon.code, 'LAC/LFC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
      );
      expect(
        weapon.weapons.last.name,
        'Frag Cannon',
        reason: 'Weapon name should be correct',
      );
    });

    test('should handle a combo weapon string with custom traits', () {
      // Arrange
      const input = 'LAC/LFC (AA, LA:2)';

      // Act
      final weapons = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapons, isNotNull);
      final weapon = weapons.first;
      expect(weapon.code, 'LAC/LFC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
      );
      expect(
        weapon.weapons.last.name,
        'Frag Cannon',
        reason: 'Weapon name should be correct',
      );
      expect(
        weapon.weapons.first.primaryTraits.any((t) => t.name == 'AA'),
        true,
      );
      expect(
        weapon.weapons.first.alternateTraits.any((t) => t.name == 'AA'),
        true,
      );
      expect(
        weapon.weapons.last.primaryTraits.any((t) => t.name == 'AA'),
        true,
      );
    });

    test('2x weapon allows upgrading each weapon independently on a Model', () {
      // Arrange: Model base with "2 x LAC" in mountedWeapons
      final base = ModelBase(
        'Test Model',
        unitId: 'test-unit',
        tv: 6,
        roles: {Role.gp},
        movement: const Movement([MovementType.walker], 6),
        armor: const Armor(5),
        hullStructure: const HullStructure(hull: 4, structure: 2),
        actions: const UnitActions(1),
        gu: const Skill(4),
        pi: const Skill(4),
        ew: const Skill(6),
        height: 1.5,
        subtype: 'Gear',
        classification: Classification.gear,
        mountedWeapons: WeaponParser.parseWeaponString('2 x LAC'),
      );

      final model = Model(
        id: 1,
        base: base,
        variant: const Variant('Test Variant', id: 'var-1', tv: 0),
      );

      // Verify the model starts with 2 LAC weapons
      expect(model.weapons.length, 2);
      expect(model.weapons[0].code, 'LAC');
      expect(model.weapons[1].code, 'LAC');

      // First upgrade: Swap a LAC for MAC
      final upgrade1 = ModelUpgrade(
        'Upgrade Weapon 1',
        id: 'up-1',
        type: UpgradeType.profile,
        upgradeOption: UpgradeOption(
          optionsGenerator: () => ['MAC'],
          selectedOption: 'MAC',
        ),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', false),
      );

      final modelUpgradedOnce = model.addModelUpgrade(upgrade1);

      // Assert: The first LAC is swapped to MAC, the second remains LAC
      expect(modelUpgradedOnce.weapons.length, 2);
      expect(modelUpgradedOnce.weapons[0].code, 'MAC');
      expect(modelUpgradedOnce.weapons[1].code, 'LAC');

      // Second upgrade: Swap the remaining LAC for HAC
      final upgrade2 = ModelUpgrade(
        'Upgrade Weapon 2',
        id: 'up-2',
        type: UpgradeType.profile,
        upgradeOption: UpgradeOption(
          optionsGenerator: () => ['HAC'],
          selectedOption: 'HAC',
        ),
        weaponsMod: createSwapWeaponsFromOptionsMod('LAC', false),
      );

      final modelUpgradedTwice = modelUpgradedOnce.addModelUpgrade(upgrade2);

      // Assert: The second LAC is swapped to HAC
      expect(modelUpgradedTwice.weapons.length, 2);
      expect(modelUpgradedTwice.weapons[0].code, 'MAC');
      expect(modelUpgradedTwice.weapons[1].code, 'HAC');
    });
  });
}
