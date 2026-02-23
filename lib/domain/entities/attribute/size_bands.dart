import 'package:gearforce/data/repositories/json_converters.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:json_annotation/json_annotation.dart';

part 'size_bands.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class SizeBands<T> {
  final T l;
  final T m;
  final T h;

  const SizeBands({required this.l, required this.m, required this.h});

  factory SizeBands.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$SizeBandsFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$SizeBandsToJson(this, toJsonT);

  /// Returns the appropriate value for the specified weapon size.
  ///
  /// This method uses pattern matching to return the value associated with
  /// the given [WeaponSize]. It handles all possible size variants defined
  /// in the [WeaponSize] enum.
  ///
  /// Example:
  /// ```dart
  /// final damageBands = DamageSizeBands(l: 5, m: 6, h: 7);
  /// final mediumDamage = damageBands.getValue(WeaponSize.medium); // returns 6
  /// ```
  T getValue(WeaponSize size) => switch (size) {
    WeaponSize.light => l,
    WeaponSize.medium => m,
    WeaponSize.heavy => h,
  };
}

/// A specialized version of [SizeBands] that manages weapon traits based on size.
///
/// [TraitSizeBands] stores lists of [Trait] objects for different weapon sizes,
/// allowing weapons to have different trait combinations depending on whether they
/// are light, medium, or heavy variants.
///
/// This class provides convenient empty list defaults for all sizes, making it
/// easy to create instances where certain size categories have no special traits.
///
/// Example:
/// ```dart
/// // Define traits that increase in power with weapon size
/// final traitBands = TraitSizeBands(
///   l: [Trait.ap(level: 1)],
///   m: [Trait.ap(level: 2)],
///   h: [Trait.ap(level: 3)],
/// );
/// ```
@JsonSerializable()
class TraitSizeBands extends SizeBands<List<Trait>> {
  @TraitListConverter()
  @override
  List<Trait> get l => super.l;
  @TraitListConverter()
  @override
  List<Trait> get m => super.m;
  @TraitListConverter()
  @override
  List<Trait> get h => super.h;

  const TraitSizeBands({
    List<Trait> l = const [],
    List<Trait> m = const [],
    List<Trait> h = const [],
  }) : super(l: l, m: m, h: h);

  factory TraitSizeBands.fromJson(Map<String, dynamic> json) =>
      _$TraitSizeBandsFromJson(json);

  @override
  Map<String, dynamic> toJson([Object? Function(List<Trait> value)? toJsonT]) =>
      _$TraitSizeBandsToJson(this);
}

@JsonSerializable()
class DamageSizeBands extends SizeBands<int> {
  const DamageSizeBands({required super.l, required super.m, required super.h})
    : assert(l >= 0, 'Light damage must be positive or zero'),
      assert(m >= 0, 'Medium damage must be positive or zero'),
      assert(h >= 0, 'Heavy damage must be positive or zero');

  factory DamageSizeBands.fromJson(Map<String, dynamic> json) =>
      _$DamageSizeBandsFromJson(json);

  @override
  Map<String, dynamic> toJson([Object? Function(int value)? toJsonT]) =>
      _$DamageSizeBandsToJson(this);
}
