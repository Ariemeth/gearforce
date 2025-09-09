import 'package:gearforce/src/models/roster/trait/trait.dart' show Trait;
import 'package:gearforce/src/models/roster/weapon/weapon.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class WeaponSpec {
  final List<Trait> customTraits;
  const WeaponSpec({this.customTraits = const []});

  // Uniform fold/visitor to avoid switch/if cascades at call sites.
  T when<T>({
    required T Function(SingleWeaponSpec) single,
    required T Function(ComboWeaponSpec) combo,
  });

  List<Weapon> get weapons;

  bool get isCombo;
}

@immutable
final class SingleWeaponSpec extends WeaponSpec {
  final Weapon _weapon;

  const SingleWeaponSpec({required Weapon weapon, super.customTraits})
    : _weapon = weapon;

  @override
  List<Weapon> get weapons => [_weapon.copyWith(customTraits: customTraits)];

  @override
  T when<T>({
    required T Function(SingleWeaponSpec) single,
    required T Function(ComboWeaponSpec) combo,
  }) {
    return single(this);
  }

  @override
  String toString() {
    var code = _weapon.code;
    if (customTraits.isNotEmpty) {
      code = '$code (${customTraits.join(' ')})';
    }
    return code;
  }

  @override
  bool get isCombo => false;
}

@immutable
final class ComboWeaponSpec extends WeaponSpec {
  final Weapon _weapon1;
  final Weapon _weapon2;

  const ComboWeaponSpec({
    required Weapon weapon1,
    required Weapon weapon2,
    super.customTraits,
  }) : _weapon2 = weapon2,
       _weapon1 = weapon1;

  @override
  List<Weapon> get weapons => [
    _weapon1.copyWith(customTraits: customTraits),
    _weapon2.copyWith(customTraits: customTraits),
  ];

  @override
  T when<T>({
    required T Function(SingleWeaponSpec) single,
    required T Function(ComboWeaponSpec) combo,
  }) {
    return combo(this);
  }

  @override
  String toString() {
    var code = '${_weapon1.code}/${_weapon2.code}';
    if (customTraits.isNotEmpty) {
      code = '$code (${customTraits.join(' ')})';
    }
    return code;
  }

  @override
  bool get isCombo => true;
}
