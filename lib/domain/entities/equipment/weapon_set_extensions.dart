import 'package:gearforce/domain/entities/equipment/weapon.dart';

extension WeaponSetExtensions on Set<Weapon> {
  /// Retrieves all weapons where `isReact` is true.
  Set<Weapon> get reactWeapons => where((weapon) => weapon.isReact).toSet();

  /// Retrieves all weapons where `isReact` is false.
  Set<Weapon> get mountedWeapons => where((weapon) => !weapon.isReact).toSet();
}
