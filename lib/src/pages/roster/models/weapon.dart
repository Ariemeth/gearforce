import 'package:meta/meta.dart';
import 'package:gearforce/src/pages/roster/models/trait.dart';

enum WeaponSize {
  small,
  medium,
  large;

  static WeaponSize fromCode(String code) {
    switch (code[0].toUpperCase()) {
      case 'S':
        return WeaponSize.small;
      case 'M':
        return WeaponSize.medium;
      case 'L':
        return WeaponSize.large;
      default:
        throw ArgumentError(
            'Invalid weapon code: $code. Size must be S, M, or L.');
    }
  }
}

enum WeaponMode { direct, indirect }

@immutable
class WeaponRange {
  final int? minOptimal;
  final int? maxOptimal;
  final int? max;

  const WeaponRange({
    this.minOptimal,
    this.maxOptimal,
    this.max,
  })  : assert(minOptimal == null || minOptimal >= 0,
            'Minimum range must be null or 0 or positive'),
        assert(
            maxOptimal == null ||
                (minOptimal == null || maxOptimal >= minOptimal),
            'Normal range must be greater than or equal to minimum range if both are provided'),
        assert(max == null || (maxOptimal != null && max >= maxOptimal),
            'Max range must be greater than or equal to normal range if provided');

  @override
  String toString() {
    final minOptimalStr = minOptimal != null ? 'Min: $minOptimal, ' : '';
    final maxOptimalStr = maxOptimal != null ? 'Normal: $maxOptimal, ' : '';
    final maxStr = max != null ? 'Max: $max' : '';
    return '$minOptimalStr$maxOptimalStr$maxStr'.trim();
  }
}

@immutable
class Weapon {
  final String code;
  final String name;
  final WeaponRange range;
  final Map<WeaponSize, int> damageBySize;
  final List<WeaponMode> modes; // Updated to support multiple modes
  final List<Trait> _primaryTraits; // Private to enforce immutability
  final List<Trait>? _secondaryTraits; // Private to enforce immutability
  final bool isReact; // Indicates if the weapon is a react weapon

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
    required this.damageBySize,
    required List<WeaponMode> modes, // Updated to accept multiple modes
    List<Trait> primaryTraits = const [],
    List<Trait>? secondaryTraits,
    Map<String, Map<WeaponSize, int>>? primaryAdjustLevel,
    Map<String, Map<WeaponSize, int>>? secondaryAdjustLevel,
    this.isReact = false,
  })  : modes = List.unmodifiable(modes), // Ensure immutability
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

  int get damage => damageBySize[size]!;

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
      code: 'MAAM',
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
}

extension WeaponListExtensions on List<Weapon> {
  /// Returns all weapons where `isReact` is true.
  List<Weapon> get reactWeapons => where((weapon) => weapon.isReact).toList();

  /// Returns all weapons where `isReact` is false (mounted weapons).
  List<Weapon> get mountedWeapons =>
      where((weapon) => !weapon.isReact).toList();
}
