import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';

/// A generic class that represents values that vary based on weapon size (light, medium, heavy).
///
/// This class is used to associate different values with different weapon sizes,
/// allowing for a type-safe way to handle size-dependent game mechanics.
/// The generic type parameter T allows this class to be used for various data types
/// such as damage values (int) or collections of traits (List`<Trait>`).
///
/// [SizeBands] is designed as an immutable value object to promote safety
/// and predictability in game state management.
class SizeBands<T> {
  /// The value associated with a [WeaponSize.light] weapons.
  final T l;

  /// The value associated with a [WeaponSize.medium] weapons.
  final T m;

  /// The value associated with a [WeaponSize.heavy] weapons.
  final T h;

  /// Creates a new SizeBands instance with specific values for each weapon size.
  ///
  /// All three [WeaponSize] values (light, medium, heavy) are required.
  const SizeBands({required this.l, required this.m, required this.h});

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
class TraitSizeBands extends SizeBands<List<Trait>> {
  /// Creates a new TraitSizeBands instance with traits for each weapon size.
  ///
  /// All parameters default to empty lists, so you only need to specify
  /// the size categories that have traits.
  const TraitSizeBands({
    super.l = const [],
    super.m = const [],
    super.h = const [],
  });
}

class DamageSizeBands extends SizeBands<int> {
  const DamageSizeBands({required super.l, required super.m, required super.h})
    : assert(l >= 0, 'Light damage must be positive or zero'),
      assert(m >= 0, 'Medium damage must be positive or zero'),
      assert(h >= 0, 'Heavy damage must be positive or zero');
}
