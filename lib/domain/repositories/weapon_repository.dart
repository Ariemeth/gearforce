import 'package:gearforce/domain/entities/equipment/weapon.dart';

abstract class WeaponRepository {
  Future<List<Weapon>> getWeapons();
  Weapon? getWeaponByCode(String code, {bool hasReact = false});
}
