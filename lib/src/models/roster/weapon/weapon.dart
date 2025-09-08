import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_mode.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_range.dart';
import 'package:meta/meta.dart';

@immutable
class Weapon {
  final String code;
  final String name;
  final WeaponRange range;
  final int damage;
  final Set<WeaponMode> modes;
  final List<Trait> primaryTraits;
  final List<Trait> alternateTraits;
  final bool isReact;

  Weapon({
    required this.code,
    required this.name,
    required this.range,
    required this.damage,
    required Set<WeaponMode> modes,

    /// primaryTraits represent the base traits of this weapon
    List<Trait> primaryTraits = const [],

    /// alternateTraits are an optional set of traits that can be used instead of the primary traits
    List<Trait> alternateTraits = const [],
    this.isReact = false,
  }) : assert(damage >= 0, 'Damage must be 0 or greater'),
       assert(modes.isNotEmpty, 'Weapon must have at least one mode'),
       modes = Set.unmodifiable(modes),
       primaryTraits = List.unmodifiable(primaryTraits),
       alternateTraits = List.unmodifiable(alternateTraits);

  Weapon copyWith({
    String? name,
    WeaponRange? range,
    int? damage,
    Set<WeaponMode>? weaponModes,
    List<Trait>? primaryTraits,
    List<Trait>? alternateTraits,
    bool? isReact,
  }) {
    return Weapon(
      code: code,
      name: name ?? this.name,
      range: range ?? this.range,
      damage: damage ?? this.damage,
      modes: weaponModes ?? modes,
      primaryTraits: primaryTraits ?? this.primaryTraits,
      alternateTraits: alternateTraits ?? this.alternateTraits,

      isReact: isReact ?? this.isReact,
    );
  }

  bool get hasAlternateTraits => alternateTraits.isNotEmpty;

  @override
  String toString() {
    final primaryTraitsDescription = primaryTraits
        .map((trait) => trait.description)
        .join(' | ');
    final alternateTraitsDescription = alternateTraits
        .map((trait) => trait.description)
        .join(' | ');
    final reactStatus = isReact ? 'React Weapon' : 'Non-React Weapon';
    return '$name ($code): Damage: $damage, Range: $range, Modes: ${modes.join(', ')}, '
        'Primary Traits: $primaryTraitsDescription, Alternate Traits: $alternateTraitsDescription, $reactStatus';
  }
}
