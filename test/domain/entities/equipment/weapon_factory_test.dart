import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/static/weapon_factory.dart';

void main() {
  group('WeaponFactory.getWeaponByCode', () {
    test('should return a weapon for a valid code', () {
      // Arrange
      const weaponCode = 'LAC'; // Light Autocannon

      // Act
      final weapon = WeaponFactory.getWeaponByCode(weaponCode);

      // Assert
      expect(weapon, isNotNull);
      expect(weapon!.code, weaponCode);
    });

    test('should throw ArgumentError for an invalid weapon code', () {
      // Arrange
      const invalidWeaponCode = 'INVALID';

      // Act & Assert
      expect(
        () => WeaponFactory.getWeaponByCode(invalidWeaponCode),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should correctly determine weapon size from the code', () {
      // Arrange
      const weaponCode = 'HAC'; // Heavy Autocannon

      // Act
      final weapon = WeaponFactory.getWeaponByCode(weaponCode);
      final expectedWeapon = WeaponFactory.getWeaponByCode('HAC');

      // Assert
      expect(weapon, isNotNull);
      expect(weapon!.code, weaponCode);
      expect(weapon.damage, expectedWeapon!.damage);
    });
  });
}
