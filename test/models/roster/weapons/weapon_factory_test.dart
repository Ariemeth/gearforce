import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:gearforce/src/predefined/weapon_factory.dart';

void main() {
  group('WeaponFactory.getWeaponByCode', () {
    test('should return a weapon for a valid code with hasReact = false', () {
      // Arrange
      const weaponCode = 'LAC'; // Light Autocannon
      const hasReact = false;

      // Act
      final weapon =
          WeaponFactory.getWeaponByCode(weaponCode, hasReact: hasReact);

      // Assert
      expect(weapon, isNotNull);
      expect(weapon!.code, weaponCode);
      expect(weapon.isReact, hasReact);
    });

    test('should return a weapon for a valid code with hasReact = true', () {
      // Arrange
      const weaponCode = 'MAC'; // Medium Autocannon
      const hasReact = true;

      // Act
      final weapon =
          WeaponFactory.getWeaponByCode(weaponCode, hasReact: hasReact);

      // Assert
      expect(weapon, isNotNull);
      expect(weapon!.code, weaponCode);
      expect(weapon.isReact, hasReact);
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
      final expectedWeapon = WeaponFactory.createAC(WeaponSize.heavy);

      // Assert
      expect(weapon, isNotNull);
      expect(weapon!.code, weaponCode);
      expect(weapon.damage, expectedWeapon.damage);
    });
  });
}
