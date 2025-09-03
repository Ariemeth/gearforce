import 'package:gearforce/src/models/roster/weapon/weapon.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_mode.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_range.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';
import 'package:gearforce/src/predefined/trait_factory.dart';

class WeaponFactory {
  static Weapon createAAM(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}AAM',
      name: 'Anti-Air Missile',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [TraitFactory.aa(), TraitFactory.guided()],
      isReact: hasReact,
    );
  }

  static Weapon createAC(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}AC',
      name: 'Autocannon',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 1)],
      secondaryTraits: [TraitFactory.precise()],
      isReact: hasReact,
    );
  }

  static Weapon createAG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}AG',
      name: 'Artillery Gun',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
      damage: const {
        WeaponSize.light: 8,
        WeaponSize.medium: 9,
        WeaponSize.heavy: 10,
      }[size]!,
      modes: const {WeaponMode.indirect},
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
      isReact: hasReact,
    );
  }

  static Weapon createAM(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}AM',
      name: 'Artillery Missile',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.guided(),
        TraitFactory.ap(level: 1),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.guided(),
        TraitFactory.ai(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createAPGL(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}APGL',
      name: 'Anti-Personnel Grenade Launchers',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ai(),
        TraitFactory.frag(),
        TraitFactory.aoe(level: 3),
        TraitFactory.proximity(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createAR(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}AR',
      name: 'Artillery Rockets',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [TraitFactory.aoe(level: 3), TraitFactory.demo(level: 2)],
      isReact: hasReact,
    );
  }

  static Weapon createATM(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}ATM',
      name: 'Anti-Tank Missile',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: const {
        WeaponSize.light: 8,
        WeaponSize.medium: 9,
        WeaponSize.heavy: 10,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
        TraitFactory.guided(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createBomb(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}Bomb',
      name: 'Bomb',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 8,
        WeaponSize.medium: 9,
        WeaponSize.heavy: 10,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.apex(),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.guided(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createNapalm(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}Napalm',
      name: 'Napalm Bomb',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.ai(),
        TraitFactory.fire(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createBZ(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}BZ',
      name: 'Bazooka',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
      ],
      secondaryTraits: [TraitFactory.aoe(level: 2), TraitFactory.blast()],
      isReact: hasReact,
    );
  }

  static Weapon createRBZ(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}RBZ',
      name: 'Rapid Fire Bazooka',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
        TraitFactory.burst(level: 1),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createFC(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}FC',
      name: 'Frag Cannon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ap(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
      ],
      secondaryTraits: [TraitFactory.frag(), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createFG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}FG',
      name: 'Field Gun',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: const {
        WeaponSize.light: 8,
        WeaponSize.medium: 9,
        WeaponSize.heavy: 10,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [TraitFactory.aoe(level: 3), TraitFactory.blast()],
      secondaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 3,
            WeaponSize.medium: 4,
            WeaponSize.heavy: 5,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createFL(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}FL',
      name: 'Flamer',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: const {
        WeaponSize.light: 4,
        WeaponSize.medium: 5,
        WeaponSize.heavy: 6,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ai(),
        TraitFactory.fire(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
        TraitFactory.burst(level: 1),
        TraitFactory.spray(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createGG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}GG',
      name: 'Grappling Gun',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 10, max: null),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createGL(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}GL',
      name: 'Grenade Launcher',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
        TraitFactory.ai(),
      ],
      secondaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createHG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}HG',
      name: 'Hand Grenade',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.ap(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
        TraitFactory.ai(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createIATM(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IATM',
      name: 'Infantry ATM',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
        TraitFactory.guided(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createIGL(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IGL',
      name: 'Infantry Grenade Launcher',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
        TraitFactory.ai(),
      ],
      secondaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createILW(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}ILW',
      name: 'Infantry Laser Weapon',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 1), TraitFactory.ai()],
      secondaryTraits: [TraitFactory.precise(), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createILSR(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}ILSR',
      name: 'Infantry Laser Sniper Rifle',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.precise(), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createIM(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IM',
      name: 'Infantry Mortar',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: const {
        WeaponSize.light: 4,
        WeaponSize.medium: 5,
        WeaponSize.heavy: 6,
      }[size]!,
      modes: const {WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
        TraitFactory.apex(),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
        TraitFactory.guided(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createIMG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IMG',
      name: 'Infantry Machine Gun',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
      damage: const {
        WeaponSize.light: 4,
        WeaponSize.medium: 5,
        WeaponSize.heavy: 6,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 2), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createIMW(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IMW',
      name: 'Infantry Melee Weapon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createIR(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IR',
      name: 'Infantry Rifle',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 24, max: 48),
      damage: const {
        WeaponSize.light: 4,
        WeaponSize.medium: 5,
        WeaponSize.heavy: 6,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.precise(), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createIS(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IS',
      name: 'Infantry Special',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [],
      isReact: hasReact,
    );
  }

  static Weapon createIW(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}IW',
      name: 'Infantry Weapon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: const {
        WeaponSize.light: 4,
        WeaponSize.medium: 5,
        WeaponSize.heavy: 6,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 1), TraitFactory.ai()],
      secondaryTraits: [TraitFactory.precise(), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createLC(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}LC',
      name: 'Laser Cannon',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: null),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.precise()],
      isReact: hasReact,
    );
  }

  static Weapon createMine(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}Mine',
      name: 'Mine',
      range: const WeaponRange(minOptimal: null, maxOptimal: null, max: null),
      damage: const {
        WeaponSize.light: 8,
        WeaponSize.medium: 9,
        WeaponSize.heavy: 10,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.ap(level: 2),
        TraitFactory.immobilize(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createM(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}M',
      name: 'Mortar',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.apex(),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.guided(),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createMW(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}MW',
      name: 'Melee Weapon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.demo(level: 4)],
      isReact: hasReact,
    );
  }

  static Weapon createP(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}P',
      name: 'Pistol',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.precise()],
      isReact: hasReact,
    );
  }

  static Weapon createPA(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}PA',
      name: 'Particle Accelerator',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.haywire(), TraitFactory.precise()],
      isReact: hasReact,
    );
  }

  static Weapon createPC(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}PC',
      name: 'Plasma Cannon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.fire(
          level: {
            WeaponSize.light: 4,
            WeaponSize.medium: 5,
            WeaponSize.heavy: 6,
          }[size]!,
        ),
      ],
      secondaryTraits: [
        TraitFactory.ai(),
        TraitFactory.frag(),
        TraitFactory.fire(level: 2),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createPL(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}PL',
      name: 'Pulse Laser',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 1)],
      secondaryTraits: [
        TraitFactory.apex(),
        TraitFactory.ap(
          level: {
            WeaponSize.light: 1,
            WeaponSize.medium: 2,
            WeaponSize.heavy: 3,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createPZ(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}PZ',
      name: 'Panzerfaust',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createRC(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}RC',
      name: 'Rotary Cannon',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 2), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createRF(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}RF',
      name: 'Rifle',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.precise()],
      isReact: hasReact,
    );
  }

  static Weapon createRG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}RG',
      name: 'Railgun',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: 96),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precisePlus(),
        TraitFactory.ap(
          level: {
            WeaponSize.light: 3,
            WeaponSize.medium: 4,
            WeaponSize.heavy: 5,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createRL(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}RL',
      name: 'Rotary Laser',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 2), TraitFactory.ai()],
      isReact: hasReact,
    );
  }

  static Weapon createRP(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}RP',
      name: 'Rocket Pack',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [TraitFactory.aoe(level: 3), TraitFactory.ap(level: 1)],
      isReact: hasReact,
    );
  }

  static Weapon createSC(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}SC',
      name: 'Snub Cannon',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 12, max: 24),
      damage: const {
        WeaponSize.light: 8,
        WeaponSize.medium: 9,
        WeaponSize.heavy: 10,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
        TraitFactory.demo(level: 3),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createSE(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}SE',
      name: 'Shaped Explosive',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
        TraitFactory.demo(level: 4),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createSG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}SG',
      name: 'Spike Gun',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 6,
        WeaponSize.medium: 7,
        WeaponSize.heavy: 8,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 3,
            WeaponSize.medium: 4,
            WeaponSize.heavy: 5,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon createSMG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}SMG',
      name: 'Submachine Gun',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
      damage: const {
        WeaponSize.light: 5,
        WeaponSize.medium: 6,
        WeaponSize.heavy: 7,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [TraitFactory.burst(level: 2)],
      secondaryTraits: [TraitFactory.precise()],
      isReact: hasReact,
    );
  }

  static Weapon createTG(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}TG',
      name: 'Tank Gun',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
      damage: const {
        WeaponSize.light: 9,
        WeaponSize.medium: 10,
        WeaponSize.heavy: 11,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 3,
            WeaponSize.medium: 4,
            WeaponSize.heavy: 5,
          }[size]!,
        ),
        TraitFactory.demo(level: 2),
      ],
      secondaryTraits: [TraitFactory.aoe(level: 2), TraitFactory.blast()],
      isReact: hasReact,
    );
  }

  static Weapon createVB(WeaponSize size, {bool hasReact = false}) {
    return Weapon(
      code: '${size.prefix}VB',
      name: 'Vibro Blade',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: const {
        WeaponSize.light: 7,
        WeaponSize.medium: 8,
        WeaponSize.heavy: 9,
      }[size]!,
      modes: const {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
          level: {
            WeaponSize.light: 2,
            WeaponSize.medium: 3,
            WeaponSize.heavy: 4,
          }[size]!,
        ),
      ],
      isReact: hasReact,
    );
  }

  static Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    final size = WeaponSize.fromCode(code);

    switch (code.substring(1)) {
      case 'AAM':
        return createAAM(size, hasReact: hasReact);
      case 'AC':
        return createAC(size, hasReact: hasReact);
      case 'AG':
        return createAG(size, hasReact: hasReact);
      case 'AM':
        return createAM(size, hasReact: hasReact);
      case 'APGL':
        return createAPGL(size, hasReact: hasReact);
      case 'AR':
        return createAR(size, hasReact: hasReact);
      case 'ATM':
        return createATM(size, hasReact: hasReact);
      case 'Bomb':
        return createBomb(size, hasReact: hasReact);
      case 'Napalm':
        return createNapalm(size, hasReact: hasReact);
      case 'BZ':
        return createBZ(size, hasReact: hasReact);
      case 'RBZ':
        return createRBZ(size, hasReact: hasReact);
      case 'FC':
        return createFC(size, hasReact: hasReact);
      case 'FG':
        return createFG(size, hasReact: hasReact);
      case 'FL':
        return createFL(size, hasReact: hasReact);
      case 'GG':
        return createGG(size, hasReact: hasReact);
      case 'GL':
        return createGL(size, hasReact: hasReact);
      case 'HG':
        return createHG(size, hasReact: hasReact);
      case 'IATM':
        return createIATM(size, hasReact: hasReact);
      case 'IGL':
        return createIGL(size, hasReact: hasReact);
      case 'ILW':
        return createILW(size, hasReact: hasReact);
      case 'ILSR':
        return createILSR(size, hasReact: hasReact);
      case 'IM':
        return createIM(size, hasReact: hasReact);
      case 'IMG':
        return createIMG(size, hasReact: hasReact);
      case 'IMW':
        return createIMW(size, hasReact: hasReact);
      case 'IR':
        return createIR(size, hasReact: hasReact);
      case 'IS':
        return createIS(size, hasReact: hasReact);
      case 'IW':
        return createIW(size, hasReact: hasReact);
      case 'LC':
        return createLC(size, hasReact: hasReact);
      case 'Mine':
        return createMine(size, hasReact: hasReact);
      case 'M':
        return createM(size, hasReact: hasReact);
      case 'MW':
        return createMW(size, hasReact: hasReact);
      case 'P':
        return createP(size, hasReact: hasReact);
      case 'PA':
        return createPA(size, hasReact: hasReact);
      case 'PC':
        return createPC(size, hasReact: hasReact);
      case 'PL':
        return createPL(size, hasReact: hasReact);
      case 'PZ':
        return createPZ(size, hasReact: hasReact);
      case 'RC':
        return createRC(size, hasReact: hasReact);
      case 'RF':
        return createRF(size, hasReact: hasReact);
      case 'RG':
        return createRG(size, hasReact: hasReact);
      case 'RL':
        return createRL(size, hasReact: hasReact);
      case 'RP':
        return createRP(size, hasReact: hasReact);
      case 'SC':
        return createSC(size, hasReact: hasReact);
      case 'SE':
        return createSE(size, hasReact: hasReact);
      case 'SG':
        return createSG(size, hasReact: hasReact);
      case 'SMG':
        return createSMG(size, hasReact: hasReact);
      case 'TG':
        return createTG(size, hasReact: hasReact);
      case 'VB':
        return createVB(size, hasReact: hasReact);
      default:
        return null; // Return null if no matching weapon is found
    }
  }
}
