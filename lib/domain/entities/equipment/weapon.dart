import 'package:gearforce/data/repositories/json_converters.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart'
    show DamageSizeBands, TraitSizeBands;
import 'package:gearforce/domain/entities/equipment/weapon_mode.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'weapon.g.dart';

@immutable
@JsonSerializable()
class Weapon {
  @JsonKey(name: 'code')
  final String baseCode;
  final String name;
  final WeaponRange range;
  final Set<WeaponMode> modes;
  @JsonKey(name: 'traits')
  @TraitListConverter()
  final List<Trait> baseTraits;
  @JsonKey(name: 'altTraits')
  @TraitListConverter()
  final List<Trait> baseAlternateTraits;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TraitSizeBands primaryTraitBands;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TraitSizeBands alternateTraitBands;
  @JsonKey(name: 'damage')
  final DamageSizeBands damageBands;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final WeaponSize size;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isReact;

  const Weapon({
    required this.baseCode,
    required this.name,
    required this.range,
    required this.modes,
    this.baseTraits = const [],
    this.baseAlternateTraits = const [],
    this.primaryTraitBands = const TraitSizeBands(),
    this.alternateTraitBands = const TraitSizeBands(),
    required this.damageBands,
    this.size = WeaponSize.light,
    this.isReact = false,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Trait> get primaryTraits => getPrimaryTraitsForSize(size);
  List<Trait> getPrimaryTraitsForSize(WeaponSize size) => [
    ...baseTraits,
    ...primaryTraitBands.getValue(size),
  ];

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Trait> get alternateTraits => getAlternateTraitsForSize(size);
  List<Trait> getAlternateTraitsForSize(WeaponSize size) => [
    ...baseAlternateTraits,
    ...alternateTraitBands.getValue(size),
  ];

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasAlternateTraits => alternateTraits.isNotEmpty;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int get damage => damageBands.getValue(size);
  int getDamageForSize(WeaponSize size) => damageBands.getValue(size);

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get code => '${size.prefix}$baseCode';

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
      baseCode: baseCode,
      name: name ?? this.name,
      range: range ?? this.range,
      size: size ?? this.size,
      damageBands: damageSizeBands ?? damageBands,
      modes: weaponModes ?? modes,
      baseTraits: [...primaryTraits ?? baseTraits, ...customTraits ?? const []],
      baseAlternateTraits: [
        ...alternateTraits ?? baseAlternateTraits,
        ...(baseAlternateTraits.isNotEmpty && customTraits != null
            ? customTraits
            : const []),
      ],
      isReact: isReact ?? this.isReact,
    );
  }

  factory Weapon.fromJson(
    Map<String, dynamic> json,
    WeaponSize size, {
    bool isReact = false,
  }) {
    final weapon = _$WeaponFromJson(json);
    return weapon.copyWith(size: size, isReact: isReact);
  }

  Map<String, dynamic> toJson() => _$WeaponToJson(this);

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
