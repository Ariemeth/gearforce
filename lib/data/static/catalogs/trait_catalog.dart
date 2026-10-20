import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/trait_type.dart';

class TraitCatalog {
  static Trait aa({bool isAux = false}) => Trait(
    name: 'AA',
    description:
        'Weapons with the AA trait receive +1D6 for ranged attacks '
        'against elevated VTOLs and airstrike counters. This unit may retaliate '
        'against an airstrike counter when they perform an airstrike.',
    isAux: isAux,
  );

  static Trait agile({bool isAux = false}) => Trait(
    name: 'Agile',
    description:
        'Attacks targeting this unit will miss on a Margin Of Success of Zero (MOS:0).',
    isAux: isAux,
  );

  static Trait airdrop({bool isAux = false}) => Trait(
    name: 'Airdrop',
    description:
        'Squads composed entirely of units with the Airdrop trait may '
        'deploy using the Airdrop Special Deployment option. See Airdrop Deployment.',
    isAux: isAux,
  );

  static Trait ai({bool isAux = false}) => Trait(
    name: 'AI',
    description:
        'Weapons with the AI trait add +1 to the result rolled (+1 R) '
        'against Infantry and Cavalry.',
    isAux: isAux,
  );

  static Trait amphib({bool isAux = false}) => Trait(
    name: 'Amphib',
    description:
        'This unit uses its full MR in Water and does not treat Water as Difficult Terrain.',
    isAux: isAux,
  );

  static Trait ams({bool isAux = false}) => Trait(
    name: 'AMS',
    description:
        'An Anti-Missile System (AMS) gives this unit a passive defense against missile attacks.\n\n'
        'When attacked by a weapon with the Guided trait, this unit receives a +1D6 bonus modifier when performing a dodge action.',
    isAux: isAux,
  );

  static Trait aoe({bool isAux = false, int? level}) => Trait(
    name: 'AOE',
    description:
        'Area Of Effect (AOE) weapons affect a circle of space on the board. The size of the circle is determined by the AOE level.\n\n'
        'Add a +XD6 modifier to any Attack Roll made using this weapon. This is usually +1D6 or +2D6.',
    level: level,
    isAux: isAux,
  );

  static Trait ap({bool isAux = false, required int level}) => Trait(
    name: 'AP',
    description:
        'Armor Piercing (AP) weapons ignore the target unit\'s Armor value.',
    level: level,
    isAux: isAux,
  );

  static Trait apex({bool isAux = false}) => Trait(
    name: 'APEX',
    description:
        'APEX weapons ignore the target unit\'s Armor value and cause additional damage.',
    isAux: isAux,
  );

  static Trait auto({bool isAux = false}) => Trait(
    name: 'Auto',
    description:
        'Whenever a unit fires a weapon with the Auto trait, it can fire an extra shot without spending an extra action.',
    isAux: isAux,
  );

  static Trait aux({bool isAux = true}) => Trait(
    name: 'Aux',
    description: 'Aux, or auxiliary, implies a more delicate Trait.',
    isAux: isAux,
  );

  static Trait b({bool isAux = false}) => Trait(
    name: 'B',
    description:
        'Weapons with this trait can only be fired at targets within this unit’s Back Arc (the back 180 degrees of the model).',
    isAux: isAux,
  );

  static Trait blast({bool isAux = false}) => Trait(
    name: 'Blast',
    description: 'Blast weapons cause area damage upon impact.',
    isAux: isAux,
  );

  static Trait brawl({bool isAux = false, int? level}) => Trait(
    name: 'Brawl',
    description: 'Brawl trait adds bonus to melee combat.',
    level: level,
    isAux: isAux,
  );

  static Trait burst({bool isAux = false, int? level}) => Trait(
    name: 'Burst',
    description: 'Burst weapons fire multiple rounds in sequence.',
    level: level,
    isAux: isAux,
  );

  static Trait climb({bool isAux = false}) => Trait(
    name: 'Climb',
    description: 'Units with Climb can scale vertical obstacles easily.',
    isAux: isAux,
  );

  static Trait corrosion({bool isAux = false}) => Trait(
    name: 'Corrosion',
    description: 'Corrosion weapons deal lingering chemical damage.',
    isAux: isAux,
  );

  static Trait demo({bool isAux = false, int? level}) => Trait(
    name: 'Demo',
    description: 'Demolition trait for anti-structure attacks.',
    level: level,
    isAux: isAux,
  );

  static Trait eComms({bool isAux = false}) => Trait(
    name: 'E-Comms',
    description: 'Electronic Communications trait.',
    isAux: isAux,
  );

