import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_parser.dart';

void main() {
  group('WeaponParser.parseWeaponString', () {
    test('should parse a weapon string without traits', () {
      // Arrange
      const input = 'LAC'; // Light Autocannon

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
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
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
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

    test('should parse a weapon string with "2 x" prefix', () {
      // Arrange
      const input = '2 x LAC';

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.name,
        'Autocannon',
        reason: 'Weapon name should be correct',
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
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
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
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
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
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(
        weapon.weapons.first.alternateTraits,
        isNotNull,
        reason: 'Weapon should have alternate traits',
      );
      // Precise should come from the base LAC as a alternate trait
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
      const input = 'LAC/LFC'; // Medium Autocannon

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
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
      const input = 'LAC/LFC (AA, LA:2)'; // Medium Autocannon

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
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
        reason:
            'First weapon should have custom Trait of AA in the primaryTraits',
      );
      expect(
        weapon.weapons.first.alternateTraits.any((t) => t.name == 'AA'),
        true,
        reason:
            'First weapon should have custom Trait of AA in the alternateTraits',
      );
      expect(
        weapon.weapons.last.primaryTraits.any((t) => t.name == 'AA'),
        true,
        reason:
            'Second weapon should have custom Trait of AA in the primaryTraits',
      );
    });
  });
}
