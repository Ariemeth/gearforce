import 'package:gearforce/src/pages/roster/models/weapon.dart';
import 'package:gearforce/src/pages/roster/models/weapon_mode.dart';
import 'package:gearforce/src/pages/roster/models/weapon_range.dart';
import 'package:gearforce/src/pages/roster/models/weapon_size.dart';
import 'package:gearforce/src/pages/roster/models/trait_factory.dart';

class WeaponFactory {
  static Weapon createAAM(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}AAM',
      name: 'Anti-Air Missile',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aa(),
        TraitFactory.guided(),
      ],
    );
  }

  static Weapon createAC(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}AC',
      name: 'Autocannon',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 1),
      ],
      secondaryTraits: [
        TraitFactory.precise(),
      ],
    );
  }

  static Weapon createAG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}AG',
      name: 'Artillery Gun',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
      damage: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      }[size]!,
      modes: {WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.ap(level: 1),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.demo(level: 2),
      ],
    );
  }
}
