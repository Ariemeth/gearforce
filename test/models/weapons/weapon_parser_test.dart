import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/pages/roster/models/weapon/weapon_parser.dart';

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
      expect(weapon.name, 'Autocannon',
          reason: 'Weapon name should be correct');
    });

    test('should parse a weapon string with traits', () {
      // Arrange
      const input = 'LAC (Precise, LA:2)';

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(weapon.primaryTraits.length, greaterThan(0),
          reason: 'Weapon should have primary traits');
      expect(weapon.primaryTraits.any((trait) => trait.name == 'Precise'), true,
          reason: 'Weapon should have the "Precise" trait');
      expect(weapon.primaryTraits.any((trait) => trait.name == 'LA'), true,
          reason: 'Weapon should have the "LA" trait');
    });

    test('should parse a weapon string with "2 x" prefix', () {
      // Arrange
      const input = '2 x LAC';

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(weapon.name, 'Autocannon',
          reason: 'Weapon name should be correct');
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

    test('should parse a weapon string with secondary traits', () {
      // Arrange
      const input = 'LAC (Precise, LA:2)';

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.secondaryTraits, isNotNull,
          reason: 'Weapon should have secondary traits');
      expect(
          weapon.secondaryTraits!.any((trait) => trait.name == 'Precise'), true,
          reason: 'Weapon should have the "Precise" secondary trait');
    });

    test('should handle a weapon string with no traits', () {
      // Arrange
      const input = 'MAC'; // Medium Autocannon

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.code, 'MAC', reason: 'Weapon code should match input');
      expect(weapon.name, 'Autocannon',
          reason: 'Weapon name should be correct');
    });

    test('should parse a weapon with secondary traits', () {
      // Arrange
      const input = 'LAC (Precise, LA:2)';

      // Act
      final weapon = WeaponParser.parseWeaponString(input);

      // Assert
      expect(weapon, isNotNull, reason: 'Weapon should not be null');
      expect(weapon.code, 'LAC', reason: 'Weapon code should match input');
      expect(weapon.secondaryTraits, isNotNull,
          reason: 'Weapon should have secondary traits');
      expect(
          weapon.secondaryTraits!.any((trait) => trait.name == 'Precise'), true,
          reason: 'Weapon should have the "Precise" secondary trait');
      expect(weapon.secondaryTraits!.any((trait) => trait.name == 'LA'), true,
          reason: 'Weapon should have the "LA" secondary trait');
    });
  });
}
