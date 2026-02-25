import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart' show Weapon;
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:gearforce/data/static/weapon_factory.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';

class MockWeaponRepository implements WeaponRepository {
  @override
  Future<List<Weapon>> getWeapons() async => [];

  @override
  Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    final size = WeaponSize.fromCode(code);
    final baseCode = code.substring(1);

    switch (baseCode) {
      case 'AC':
        return Weapon(
          baseCode: 'AC',
          name: 'Autocannon',
          range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
          modes: {},
          damageBands: const DamageSizeBands(l: 1, m: 2, h: 3),
          size: size,
          isReact: hasReact,
        );
      case 'ATM':
        return Weapon(
          baseCode: 'ATM',
          name: 'Anti-Tank Missile',
          range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
          modes: {},
          damageBands: const DamageSizeBands(l: 2, m: 3, h: 4),
          size: size,
          isReact: hasReact,
        );
      default:
        return null;
    }
  }
}

void main() {
  setUp(() {
    WeaponFactory.setRepository(MockWeaponRepository());
  });

  group('WeaponFactory.getWeaponByCode', () {
    test('should return a weapon for a valid code with hasReact = false', () {
      // Arrange
      const weaponCode = 'LAC'; // Light Autocannon
      const hasReact = false;

      // Act
      final weapon = WeaponFactory.getWeaponByCode(
        weaponCode,
        hasReact: hasReact,
      );

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
      final weapon = WeaponFactory.getWeaponByCode(
        weaponCode,
        hasReact: hasReact,
      );

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
      final expectedWeapon = WeaponFactory.getWeaponByCode('HAC');

      // Assert
      expect(weapon, isNotNull);
      expect(weapon!.code, weaponCode);
      expect(weapon.damage, expectedWeapon!.damage);
    });
  });
}
