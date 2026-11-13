import 'package:gearforce/data/static/catalogs/trait_catalog.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_mode.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';

class WeaponCatalog {
  static Weapon aam(WeaponSize size) => Weapon(
    code: 'AAM',
    name: 'Anti-Air Missile',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aa(), TraitCatalog.guided()],
  );

  static Weapon ac(WeaponSize size) => Weapon(
    code: 'AC',
    name: 'Autocannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1)],
    alternateTraits: [TraitCatalog.precise()],
  );

  static Weapon ag(WeaponSize size) => Weapon(
    code: 'AG',
    name: 'Artillery Gun',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.indirect},
    primaryTraits: [
      TraitCatalog.aoe(level: 3),
      TraitCatalog.blast(),
      TraitCatalog.ap(level: 1),
    ],
    alternateTraits: [
      TraitCatalog.aoe(level: 3),
      TraitCatalog.blast(),
      TraitCatalog.demo(level: 2),
    ],
  );

  static Weapon am(WeaponSize size) => Weapon(
    code: 'AM',
    name: 'Artillery Missile',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.indirect},
    primaryTraits: [
      TraitCatalog.aoe(level: 3),
      TraitCatalog.blast(),
      TraitCatalog.guided(),
      TraitCatalog.ap(level: 1),
    ],
    alternateTraits: [
      TraitCatalog.aoe(level: 3),
      TraitCatalog.blast(),
      TraitCatalog.guided(),
      TraitCatalog.ai(),
    ],
  );

  static Weapon apgl(WeaponSize size) => Weapon(
    code: 'APGL',
    name: 'Anti-Personnel Grenade Launchers',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct},
    primaryTraits: [
      TraitCatalog.ai(),
      TraitCatalog.frag(),
      TraitCatalog.aoe(level: 3),
      TraitCatalog.proximity(),
    ],
  );

  static Weapon ar(WeaponSize size) => Weapon(
    code: 'AR',
    name: 'Artillery Rockets',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 3), TraitCatalog.blast()],
  );

  static Weapon atm(WeaponSize size) => Weapon(
    code: 'ATM',
    name: 'Anti-Tank Missile',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.guided()],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 2)],
      m: [TraitCatalog.ap(level: 3)],
      h: [TraitCatalog.ap(level: 4)],
    ),
  );

  static Weapon bomb(WeaponSize size) => Weapon(
    code: 'Bomb',
    name: 'Bomb',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.aoe(level: 3), TraitCatalog.blast()],
  );

  static Weapon napalm(WeaponSize size) => Weapon(
    code: 'Napalm',
    name: 'Napalm Bomb',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.fire(level: 2), TraitCatalog.aoe(level: 3)],
  );

  static Weapon bz(WeaponSize size) => Weapon(
    code: 'BZ',
    name: 'Bazooka',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.blast()],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 1)],
      m: [TraitCatalog.ap(level: 2)],
      h: [TraitCatalog.ap(level: 3)],
    ),
  );

  static Weapon rbz(WeaponSize size) => Weapon(
    code: 'RBZ',
    name: 'Repeating Bazooka',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1), TraitCatalog.blast()],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 1)],
      m: [TraitCatalog.ap(level: 2)],
      h: [TraitCatalog.ap(level: 3)],
    ),
  );

  static Weapon flc(WeaponSize size) => Weapon(
    code: 'FLC',
    name: 'Field Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct},
    primaryTraits: const [],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 2)],
      m: [TraitCatalog.ap(level: 3)],
      h: [TraitCatalog.ap(level: 4)],
    ),
    alternateTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon fg(WeaponSize size) => Weapon(
    code: 'FG',
    name: 'Field Gun',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1)],
    alternateTraits: [TraitCatalog.precise()],
  );

  static Weapon fc(WeaponSize size) => Weapon(
    code: 'FC',
    name: 'Frag Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.frag(), TraitCatalog.aoe(level: 2)],
  );

  static Weapon fl(WeaponSize size) => Weapon(
    code: 'FL',
    name: 'Flamethrower',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 6, max: 12),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct},
    primaryTraits: [
      TraitCatalog.fire(level: 2),
      TraitCatalog.spray(),
      TraitCatalog.ai(),
    ],
  );

  static Weapon gg(WeaponSize size) => Weapon(
    code: 'GG',
    name: 'Grenade Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon gl(WeaponSize size) => Weapon(
    code: 'GL',
    name: 'Grenade Launcher',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon hg(WeaponSize size) => Weapon(
    code: 'HG',
    name: 'Heavy Gun',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1)],
    alternateTraits: [TraitCatalog.precise()],
  );

  static Weapon iatm(WeaponSize size) => Weapon(
    code: 'IATM',
    name: 'Infantry Anti-Tank Missile',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.guided(), TraitCatalog.ap(level: 2)],
  );

  static Weapon ic(WeaponSize size) => Weapon(
    code: 'IC',
    name: 'Infantry Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1)],
  );

  static Weapon igl(WeaponSize size) => Weapon(
    code: 'IGL',
    name: 'Infantry Grenade Launcher',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon ilw(WeaponSize size) => Weapon(
    code: 'ILW',
    name: 'Infantry Laser Weapon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.precise()],
  );

  static Weapon ilsr(WeaponSize size) => Weapon(
    code: 'ILSR',
    name: 'Infantry Light Sniper Rifle',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.precisePlus()],
  );

  static Weapon im(WeaponSize size) => Weapon(
    code: 'IM',
    name: 'Infantry Mortar',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon img(WeaponSize size) => Weapon(
    code: 'IMG',
    name: 'Infantry Machine Gun',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 2), TraitCatalog.ai()],
  );

  static Weapon imw(WeaponSize size) => Weapon(
    code: 'IMW',
    name: 'Infantry Melee Weapon',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct},
    primaryTraits: const [],
  );

  static Weapon ir(WeaponSize size) => Weapon(
    code: 'IR',
    name: 'Infantry Rifle',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1)],
  );

  static Weapon irc(WeaponSize size) => Weapon(
    code: 'IRC',
    name: 'Infantry Rotary Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 2)],
  );

  static Weapon iw(WeaponSize size) => Weapon(
    code: 'IW',
    name: 'Infantry Weapon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
    modes: const {WeaponMode.direct},
    primaryTraits: const [],
  );

  static Weapon lc(WeaponSize size) => Weapon(
    code: 'LC',
    name: 'Laser Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.precise()],
  );

  static Weapon mine(WeaponSize size) => Weapon(
    code: 'Mine',
    name: 'Mine',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [
      TraitCatalog.aoe(level: 3),
      TraitCatalog.proximity(),
      TraitCatalog.blast(),
    ],
  );

  static Weapon m(WeaponSize size) => Weapon(
    code: 'M',
    name: 'Mortar',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon mw(WeaponSize size) => Weapon(
    code: 'MW',
    name: 'Melee Weapon',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: const [],
  );

  static Weapon p(WeaponSize size) => Weapon(
    code: 'P',
    name: 'Pistol',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 6, max: 12),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.precise()],
  );

  static Weapon pa(WeaponSize size) => Weapon(
    code: 'PA',
    name: 'Particle Accelerator',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 24, max: 48),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.haywire()],
  );

  static Weapon pc(WeaponSize size) => Weapon(
    code: 'PC',
    name: 'Plasma Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.fire(level: 1)],
  );

  static Weapon pl(WeaponSize size) => Weapon(
    code: 'PL',
    name: 'Pulse Laser',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1), TraitCatalog.precise()],
  );

  static Weapon pz(WeaponSize size) => Weapon(
    code: 'PZ',
    name: 'Panzerfaust',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 6, max: 12),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.la(level: 1), TraitCatalog.ap(level: 2)],
  );

  static Weapon rc(WeaponSize size) => Weapon(
    code: 'RC',
    name: 'Rotary Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 2), TraitCatalog.auto()],
  );

  static Weapon rf(WeaponSize size) => Weapon(
    code: 'RF',
    name: 'Rifle',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 1)],
  );

  static Weapon rg(WeaponSize size) => Weapon(
    code: 'RG',
    name: 'Railgun',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.precise()],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 2)],
      m: [TraitCatalog.ap(level: 3)],
      h: [TraitCatalog.ap(level: 4)],
    ),
  );

  static Weapon rl(WeaponSize size) => Weapon(
    code: 'RL',
    name: 'Rocket Pack',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2)],
  );

  static Weapon rp(WeaponSize size) => Weapon(
    code: 'RP',
    name: 'Rocket Pod',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.burst(level: 1)],
  );

  static Weapon sc(WeaponSize size) => Weapon(
    code: 'SC',
    name: 'Sniper Cannon',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.precisePlus()],
  );

  static Weapon se(WeaponSize size) => Weapon(
    code: 'SE',
    name: 'Seeker',
    size: size,
    range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct, WeaponMode.indirect},
    primaryTraits: [TraitCatalog.guided()],
  );

  static Weapon sg(WeaponSize size) => Weapon(
    code: 'SG',
    name: 'Shotgun',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 6, max: 12),
    damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.spray()],
  );

  static Weapon smg(WeaponSize size) => Weapon(
    code: 'SMG',
    name: 'Submachine Gun',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
    damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.burst(level: 2)],
    alternateTraits: [TraitCatalog.precise()],
  );

  static Weapon tg(WeaponSize size) => Weapon(
    code: 'TG',
    name: 'Tank Gun',
    size: size,
    range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
    damageBands: const DamageSizeBands(l: 9, m: 10, h: 11),
    modes: const {WeaponMode.direct},
    primaryTraits: [TraitCatalog.demo(level: 2)],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 3)],
      m: [TraitCatalog.ap(level: 4)],
      h: [TraitCatalog.ap(level: 5)],
    ),
    alternateTraits: [TraitCatalog.aoe(level: 2), TraitCatalog.blast()],
  );

  static Weapon vb(WeaponSize size) => Weapon(
    code: 'VB',
    name: 'Vibro Blade',
    size: size,
    range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
    damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
    modes: const {WeaponMode.direct},
    primaryTraits: const [],
    primaryTraitBands: TraitSizeBands(
      l: [TraitCatalog.ap(level: 2)],
      m: [TraitCatalog.ap(level: 3)],
      h: [TraitCatalog.ap(level: 4)],
    ),
  );
}
