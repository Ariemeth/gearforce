import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';

class SizeBands<T> {
  final T l;
  final T m;
  final T h;

  const SizeBands({required this.l, required this.m, required this.h});

  T getValue(WeaponSize size) => switch (size) {
    WeaponSize.light => l,
    WeaponSize.medium => m,
    WeaponSize.heavy => h,
  };
}

class TraitSizeBands extends SizeBands<List<Trait>> {
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
