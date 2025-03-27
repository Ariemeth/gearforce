import 'package:gearforce/src/pages/roster/models/weapon_mode.dart';
import 'package:gearforce/src/pages/roster/models/weapon_range.dart';
import 'package:gearforce/src/pages/roster/models/weapon_size.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/pages/roster/models/trait.dart';

@immutable
class Weapon {
  final String code;
  final String name;
  final WeaponRange range;
  final Map<WeaponSize, int> _damageBySize;
  final List<WeaponMode> modes;
  final List<Trait> _primaryTraits;
  final List<Trait>? _secondaryTraits;
  final bool isReact;

  /// A map to define custom level adjustments for primary traits based on weapon size.
  /// Structure:
  /// {
  ///   "TraitName": { // The name of the trait to adjust
  ///     WeaponSize.small: 1, // Adjustment for small weapons
  ///     WeaponSize.medium: 2, // Adjustment for medium weapons
  ///     WeaponSize.large: 3  // Adjustment for large weapons
  ///   }
  /// }
  final Map<String, Map<WeaponSize, int>>? _primaryAdjustLevel;

  /// A map to define custom level adjustments for secondary traits based on weapon size.
  /// Structure:
  /// {
  ///   "TraitName": { // The name of the trait to adjust
  ///     WeaponSize.small: 2, // Adjustment for small weapons
  ///     WeaponSize.medium: 3, // Adjustment for medium weapons
  ///     WeaponSize.large: 4  // Adjustment for large weapons
  ///   }
  /// }
  final Map<String, Map<WeaponSize, int>>? _secondaryAdjustLevel;

  Weapon({
    required this.code,
    required this.name,
    required this.range,
    required Map<WeaponSize, int> damageBySize,
    required List<WeaponMode> modes,
    List<Trait> primaryTraits = const [],
    List<Trait>? secondaryTraits,
    Map<String, Map<WeaponSize, int>>? primaryAdjustLevel,
    Map<String, Map<WeaponSize, int>>? secondaryAdjustLevel,
    this.isReact = false,
  })  : _damageBySize = Map.unmodifiable(damageBySize),
        modes = List.unmodifiable(modes),
        _primaryAdjustLevel = primaryAdjustLevel,
        _secondaryAdjustLevel = secondaryAdjustLevel,
        _primaryTraits = List.unmodifiable(primaryTraits),
        _secondaryTraits =
            secondaryTraits != null ? List.unmodifiable(secondaryTraits) : null,
        assert(
            WeaponSize.values.every((size) => damageBySize.keys.contains(size)),
            'Damage must be specified for all weapon sizes'),
        assert(primaryTraits.isNotEmpty,
            'At least one primary trait must be provided'),
        assert(modes.isNotEmpty && modes.length <= 2,
            'Weapons must have 1 or 2 modes.');

  WeaponSize get size => WeaponSize.fromCode(code);

  String get weaponType => code.substring(1).toUpperCase();

  int get damage => _damageBySize[size]!;

  /// Returns an unmodifiable view of the primary traits.
  List<Trait> get primaryTraits => _primaryTraits.toList();

  /// Returns an unmodifiable view of the secondary traits, if any.
  List<Trait>? get secondaryTraits => _secondaryTraits?.toList();

  /// Adjusts the levels of traits based on the weapon's size and the provided adjustment map.
  List<Trait> getAdjustedTraits(
      List<Trait> traits, Map<String, Map<WeaponSize, int>>? adjustLevel) {
    return traits.map((trait) {
      if (trait.level != null && adjustLevel != null) {
        final levelAdjustments = adjustLevel[trait.name];
        if (levelAdjustments != null && levelAdjustments.containsKey(size)) {
          final adjustedLevel = trait.level! + levelAdjustments[size]!;
          return trait.copyWith(level: adjustedLevel);
        }
      }
      return trait;
    }).toList();
  }

  /// Returns the primary traits with levels adjusted for the weapon size.
  List<Trait> get adjustedPrimaryTraits =>
      getAdjustedTraits(primaryTraits, _primaryAdjustLevel);

  /// Returns the secondary traits with levels adjusted for the weapon size (if any).
  List<Trait>? get adjustedSecondaryTraits => secondaryTraits != null
      ? getAdjustedTraits(secondaryTraits!, _secondaryAdjustLevel)
      : null;

  /// Returns a string representation of the weapon modes.
  String get modesDescription => modes.map((mode) => mode.name).join(' , ');

  Weapon copyWith({
    String? code,
    String? name,
    WeaponRange? range,
    Map<WeaponSize, int>? damageBySize,
    List<WeaponMode>? modes,
    List<Trait>? primaryTraits,
    List<Trait>? secondaryTraits,
    Map<String, Map<WeaponSize, int>>? primaryAdjustLevel,
    Map<String, Map<WeaponSize, int>>? secondaryAdjustLevel,
    bool? isReact,
  }) {
    return Weapon(
      code: code ?? this.code,
      name: name ?? this.name,
      range: range ?? this.range,
      damageBySize: damageBySize ?? _damageBySize,
      modes: modes ?? this.modes,
      primaryTraits: primaryTraits ?? this.primaryTraits,
      secondaryTraits: secondaryTraits ?? this.secondaryTraits,
      primaryAdjustLevel: primaryAdjustLevel ?? _primaryAdjustLevel,
      secondaryAdjustLevel: secondaryAdjustLevel ?? _secondaryAdjustLevel,
      isReact: isReact ?? this.isReact,
    );
  }

  @override
  String toString() {
    final primaryTraitsDescription =
        adjustedPrimaryTraits.map((trait) => trait.description).join(' | ');
    final secondaryTraitsDescription = adjustedSecondaryTraits != null
        ? adjustedSecondaryTraits!.map((trait) => trait.description).join(' | ')
        : 'None';
    final reactStatus = isReact ? 'React Weapon' : 'Non-React Weapon';
    return '$name ($code): Size: $size, Designator: $weaponType, Damage: $damage, Range: $range, Modes: $modesDescription, '
        'Primary Traits: $primaryTraitsDescription, Secondary Traits: $secondaryTraitsDescription, $reactStatus';
  }

  factory Weapon.aam() {
    return Weapon(
      code: 'AAM',
      name: 'Anti-Air Missile',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
      damageBySize: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      },
      modes: [WeaponMode.direct, WeaponMode.indirect],
      primaryTraits: [
        Trait.aa(),
        Trait.guided(),
      ],
    );
  }

  factory Weapon.ac() {
    return Weapon(
        code: 'AC',
        name: 'Autocannon',
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBySize: {
          WeaponSize.small: 6,
          WeaponSize.medium: 7,
          WeaponSize.large: 8,
        },
        modes: [
          WeaponMode.direct
        ],
        primaryTraits: [
          Trait.burst(level: 1)
        ],
        secondaryTraits: [
          Trait.precise()
        ]);
  }

  factory Weapon.ag() {
    return Weapon(
      code: 'AG',
      name: 'Artillery Gun',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
      damageBySize: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      },
      modes: [WeaponMode.indirect],
      primaryTraits: [
        Trait.aoe(level: 3),
        Trait.blast(),
        Trait.ap(level: 1),
      ],
      secondaryTraits: [
        Trait.aoe(level: 3),
        Trait.blast(),
        Trait.demo(level: 2),
      ],
    );
  }
}
