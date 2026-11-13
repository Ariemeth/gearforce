import 'package:gearforce/domain/entities/equipment/trait.dart' show Trait;
import 'package:gearforce/domain/entities/equipment/trait_list_extensions.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class WeaponSpec {
  final List<Trait> customTraits;
  final bool isReact;

  const WeaponSpec({this.customTraits = const [], this.isReact = false});

  // Uniform fold/visitor to avoid switch/if cascades at call sites.
  T when<T>({
    required T Function(SingleWeaponSpec) single,
    required T Function(ComboWeaponSpec) combo,
  });

  List<Weapon> get weapons;

  bool get isCombo;

  String get code;

  String get summary;

  WeaponSpec copySpec();
}

@immutable
final class SingleWeaponSpec extends WeaponSpec {
  final Weapon weapon;

  const SingleWeaponSpec({
    required this.weapon,
    super.customTraits,
    super.isReact,
  });

  @override
  List<Weapon> get weapons => [weapon.copyWith(customTraits: customTraits)];

  @override
  bool get isCombo => false;

  @override
  String get code => weapon.code;

  @override
  T when<T>({
    required T Function(SingleWeaponSpec) single,
    required T Function(ComboWeaponSpec) combo,
  }) {
    return single(this);
  }

  @override
  String toString() {
    var code = weapon.code;
    if (customTraits.isNotEmpty) {
      code = '$code (${customTraits.join(' ')})';
    }
    return code;
  }

  // Creates a new instance with selectively replaced fields.
  SingleWeaponSpec copyWith({
    Weapon? weapon,
    List<Trait>? customTraits,
    bool? isReact,
  }) {
    return SingleWeaponSpec(
      weapon: weapon ?? this.weapon.copyWith(),
      customTraits: customTraits ?? this.customTraits.copyWith(),
      isReact: isReact ?? this.isReact,
    );
  }

  @override
  WeaponSpec copySpec() => copyWith();

  @override
  String get summary => weapon.toString();
}

@immutable
final class ComboWeaponSpec extends WeaponSpec {
  final Weapon weapon1;
  final Weapon weapon2;

  const ComboWeaponSpec({
    required this.weapon1,
    required this.weapon2,
    super.customTraits,
    super.isReact,
  });

  @override
  List<Weapon> get weapons => [
    weapon1.copyWith(customTraits: customTraits),
    weapon2.copyWith(customTraits: customTraits),
  ];

  @override
  bool get isCombo => true;

  @override
  String get code => '${weapon1.code}/${weapon2.code}';

  @override
  T when<T>({
    required T Function(SingleWeaponSpec) single,
    required T Function(ComboWeaponSpec) combo,
  }) {
    return combo(this);
  }

  @override
  String toString() {
    var code = '${weapon1.code}/${weapon2.code}';
    if (customTraits.isNotEmpty) {
      code = '$code (${customTraits.join(' ')})';
    }
    return code;
  }

  // Creates a new instance with selectively replaced fields.
  ComboWeaponSpec copyWith({
    Weapon? weapon1,
    Weapon? weapon2,
    List<Trait>? customTraits,
    bool? isReact,
  }) {
    return ComboWeaponSpec(
      weapon1: weapon1 ?? this.weapon1.copyWith(),
      weapon2: weapon2 ?? this.weapon2.copyWith(),
      customTraits: customTraits ?? this.customTraits.copyWith(),
      isReact: isReact ?? this.isReact,
    );
  }

  @override
  WeaponSpec copySpec() => copyWith();

  @override
  String get summary => '${weapon1.toString()}\n${weapon2.toString()}';
}
