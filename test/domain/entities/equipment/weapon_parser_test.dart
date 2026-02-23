import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_parser.dart';
import 'package:gearforce/data/static/weapon_factory.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
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
          primaryTraits: [],
          alternateTraits: [Trait(name: 'Precise')],
        );
      case 'FRC':
      case 'FC':
        return Weapon(
          baseCode: baseCode,
          name: 'Frag Cannon',
          range: const WeaponRange(minOptimal: 0, maxOptimal: 6, max: 12),
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
