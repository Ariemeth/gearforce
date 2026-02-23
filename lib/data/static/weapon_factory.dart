import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';

class WeaponFactory {
  static WeaponRepository? _repository;

  static void setRepository(WeaponRepository repository) {
    _repository = repository;
  }

  static Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    if (_repository == null) {
      throw StateError('WeaponFactory repository not set');
    }
    return _repository!.getWeaponByCode(code, hasReact: hasReact);
  }
}