  static Trait ecm({bool isAux = false}) => Trait(
    name: 'ECM',
    description: 'Electronic Counter Measures.',
    isAux: isAux,
  );

  static Trait ecmPlus({bool isAux = false}) => Trait(
    name: 'ECM+',
    description: 'Advanced Electronic Counter Measures.',
    isAux: isAux,
  );

  static Trait eccm({bool isAux = false}) => Trait(
    name: 'ECCM',
    description: 'Electronic Counter-Counter Measures.',
    isAux: isAux,
  );

  static Trait eccmPlus({bool isAux = false}) => Trait(
    name: 'ECCM+',
    description: 'Advanced Electronic Counter-Counter Measures.',
    isAux: isAux,
  );

  static Trait fire({bool isAux = false, int? level}) => Trait(
    name: 'Fire',
    description: 'Fire trait causes ongoing thermal damage.',
    level: level,
    isAux: isAux,
  );

  static Trait frag({bool isAux = false}) => Trait(
    name: 'Frag',
    description: 'Fragmentation weapons spread shrapnel.',
    isAux: isAux,
  );

  static Trait green() => const Trait(
    name: 'Green',
    description: 'Green crew or inexperienced unit.',
  );

  static Trait guided({bool isAux = false}) => Trait(
    name: 'Guided',
    description: 'Guided weapons can lock on and adjust trajectory.',
    isAux: isAux,
  );

  static Trait hands({bool isAux = false}) => Trait(
    name: 'Hands',
    description: 'Unit has manipulators capable of holding items.',
    isAux: isAux,
  );

  static Trait haywire({bool isAux = false}) => Trait(
    name: 'Haywire',
    description: 'Haywire trait disrupts electronics.',
    isAux: isAux,
  );

  static Trait hiTech({bool isAux = false}) => Trait(
    name: 'Hi-Tech',
    description: 'High Technology equipment.',
    isAux: isAux,
  );

  static Trait immobilize({bool isAux = false}) => Trait(
    name: 'Immobilize',
    description: 'Immobilize trait traps target unit.',
    isAux: isAux,
  );

  static Trait initPlus({bool isAux = false}) => Trait(
    name: 'Init+',
    description: 'Bonus to Initiative roll.',
    isAux: isAux,
  );

  static Trait jetpack({bool isAux = false, int? level}) => Trait(
    name: 'Jetpack',
    description: 'Jetpack allows short thruster leaps.',
    level: level,
    isAux: isAux,
  );

  static Trait jump({bool isAux = false, int? level}) => Trait(
    name: 'Jump',
    description: 'Jump jets capability.',
    level: level,
    isAux: isAux,
  );

  static Trait l({bool isAux = false}) => const Trait(
    name: 'L',
    description:
        'A weapon with this trait can only be fired at targets within the model’s Left Arc.',
  );

  static Trait la({bool isAux = false, int? level}) => Trait(
    name: 'LA',
    description: 'Limited Ammo trait.',
    level: level,
    isAux: isAux,
  );

  static Trait linked({bool isAux = false}) => Trait(
    name: 'Linked',
    description: 'Linked weapons fire together.',
    isAux: isAux,
  );

  static Trait loTech({bool isAux = false}) => Trait(
    name: 'Lo-Tech',
    description: 'Low Technology equipment.',
    isAux: isAux,
  );

  static Trait lumbering({bool isAux = false}) => Trait(
    name: 'Lumbering',
    description: 'Slow turning and heavy movement.',
    isAux: isAux,
  );

  static Trait medic({bool isAux = false, int? level}) => Trait(
    name: 'Medic',
    description: 'Medical assistance capability.',
    level: level,
    isAux: isAux,
  );

  static Trait occupancy({
    bool isAux = false,
    int? level,
    required TraitType type,
  }) => Trait(
    name: 'Occupancy',
    description: 'Occupancy capacity.',
    level: level,
    type: type,
    isAux: isAux,
  );

  static Trait offroad({bool isAux = false}) => Trait(
    name: 'Offroad',
    description: 'Enhanced offroad travel capability.',
    isAux: isAux,
  );

  static Trait openTop({bool isAux = false}) => Trait(
    name: 'Open Top',
    description: 'Exposed transport compartment.',
    isAux: isAux,
  );

  static Trait precise({bool isAux = false}) => Trait(
    name: 'Precise',
    description: 'Highly accurate aiming system.',
    isAux: isAux,
  );

  static Trait precisePlus({bool isAux = false}) => Trait(
    name: 'Precise+',
    description: 'Advanced precision targeting.',
    isAux: isAux,
  );

