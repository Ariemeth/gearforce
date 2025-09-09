import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';

class DamageSizeBands {
  final int l;
  final int m;
  final int h;
  const DamageSizeBands({required this.l, required this.m, required this.h})
    : assert(l >= 0, 'Light damage must be positive or zero'),
      assert(m >= 0, 'Medium damage must be positive or zero'),
      assert(h >= 0, 'Heavy damage must be positive or zero');

  int damage(WeaponSize size) => switch (size) {
    WeaponSize.light => l,
    WeaponSize.medium => m,
    WeaponSize.heavy => h,
  };
}
