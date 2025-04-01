import 'package:gearforce/src/models/roster/weapon/weapon_mode.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_range.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/models/roster/trait/trait.dart';

@immutable
class Weapon {
  final String code;
  final String name;
  final WeaponRange range;
  final int damage;
  final Set<WeaponMode> modes;
  final List<Trait> primaryTraits;
  final List<Trait>? secondaryTraits;
  final bool isReact;

  Weapon({
    required this.code,
    required this.name,
    required this.range,
    required this.damage,
    required Set<WeaponMode> modes,
    List<Trait> primaryTraits = const [],
    List<Trait>? secondaryTraits,
    this.isReact = false,
  })  : assert(damage >= 0, 'Damage must be 0 or greater'),
        assert(modes.isNotEmpty, 'Weapon must have at least one mode'),
        modes = Set.unmodifiable(modes),
        primaryTraits = List.unmodifiable(primaryTraits),
        secondaryTraits =
            secondaryTraits != null ? List.unmodifiable(secondaryTraits) : null;

  Weapon copyWith({
    String? name,
    WeaponRange? range,
    int? damage,
    List<Trait>? primaryTraits,
    List<Trait>? secondaryTraits,
    bool? isReact,
    bool replacePrimaryTraits = false,
    bool replaceSecondaryTraits = false,
  }) {
    return Weapon(
      code: code,
      name: name ?? this.name,
      range: range ?? this.range,
      damage: damage ?? this.damage,
      modes: modes,
      primaryTraits: replacePrimaryTraits
          ? (primaryTraits ?? [])
          : [...this.primaryTraits, ...(primaryTraits ?? [])],
      secondaryTraits: replaceSecondaryTraits
          ? secondaryTraits
          : [...(this.secondaryTraits ?? []), ...(secondaryTraits ?? [])],
      isReact: isReact ?? this.isReact,
    );
  }

  @override
  String toString() {
    final primaryTraitsDescription =
        primaryTraits.map((trait) => trait.description).join(' | ');
    final secondaryTraitsDescription = secondaryTraits != null
        ? secondaryTraits!.map((trait) => trait.description).join(' | ')
        : 'None';
    final reactStatus = isReact ? 'React Weapon' : 'Non-React Weapon';
    return '$name ($code): Damage: $damage, Range: $range, Modes: ${modes.join(', ')}, '
        'Primary Traits: $primaryTraitsDescription, Secondary Traits: $secondaryTraitsDescription, $reactStatus';
  }
}