  static Trait proximity({bool isAux = false}) => Trait(
    name: 'Proximity',
    description: 'Proximity triggered explosive.',
    isAux: isAux,
  );

  static Trait r({bool isAux = false}) => Trait(
    name: 'R',
    description:
        'A weapon with this trait can only be fired at targets within the model’s Right Arc.',
    isAux: isAux,
  );

  static Trait reach({bool isAux = false, int? level}) => Trait(
    name: 'Reach',
    description: 'Extended melee range.',
    level: level,
    isAux: isAux,
  );

  static Trait react({bool isAux = false}) => Trait(
    name: 'React',
    description: 'Reaction fire capability.',
    isAux: isAux,
  );

  static Trait reactPlus({bool isAux = false}) => Trait(
    name: 'React+',
    description: 'Enhanced reaction fire.',
    isAux: isAux,
  );

  static Trait reflex({bool isAux = false}) => Trait(
    name: 'Reflex',
    description: 'Fast response defense system.',
    isAux: isAux,
  );

  static Trait repair({bool isAux = false, int? level}) => Trait(
    name: 'Repair',
    description: 'Field repair capability.',
    level: level,
    isAux: isAux,
  );

  static Trait resist({bool isAux = false, TraitType? type}) => Trait(
    name: 'Resist',
    description: 'Resistance to specific effect type.',
    type: type,
    isAux: isAux,
  );

  static Trait satUp({bool isAux = false}) => Trait(
    name: 'SatUp',
    description: 'Satellite Uplink capability.',
    isAux: isAux,
  );

  static Trait sensorBoom({bool isAux = false}) => Trait(
    name: 'Sensor Boom',
    description: 'Extended elevated sensor mast.',
    isAux: isAux,
  );

  static Trait sensor({bool isAux = false, int? level}) => Trait(
    name: 'Sensor',
    description: 'Sensor array range in inches.',
    level: level,
    isAux: isAux,
  );

  static Trait shield({bool isAux = false}) => Trait(
    name: 'Shield',
    description: 'Directional defense shield.',
    isAux: isAux,
  );

  static Trait silent({bool isAux = false}) => Trait(
    name: 'Silent',
    description: 'Fires without revealing unit position.',
    isAux: isAux,
  );

  static Trait smoke({bool isAux = false}) => Trait(
    name: 'Smoke',
    description: 'Deploys obscuring smoke screen.',
    isAux: isAux,
  );

  static Trait sp1({bool isAux = false}) =>
      Trait(name: 'SP', description: 'Special Purpose trait.', isAux: isAux);

  static Trait spray({bool isAux = false}) => Trait(
    name: 'Spray',
    description: 'Cone-shaped fire pattern.',
    isAux: isAux,
  );

  static Trait stable({bool isAux = false}) => Trait(
    name: 'Stable',
    description: 'Fires smoothly while moving.',
    isAux: isAux,
  );

  static Trait stationary({bool isAux = false}) => Trait(
    name: 'Stationary',
    description: 'Must remain still to fire effectively.',
    isAux: isAux,
  );

  static Trait stealth({bool isAux = false}) => Trait(
    name: 'Stealth',
    description: 'Low radar/thermal signature.',
    isAux: isAux,
  );

  static Trait sub({bool isAux = false}) => Trait(
    name: 'Sub',
    description: 'Submersible underwater movement.',
    isAux: isAux,
  );

  static Trait supply({bool isAux = false}) => Trait(
    name: 'Supply',
    description: 'Replenishes ammunition for nearby units.',
    isAux: isAux,
  );

  static Trait td({bool isAux = false}) => Trait(
    name: 'TD',
    description: 'Target Designator laser pointer.',
    isAux: isAux,
  );

  static Trait towed({bool isAux = false}) => Trait(
    name: 'Towed',
    description: 'Towed trailer equipment.',
    isAux: isAux,
  );

  static Trait transport({
    bool isAux = false,
    int? level,
    required TraitType type,
  }) => Trait(
    name: 'Transport',
    description: 'Personnel or gear transport capability.',
    level: level,
    type: type,
    isAux: isAux,
  );

  static Trait t({bool isAux = false}) => Trait(
    name: 'T',
    description: 'Turret 360-degree rotation weapon.',
    isAux: isAux,
  );

  static Trait vtol({bool isAux = false}) => Trait(
    name: 'VTOL',
    description: 'Vertical Takeoff and Landing aircraft.',
    isAux: isAux,
  );

  static Trait vuln({bool isAux = false, required TraitType type}) => Trait(
    name: 'Vuln',
    description: 'Vulnerable to specific element damage.',
    type: type,
    isAux: isAux,
  );
}
