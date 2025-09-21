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
        single: (s) => s.copyWith(),
        combo: (c) => c.copyWith(),
      );
      copied.add(clone);
    }
    return List<WeaponSpec>.unmodifiable(copied);
  }

  /// Returns all weapons where `isReact` is true.
  List<WeaponSpec> get reactWeapons =>
      where((ws) => ws.weapons.any((w) => w.isReact)).toList();

  /// Returns all weapons where `isReact` is false (mounted weapons).
  List<WeaponSpec> get mountedWeapons =>
      where((ws) => ws.weapons.any((w) => !w.isReact)).toList();
}
