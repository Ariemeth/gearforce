import 'package:gearforce/domain/entities/equipment/weapon.dart';

extension WeaponListExtensions on List<Weapon> {
  /// Returns a deep copy of the list of weapons.
  List<Weapon> copyWith() {
    return map((weapon) => weapon.copyWith()).toList();
  }
}
