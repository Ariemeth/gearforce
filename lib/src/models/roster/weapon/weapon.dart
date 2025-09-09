import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/weapon/damage_size_bands.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_mode.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_range.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:meta/meta.dart';

@immutable
class Weapon {
  final String _code;
  final String name;
  final WeaponRange range;
  final Set<WeaponMode> modes;
  final List<Trait> primaryTraits;
  final List<Trait> alternateTraits;
  final bool isReact;
  final DamageSizeBands damageBands;
  final WeaponSize size;

  const Weapon({
    required String code,
    required this.name,
    required this.range,

    required this.modes,
    required this.damageBands,
    required this.size,

    /// primaryTraits represent the base traits of this weapon
    this.primaryTraits = const [],

    /// alternateTraits are an optional set of traits that can be used instead of the primary traits
    this.alternateTraits = const [],
    this.isReact = false,
  }) : _code = code;

  bool get hasAlternateTraits => alternateTraits.isNotEmpty;
  int get damage {
    return damageBands.damage(size);
  }

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
    final primaryTraitsDescription = primaryTraits
        .map((trait) => trait.description)
        .join(' | ');
    final alternateTraitsDescription = alternateTraits
        .map((trait) => trait.description)
        .join(' | ');
    final reactStatus = isReact ? 'React Weapon' : 'Non-React Weapon';
    return '$name ($code): Damage: $damage, Range: $range, Modes: ${modes.join(', ')}, '
        'Primary Traits: $primaryTraitsDescription, Alternate Traits: $alternateTraitsDescription, $reactStatus';
  }

  const Weapon.aam(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'AAM',
        name: 'Anti-Air Missile',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aa(), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.ac(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'AC',
        name: 'Autocannon',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 1)],
        alternateTraits: const [Trait.precise()],
        isReact: hasReact,
      );

  const Weapon.ag(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'AG',
        name: 'Artillery Gun',
        size: size,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.indirect},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ap(level: 1),
        ],
        alternateTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.demo(level: 2),
        ],
        isReact: hasReact,
      );

  const Weapon.am(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'AM',
        name: 'Artillery Missile',
        size: size,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.indirect},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.guided(),
          Trait.ap(level: 1),
        ],
        alternateTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.guided(),
          Trait.ai(),
        ],
        isReact: hasReact,
      );

  const Weapon.apgl(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'APGL',
        name: 'Anti-Personnel Grenade Launchers',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.ai(),
          Trait.frag(),
          Trait.aoe(level: 3),
          Trait.proximity(),
        ],
        isReact: hasReact,
      );

  const Weapon.ar(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'AR',
        name: 'Artillery Rockets',
        size: size,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 3), Trait.demo(level: 2)],
        isReact: hasReact,
      );

  const Weapon.atmLight({bool hasReact = false})
    : this(
        code: 'ATM',
        name: 'Anti-Tank Missile',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.ap(level: 2), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.atmMedium({bool hasReact = false})
    : this(
        code: 'ATM',
        name: 'Anti-Tank Missile',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.ap(level: 3), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.atmHeavy({bool hasReact = false})
    : this(
        code: 'ATM',
        name: 'Anti-Tank Missile',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.ap(level: 4), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.bomb(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'Bomb',
        name: 'Bomb',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.aoe(level: 3), Trait.blast(), Trait.apex()],
        alternateTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.guided(),
        ],
        isReact: hasReact,
      );

  const Weapon.napalmLight({bool hasReact = false})
    : this(
        code: 'Napalm',
        name: 'Napalm Bomb',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ai(),
          Trait.fire(level: 1),
        ],
        isReact: hasReact,
      );

  const Weapon.napalmMedium({bool hasReact = false})
    : this(
        code: 'Napalm',
        name: 'Napalm Bomb',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ai(),
          Trait.fire(level: 2),
        ],
        isReact: hasReact,
      );

  const Weapon.napalmHeavy({bool hasReact = false})
    : this(
        code: 'Napalm',
        name: 'Napalm Bomb',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ai(),
          Trait.fire(level: 3),
        ],
        isReact: hasReact,
      );

  const Weapon.bzLight({bool hasReact = false})
    : this(
        code: 'BZ',
        name: 'Bazooka',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 2)],
        alternateTraits: const [Trait.aoe(level: 2), Trait.blast()],
        isReact: hasReact,
      );

  const Weapon.bzMedium({bool hasReact = false})
    : this(
        code: 'BZ',
        name: 'Bazooka',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3)],
        alternateTraits: const [Trait.aoe(level: 2), Trait.blast()],
        isReact: hasReact,
      );

  const Weapon.bzHeavy({bool hasReact = false})
    : this(
        code: 'BZ',
        name: 'Bazooka',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4)],
        alternateTraits: const [Trait.aoe(level: 2), Trait.blast()],
        isReact: hasReact,
      );

  const Weapon.rbzLight({bool hasReact = false})
    : this(
        code: 'RBZ',
        name: 'Rapid Fire Bazooka',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 2), Trait.burst(level: 1)],
        isReact: hasReact,
      );

  const Weapon.rbzMedium({bool hasReact = false})
    : this(
        code: 'RBZ',
        name: 'Rapid Fire Bazooka',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3), Trait.burst(level: 1)],
        isReact: hasReact,
      );

  const Weapon.rbzHeavy({bool hasReact = false})
    : this(
        code: 'RBZ',
        name: 'Rapid Fire Bazooka',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4), Trait.burst(level: 1)],
        isReact: hasReact,
      );

  const Weapon.fcLight({bool hasReact = false})
    : this(
        code: 'FC',
        name: 'Frag Cannon',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise(), Trait.ap(level: 1)],
        alternateTraits: const [Trait.frag(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.fcMedium({bool hasReact = false})
    : this(
        code: 'FC',
        name: 'Frag Cannon',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise(), Trait.ap(level: 2)],
        alternateTraits: const [Trait.frag(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.fcHeavy({bool hasReact = false})
    : this(
        code: 'FC',
        name: 'Frag Cannon',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise(), Trait.ap(level: 3)],
        alternateTraits: const [Trait.frag(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.fgLight({bool hasReact = false})
    : this(
        code: 'FG',
        name: 'Field Gun',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 3), Trait.blast()],
        alternateTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.fgMedium({bool hasReact = false})
    : this(
        code: 'FG',
        name: 'Field Gun',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 3), Trait.blast()],
        alternateTraits: const [Trait.ap(level: 4)],
        isReact: hasReact,
      );

  const Weapon.fgHeavy({bool hasReact = false})
    : this(
        code: 'FG',
        name: 'Field Gun',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 3), Trait.blast()],
        alternateTraits: const [Trait.ap(level: 5)],
        isReact: hasReact,
      );

  const Weapon.flLight({bool hasReact = false})
    : this(
        code: 'FL',
        name: 'Flamer',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.ai(),
          Trait.fire(level: 1),
          Trait.burst(level: 1),
          Trait.spray(),
        ],
        isReact: hasReact,
      );

  const Weapon.flMedium({bool hasReact = false})
    : this(
        code: 'FL',
        name: 'Flamer',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.ai(),
          Trait.fire(level: 2),
          Trait.burst(level: 1),
          Trait.spray(),
        ],
        isReact: hasReact,
      );

  const Weapon.flHeavy({bool hasReact = false})
    : this(
        code: 'FL',
        name: 'Flamer',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.ai(),
          Trait.fire(level: 3),
          Trait.burst(level: 1),
          Trait.spray(),
        ],
        isReact: hasReact,
      );

  const Weapon.ggLight({bool hasReact = false})
    : this(
        code: 'GG',
        name: 'Grappling Gun',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 10, max: null),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 1)],
        isReact: hasReact,
      );

  const Weapon.ggMedium({bool hasReact = false})
    : this(
        code: 'GG',
        name: 'Grappling Gun',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 10, max: null),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 2)],
        isReact: hasReact,
      );

  const Weapon.ggHeavy({bool hasReact = false})
    : this(
        code: 'GG',
        name: 'Grappling Gun',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 10, max: null),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.glLight({bool hasReact = false})
    : this(
        code: 'GL',
        name: 'Grenade Launcher',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.ai()],
        alternateTraits: const [Trait.ap(level: 2)],
        isReact: hasReact,
      );

  const Weapon.glMedium({bool hasReact = false})
    : this(
        code: 'GL',
        name: 'Grenade Launcher',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.ai()],
        alternateTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.glHeavy({bool hasReact = false})
    : this(
        code: 'GL',
        name: 'Grenade Launcher',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.ai()],
        alternateTraits: const [Trait.ap(level: 4)],
        isReact: hasReact,
      );

  const Weapon.hgLight({bool hasReact = false})
    : this(
        code: 'HG',
        name: 'Hand Grenade',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ap(level: 1),
          Trait.ai(),
        ],
        isReact: hasReact,
      );

  const Weapon.hgMedium({bool hasReact = false})
    : this(
        code: 'HG',
        name: 'Hand Grenade',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ap(level: 2),
          Trait.ai(),
        ],
        isReact: hasReact,
      );

  const Weapon.hgHeavy({bool hasReact = false})
    : this(
        code: 'HG',
        name: 'Hand Grenade',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.ap(level: 3),
          Trait.ai(),
        ],
        isReact: hasReact,
      );

  const Weapon.iatmLight({bool hasReact = false})
    : this(
        code: 'IATM',
        name: 'Infantry ATM',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.ap(level: 1), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.iatmMedium({bool hasReact = false})
    : this(
        code: 'IATM',
        name: 'Infantry ATM',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.ap(level: 2), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.iatmHeavy({bool hasReact = false})
    : this(
        code: 'IATM',
        name: 'Infantry ATM',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.ap(level: 3), Trait.guided()],
        isReact: hasReact,
      );

  const Weapon.iglLight({bool hasReact = false})
    : this(
        code: 'IGL',
        name: 'Infantry Grenade Launcher',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.ai()],
        alternateTraits: const [Trait.ap(level: 1)],
        isReact: hasReact,
      );

  const Weapon.iglMedium({bool hasReact = false})
    : this(
        code: 'IGL',
        name: 'Infantry Grenade Launcher',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.ai()],
        alternateTraits: const [Trait.ap(level: 2)],
        isReact: hasReact,
      );

  const Weapon.iglHeavy({bool hasReact = false})
    : this(
        code: 'IGL',
        name: 'Infantry Grenade Launcher',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.ai()],
        alternateTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.ilw(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'ILW',
        name: 'Infantry Laser Weapon',
        size: size,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 1), Trait.ai()],
        alternateTraits: const [Trait.precise(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.ilsr(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'ILSR',
        name: 'Infantry Laser Sniper Rifle',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.im(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'IM',
        name: 'Infantry Mortar',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 2), Trait.blast(), Trait.apex()],
        alternateTraits: const [
          Trait.aoe(level: 2),
          Trait.blast(),
          Trait.guided(),
        ],
        isReact: hasReact,
      );

  const Weapon.img(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'IMG',
        name: 'Infantry Machine Gun',
        size: size,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 2), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.imw(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'IMW',
        name: 'Infantry Melee Weapon',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.ir(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'IR',
        name: 'Infantry Rifle',
        size: size,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.infs(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'IS',
        name: 'Infantry Special',
        size: size,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [],
        isReact: hasReact,
      );

  const Weapon.iw(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'IW',
        name: 'Infantry Weapon',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 4, m: 5, h: 6),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 1), Trait.ai()],
        alternateTraits: const [Trait.precise(), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.lc(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'LC',
        name: 'Laser Cannon',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise()],
        isReact: hasReact,
      );

  const Weapon.mine(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'Mine',
        name: 'Mine',
        size: size,
        range: const WeaponRange(minOptimal: null, maxOptimal: null, max: null),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.aoe(level: 3),
          Trait.ap(level: 2),
          Trait.immobilize(),
        ],
        isReact: hasReact,
      );

  const Weapon.m(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'M',
        name: 'Mortar',
        size: size,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 3), Trait.blast(), Trait.apex()],
        alternateTraits: const [
          Trait.aoe(level: 3),
          Trait.blast(),
          Trait.guided(),
        ],
        isReact: hasReact,
      );

  const Weapon.mw(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'MW',
        name: 'Melee Weapon',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.demo(level: 4)],
        isReact: hasReact,
      );

  const Weapon.p(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'P',
        name: 'Pistol',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise()],
        isReact: hasReact,
      );

  const Weapon.pa(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'PA',
        name: 'Particle Accelerator',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.haywire(), Trait.precise()],
        isReact: hasReact,
      );

  const Weapon.pcLight({bool hasReact = false})
    : this(
        code: 'PC',
        name: 'Plasma Cannon',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.fire(level: 4)],
        alternateTraits: const [Trait.ai(), Trait.frag(), Trait.fire(level: 2)],
        isReact: hasReact,
      );

  const Weapon.pcMedium({bool hasReact = false})
    : this(
        code: 'PC',
        name: 'Plasma Cannon',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.fire(level: 5)],
        alternateTraits: const [Trait.ai(), Trait.frag(), Trait.fire(level: 2)],
        isReact: hasReact,
      );

  const Weapon.pcHeavy({bool hasReact = false})
    : this(
        code: 'PC',
        name: 'Plasma Cannon',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.fire(level: 6)],
        alternateTraits: const [Trait.ai(), Trait.frag(), Trait.fire(level: 2)],
        isReact: hasReact,
      );

  const Weapon.plLight({bool hasReact = false})
    : this(
        code: 'PL',
        name: 'Pulse Laser',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 1)],
        alternateTraits: const [Trait.apex(), Trait.ap(level: 1)],
        isReact: hasReact,
      );

  const Weapon.plMedium({bool hasReact = false})
    : this(
        code: 'PL',
        name: 'Pulse Laser',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 1)],
        alternateTraits: const [Trait.apex(), Trait.ap(level: 2)],
        isReact: hasReact,
      );

  const Weapon.plHeavy({bool hasReact = false})
    : this(
        code: 'PL',
        name: 'Pulse Laser',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 1)],
        alternateTraits: const [Trait.apex(), Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.pzLight({bool hasReact = false})
    : this(
        code: 'PZ',
        name: 'Panzerfaust',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 2)],
        isReact: hasReact,
      );

  const Weapon.pzMedium({bool hasReact = false})
    : this(
        code: 'PZ',
        name: 'Panzerfaust',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.pzHeavy({bool hasReact = false})
    : this(
        code: 'PZ',
        name: 'Panzerfaust',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4)],
        isReact: hasReact,
      );

  const Weapon.rc(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'RC',
        name: 'Rotary Cannon',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 2), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.rf(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'RF',
        name: 'Rifle',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precise()],
        isReact: hasReact,
      );

  const Weapon.rgLight({bool hasReact = false})
    : this(
        code: 'RG',
        name: 'Railgun',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: 96),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precisePlus(), Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.rgMedium({bool hasReact = false})
    : this(
        code: 'RG',
        name: 'Railgun',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: 96),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precisePlus(), Trait.ap(level: 4)],
        isReact: hasReact,
      );

  const Weapon.rgHeavy({bool hasReact = false})
    : this(
        code: 'RG',
        name: 'Railgun',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: 96),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.precisePlus(), Trait.ap(level: 5)],
        isReact: hasReact,
      );

  const Weapon.rl(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'RL',
        name: 'Rotary Laser',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 2), Trait.ai()],
        isReact: hasReact,
      );

  const Weapon.rp(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'RP',
        name: 'Rocket Pack',
        size: size,
        range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct, WeaponMode.indirect},
        primaryTraits: const [Trait.aoe(level: 3), Trait.ap(level: 1)],
        isReact: hasReact,
      );

  const Weapon.scLight({bool hasReact = false})
    : this(
        code: 'SC',
        name: 'Snub Cannon',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.precise(),
          Trait.ap(level: 2),
          Trait.demo(level: 3),
        ],
        isReact: hasReact,
      );

  const Weapon.scMedium({bool hasReact = false})
    : this(
        code: 'SC',
        name: 'Snub Cannon',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.precise(),
          Trait.ap(level: 3),
          Trait.demo(level: 3),
        ],
        isReact: hasReact,
      );

  const Weapon.scHeavy({bool hasReact = false})
    : this(
        code: 'SC',
        name: 'Snub Cannon',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 3, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 8, m: 9, h: 10),
        modes: const {WeaponMode.direct},
        primaryTraits: const [
          Trait.precise(),
          Trait.ap(level: 4),
          Trait.demo(level: 3),
        ],
        isReact: hasReact,
      );

  const Weapon.seLight({bool hasReact = false})
    : this(
        code: 'SE',
        name: 'Shaped Explosive',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 2), Trait.demo(level: 4)],
        isReact: hasReact,
      );

  const Weapon.seMedium({bool hasReact = false})
    : this(
        code: 'SE',
        name: 'Shaped Explosive',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3), Trait.demo(level: 4)],
        isReact: hasReact,
      );

  const Weapon.seHeavy({bool hasReact = false})
    : this(
        code: 'SE',
        name: 'Shaped Explosive',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4), Trait.demo(level: 4)],
        isReact: hasReact,
      );

  const Weapon.sgLight({bool hasReact = false})
    : this(
        code: 'SG',
        name: 'Spike Gun',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.sgMedium({bool hasReact = false})
    : this(
        code: 'SG',
        name: 'Spike Gun',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4)],
        isReact: hasReact,
      );

  const Weapon.sgHeavy({bool hasReact = false})
    : this(
        code: 'SG',
        name: 'Spike Gun',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 6, m: 7, h: 8),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 5)],
        isReact: hasReact,
      );

  const Weapon.smg(WeaponSize size, {bool hasReact = false})
    : this(
        code: 'SMG',
        name: 'Submachine Gun',
        size: size,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
        damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.burst(level: 2)],
        alternateTraits: const [Trait.precise()],
        isReact: hasReact,
      );

  const Weapon.tgLight({bool hasReact = false})
    : this(
        code: 'TG',
        name: 'Tank Gun',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 9, m: 10, h: 11),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3), Trait.demo(level: 2)],
        alternateTraits: const [Trait.aoe(level: 2), Trait.blast()],
        isReact: hasReact,
      );

  const Weapon.tgMedium({bool hasReact = false})
    : this(
        code: 'TG',
        name: 'Tank Gun',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 9, m: 10, h: 11),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4), Trait.demo(level: 2)],
        alternateTraits: const [Trait.aoe(level: 2), Trait.blast()],
        isReact: hasReact,
      );

  const Weapon.tgHeavy({bool hasReact = false})
    : this(
        code: 'TG',
        name: 'Tank Gun',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
        damageBands: const DamageSizeBands(l: 9, m: 10, h: 11),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 5), Trait.demo(level: 2)],
        alternateTraits: const [Trait.aoe(level: 2), Trait.blast()],
        isReact: hasReact,
      );

  const Weapon.vbLight({bool hasReact = false})
    : this(
        code: 'VB',
        name: 'Vibro Blade',
        size: WeaponSize.light,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 2)],
        isReact: hasReact,
      );

  const Weapon.vbMedium({bool hasReact = false})
    : this(
        code: 'VB',
        name: 'Vibro Blade',
        size: WeaponSize.medium,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 3)],
        isReact: hasReact,
      );

  const Weapon.vbHeavy({bool hasReact = false})
    : this(
        code: 'VB',
        name: 'Vibro Blade',
        size: WeaponSize.heavy,
        range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
        damageBands: const DamageSizeBands(l: 7, m: 8, h: 9),
        modes: const {WeaponMode.direct},
        primaryTraits: const [Trait.ap(level: 4)],
        isReact: hasReact,
      );
}
