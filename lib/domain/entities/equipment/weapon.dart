import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart'
    show DamageSizeBands, TraitSizeBands;
import 'package:gearforce/domain/entities/equipment/weapon_mode.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:meta/meta.dart';

@immutable
class Weapon {
  final String _code;
  final String name;
  final WeaponRange range;
  final Set<WeaponMode> modes;
  final List<Trait> _primaryTraits;
  final List<Trait> _alternateTraits;
  final TraitSizeBands primaryTraitBands;
  final TraitSizeBands alternateTraitBands;
  final DamageSizeBands damageBands;
  final WeaponSize size;
  final bool isReact;

  const Weapon({
    required String code,
    required this.name,
    required this.range,
    required this.modes,

    /// primaryTraits represent the base traits of this weapon
    List<Trait> primaryTraits = const [],

    /// alternateTraits are an optional set of traits that can be used instead of the primary traits
    List<Trait> alternateTraits = const [],

    this.primaryTraitBands = const TraitSizeBands(),
    this.alternateTraitBands = const TraitSizeBands(),
    required this.damageBands,
    required this.size,
    this.isReact = false,
  }) : _code = code,
       _primaryTraits = primaryTraits,
       _alternateTraits = alternateTraits;

  List<Trait> get primaryTraits => getPrimaryTraitsForSize(size);
  List<Trait> getPrimaryTraitsForSize(WeaponSize size) => [
    ..._primaryTraits,
    ...primaryTraitBands.getValue(size),
  ];

  List<Trait> get alternateTraits => getAlternateTraitsForSize(size);
  List<Trait> getAlternateTraitsForSize(WeaponSize size) => [
    ..._alternateTraits,
    ...alternateTraitBands.getValue(size),
  ];

  bool get hasAlternateTraits => alternateTraits.isNotEmpty;

  int get damage => damageBands.getValue(size);
  int getDamageForSize(WeaponSize size) => damageBands.getValue(size);

  String get code => '${size.prefix}$_code';
  String get baseCode => _code;

  Weapon copyWith({
    String? name,
    WeaponRange? range,
    WeaponSize? size,
    DamageSizeBands? damageSizeBands,
    Set<WeaponMode>? weaponModes,
    List<Trait>? primaryTraits,
    List<Trait>? alternateTraits,
    List<Trait>? customTraits,
    bool? isReact,
  }) {
    return Weapon(
      code: _code,
      name: name ?? this.name,
      range: range ?? this.range,
      size: size ?? this.size,
      damageBands: damageSizeBands ?? damageBands,
      modes: weaponModes ?? modes,
      primaryTraits: [
        ...primaryTraits ?? this.primaryTraits,
        ...customTraits ?? const [],
      ],
      alternateTraits: [
        ...alternateTraits ?? this.alternateTraits,
        ...(this.alternateTraits.isNotEmpty && customTraits != null
            ? customTraits
            : const []),
      ],
      isReact: isReact ?? this.isReact,
    );
  }

  @override
  String toString() {
    final pTraits = primaryTraits.join(', ');
    final aTraits = alternateTraits.join(', ');
    var allTraits = '\nTraits: $pTraits';
    if (aTraits.isNotEmpty) {
      allTraits = '$allTraits or $aTraits';
    }
    return '${size.toString()} $name ($code): Damage: $damage, Range: ${range.shortString()}, Modes: ${modes.map((e) => e.toString().split('.')[1][0].toUpperCase()).join(', ')}$allTraits';
  }
}
