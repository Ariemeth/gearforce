import 'package:gearforce/src/pages/roster/models/weapon.dart';

extension WeaponListExtensions on List<Weapon> {
  /// Returns all weapons where `isReact` is true.
  List<Weapon> get reactWeapons => where((weapon) => weapon.isReact).toList();

  /// Returns all weapons where `isReact` is false (mounted weapons).
  List<Weapon> get mountedWeapons =>
      where((weapon) => !weapon.isReact).toList();
}
