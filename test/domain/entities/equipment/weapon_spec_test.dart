import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart' show Trait;
import 'package:gearforce/domain/entities/equipment/weapon.dart' show Weapon;
import 'package:gearforce/domain/entities/equipment/weapon_size.dart'
    show WeaponSize;
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart'
    show SingleWeaponSpec, ComboWeaponSpec;

void main() {
  final wacL = Weapon.ac(WeaponSize.light);
  final watmL = Weapon.atm(WeaponSize.light);

  group('WeaponV2.SingleWeaponSpec', () {
    test('SingleWeaponSpec creation no custom traits', () {
      // Arrange
      var w1 = wacL;
      var ws = SingleWeaponSpec(weapon: w1);

      // Act & Assert
      expect(
        ws.isCombo,
        false,
        reason: 'Should not be a combo weapon as it only has 1',
      );
      expect(
        ws.customTraits.isEmpty,
        true,
        reason: 'There should not be any custom traits',
      );
      expect(
        ws.weapons.any((w) => w.code == w1.code),
        true,
        reason:
            'w1 should be in the SingleWeaponSpec as it was added during creation',
      );
    });
    test('SingleWeaponSpec creation with custom traits', () {
      // Arrange
      var w1 = wacL;
      var t1 = const Trait.aa();
      var ws = SingleWeaponSpec(weapon: w1, customTraits: [t1]);

      // Act & Assert
      expect(
        ws.isCombo,
        false,
        reason: 'Should not be a combo weapon as it only has 1',
      );
      expect(
        ws.customTraits.isEmpty,
        false,
        reason: 'There should not a custom trait',
      );
      expect(
        ws.customTraits.any((t) => t == t1),
        true,
        reason: 'The custom trait should be a part of the SingleWeaponSpec',
      );
      expect(
        ws.weapons.any((w) => w.primaryTraits.contains(t1)),
        true,
        reason: 'The weapon should also have the custom trait',
      );
      expect(
        ws.weapons.every((w) => w.code == w1.code),
        true,
        reason:
            'w1 should be in the SingleWeaponSpec as it was added during creation',
      );
    });
  });
  group('WeaponV2.ComboWeaponSpec', () {
    test('ComboWeaponSpec creation no custom traits', () {
      // Arrange
      var w1 = wacL;
      var w2 = watmL;
      var ws = ComboWeaponSpec(weapon1: w1, weapon2: w2);

      // Act & Assert
      expect(ws.isCombo, true, reason: 'Should be a combo weapon');
      expect(
        ws.customTraits.isEmpty,
        true,
        reason: 'There should not be any custom traits',
      );
      expect(
        ws.weapons.any((w) => w.code == w1.code),
        true,
        reason:
            'w1 should be in the SingleWeaponSpec as it was added during creation',
      );
      expect(
        ws.weapons.any((w) => w.code == w2.code),
        true,
        reason:
            'w2 should be in the SingleWeaponSpec as it was added during creation',
      );
    });
    test('ComboWeaponSpec creation with custom traits', () {
      // Arrange
      var w1 = wacL;
      var w2 = watmL;
      var t1 = const Trait.aa();
      var ws = ComboWeaponSpec(weapon1: w1, weapon2: w2, customTraits: [t1]);

      // Act & Assert
      expect(ws.isCombo, true, reason: 'Should be a combo weapon');
      expect(
        ws.customTraits.isEmpty,
        false,
        reason: 'There should be a custom trait',
      );
      expect(
        ws.weapons.any((w) => w.code == w1.code),
        true,
        reason:
            'w1 should be in the ComboWeaponSpec as it was added during creation',
      );
      expect(
        ws.weapons.any((w) => w.code == w2.code),
        true,
        reason:
            'w2 should be in the ComboWeaponSpec as it was added during creation',
      );
      expect(
        ws.customTraits.any((t) => t == t1),
        true,
        reason: 'The custom trait should be a part of the ComboWeaponSpec',
      );
      expect(
        ws.weapons.every((w) => w.primaryTraits.contains(t1)),
        true,
        reason: 'every weapon should have the custom trait',
      );
    });
  });
}
