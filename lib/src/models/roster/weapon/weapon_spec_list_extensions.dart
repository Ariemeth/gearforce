import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';

extension WeaponSpecListExtensions on List<WeaponSpec> {
  /// Deep-copies each WeaponSpec:
  /// - SingleWeaponSpec: copies the underlying weapon
  /// - ComboWeaponSpec: copies both underlying weapons
  /// - Preserves customTraits
  List<WeaponSpec> copyWith() {
    final copied = <WeaponSpec>[];
    for (final spec in this) {
      final clone = spec.when(
        single: (s) => SingleWeaponSpec(
          weapon: s.weapon.copyWith(),
          customTraits: List<Trait>.from(s.customTraits),
        ),
        combo: (c) => ComboWeaponSpec(
          weapon1: c.weapon1.copyWith(),
          weapon2: c.weapon2.copyWith(),
          customTraits: List<Trait>.from(c.customTraits),
        ),
      );
      copied.add(clone);
    }
    return List<WeaponSpec>.unmodifiable(copied);
  }
}
