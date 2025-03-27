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

  static Weapon createAM(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}AM',
      name: 'Artillery Missile',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 48, max: 96),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.indirect},
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
    );
  }

  static Weapon createAPGL(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}APGL',
      name: 'Anti-Personnel Grenade Launchers',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ai(),
        TraitFactory.frag(),
        TraitFactory.aoe(level: 3),
        TraitFactory.proximity(),
      ],
    );
  }

  static Weapon createAR(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}AR',
      name: 'Artillery Rockets',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.demo(level: 2),
      ],
    );
  }

  static Weapon createATM(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}ATM',
      name: 'Anti-Tank Missile',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
        TraitFactory.guided(),
      ],
    );
  }

  static Weapon createBomb(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}Bomb',
      name: 'Bomb',
      range: const WeaponRange(minOptimal: 0, maxOptimal: null, max: null),
      damage: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      }[size]!,
      modes: {WeaponMode.direct},
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
    );
  }

  static Weapon createNapalm(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}Napalm',
      name: 'Napalm Bomb',
      range: const WeaponRange(minOptimal: 0, maxOptimal: null, max: null),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.ai(),
        TraitFactory.fire(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
      ],
    );
  }

  static Weapon createBZ(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}BZ',
      name: 'Bazooka',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
      ],
    );
  }

  static Weapon createRBZ(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}RBZ',
      name: 'Rapid Fire Bazooka',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
        TraitFactory.burst(level: 1),
      ],
    );
  }

  static Weapon createFC(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}FC',
      name: 'Frag Cannon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ap(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
      ],
      secondaryTraits: [
        TraitFactory.frag(),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createFG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}FG',
      name: 'Field Gun',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
      ],
      secondaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 3,
          WeaponSize.medium: 4,
          WeaponSize.large: 5,
        }[size]!),
      ],
    );
  }

  static Weapon createFL(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}FL',
      name: 'Flamer',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: {
        WeaponSize.small: 4,
        WeaponSize.medium: 5,
        WeaponSize.large: 6,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ai(),
        TraitFactory.fire(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
        TraitFactory.burst(level: 1),
        TraitFactory.spray(),
      ],
    );
  }

  static Weapon createGG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}GG',
      name: 'Grappling Gun',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 10, max: null),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
      ],
    );
  }

  static Weapon createGL(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}GL',
      name: 'Grenade Launcher',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 12, max: 24),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
        TraitFactory.ai(),
      ],
      secondaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
      ],
    );
  }

  static Weapon createHG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}HG',
      name: 'Hand Grenade',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.blast(),
        TraitFactory.ap(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createIATM(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IATM',
      name: 'Infantry ATM',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
        TraitFactory.guided(),
      ],
    );
  }

  static Weapon createIGL(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IGL',
      name: 'Infantry Grenade Launcher',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
        TraitFactory.ai(),
      ],
      secondaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
      ],
    );
  }

  static Weapon createILW(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}ILW',
      name: 'Infantry Laser Weapon',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 1),
        TraitFactory.ai(),
      ],
      secondaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createILSR(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}ILSR',
      name: 'Infantry Laser Sniper Rifle',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createIM(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IM',
      name: 'Infantry Mortar',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: {
        WeaponSize.small: 4,
        WeaponSize.medium: 5,
        WeaponSize.large: 6,
      }[size]!,
      modes: {WeaponMode.indirect},
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
    );
  }

  static Weapon createIMG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IMG',
      name: 'Infantry Machine Gun',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 9, max: 18),
      damage: {
        WeaponSize.small: 4,
        WeaponSize.medium: 5,
        WeaponSize.large: 6,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 2),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createIMW(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IMW',
      name: 'Infantry Melee Weapon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createIR(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IR',
      name: 'Infantry Rifle',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 24, max: 48),
      damage: {
        WeaponSize.small: 4,
        WeaponSize.medium: 5,
        WeaponSize.large: 6,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createIS(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IS',
      name: 'Infantry Special',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [],
    );
  }

  static Weapon createIW(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}IW',
      name: 'Infantry Weapon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: {
        WeaponSize.small: 4,
        WeaponSize.medium: 5,
        WeaponSize.large: 6,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 1),
        TraitFactory.ai(),
      ],
      secondaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createLC(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}LC',
      name: 'Laser Cannon',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: null),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
      ],
    );
  }

  static Weapon createMine(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}Mine',
      name: 'Mine',
      range: const WeaponRange(minOptimal: null, maxOptimal: null, max: null),
      damage: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.ap(level: 2),
        TraitFactory.immobilize(),
      ],
    );
  }

  static Weapon createM(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}M',
      name: 'Mortar',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.indirect},
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
    );
  }

  static Weapon createMW(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}MW',
      name: 'Melee Weapon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.demo(level: 4),
      ],
    );
  }

  static Weapon createP(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}P',
      name: 'Pistol',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
      ],
    );
  }

  static Weapon createPA(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}PA',
      name: 'Particle Accelerator',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 24, max: 48),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.haywire(),
        TraitFactory.precise(),
      ],
    );
  }

  static Weapon createPC(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}PC',
      name: 'Plasma Cannon',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 9, max: 18),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.fire(
            level: {
          WeaponSize.small: 4,
          WeaponSize.medium: 5,
          WeaponSize.large: 6,
        }[size]!),
      ],
      secondaryTraits: [
        TraitFactory.ai(),
        TraitFactory.frag(),
        TraitFactory.fire(level: 2),
      ],
    );
  }

  static Weapon createPL(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}PL',
      name: 'Pulse Laser',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 1),
      ],
      secondaryTraits: [
        TraitFactory.apex(),
        TraitFactory.ap(
            level: {
          WeaponSize.small: 1,
          WeaponSize.medium: 2,
          WeaponSize.large: 3,
        }[size]!),
      ],
    );
  }

  static Weapon createPZ(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}PZ',
      name: 'Panzerfaust',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 6, max: 12),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
      ],
    );
  }

  static Weapon createRC(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}RC',
      name: 'Rotary Cannon',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 2),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createRF(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}RF',
      name: 'Rifle',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 36, max: 72),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
      ],
    );
  }

  static Weapon createRG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}RG',
      name: 'Railgun',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 48, max: 96),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precisePlus(),
        TraitFactory.ap(
            level: {
          WeaponSize.small: 3,
          WeaponSize.medium: 4,
          WeaponSize.large: 5,
        }[size]!),
      ],
    );
  }

  static Weapon createRL(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}RL',
      name: 'Rotary Laser',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 2),
        TraitFactory.ai(),
      ],
    );
  }

  static Weapon createRP(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}RP',
      name: 'Rocket Pack',
      range: const WeaponRange(minOptimal: 6, maxOptimal: 18, max: 36),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct, WeaponMode.indirect},
      primaryTraits: [
        TraitFactory.aoe(level: 3),
        TraitFactory.ap(level: 1),
      ],
    );
  }

  static Weapon createSC(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}SC',
      name: 'Snub Cannon',
      range: const WeaponRange(minOptimal: 3, maxOptimal: 12, max: 24),
      damage: {
        WeaponSize.small: 8,
        WeaponSize.medium: 9,
        WeaponSize.large: 10,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.precise(),
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
        TraitFactory.demo(level: 3),
      ],
    );
  }

  static Weapon createSE(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}SE',
      name: 'Shaped Explosive',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
        TraitFactory.demo(level: 4),
      ],
    );
  }

  static Weapon createSG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}SG',
      name: 'Spike Gun',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: {
        WeaponSize.small: 6,
        WeaponSize.medium: 7,
        WeaponSize.large: 8,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 3,
          WeaponSize.medium: 4,
          WeaponSize.large: 5,
        }[size]!),
      ],
    );
  }

  static Weapon createSMG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}SMG',
      name: 'Submachine Gun',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
      damage: {
        WeaponSize.small: 5,
        WeaponSize.medium: 6,
        WeaponSize.large: 7,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.burst(level: 2),
      ],
      secondaryTraits: [
        TraitFactory.precise(),
      ],
    );
  }

  static Weapon createTG(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}TG',
      name: 'Tank Gun',
      range: const WeaponRange(minOptimal: 12, maxOptimal: 36, max: 72),
      damage: {
        WeaponSize.small: 9,
        WeaponSize.medium: 10,
        WeaponSize.large: 11,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 3,
          WeaponSize.medium: 4,
          WeaponSize.large: 5,
        }[size]!),
        TraitFactory.demo(level: 2),
      ],
      secondaryTraits: [
        TraitFactory.aoe(level: 2),
        TraitFactory.blast(),
      ],
    );
  }

  static Weapon createVB(WeaponSize size) {
    return Weapon(
      code: '${size.prefix}VB',
      name: 'Vibro Blade',
      range: const WeaponRange(minOptimal: 0, maxOptimal: 0, max: null),
      damage: {
        WeaponSize.small: 7,
        WeaponSize.medium: 8,
        WeaponSize.large: 9,
      }[size]!,
      modes: {WeaponMode.direct},
      primaryTraits: [
        TraitFactory.ap(
            level: {
          WeaponSize.small: 2,
          WeaponSize.medium: 3,
          WeaponSize.large: 4,
        }[size]!),
      ],
    );
  }
}
