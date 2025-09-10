import 'package:meta/meta.dart';
import 'package:gearforce/src/models/roster/trait/trait_type.dart';

@immutable
class Trait {
  final String name;
  final String? description;
  final int? level;
  final TraitType? type;
  final bool isAux;

  const Trait({
    required this.name,
    this.description,
    this.level,
    this.type,
    this.isAux = false,
  });

  Trait copyWith({
    String? name,
    String? description,
    int? level,
    TraitType? type,
    bool? isAux,
  }) {
    return Trait(
      name: name ?? this.name,
      description: description ?? this.description,
      level: level ?? this.level,
      type: type ?? this.type,
      isAux: isAux ?? this.isAux,
    );
  }

  @override
  String toString() {
    final levelString = level != null ? ':$level' : '';
    final typeString = type != null ? ' ${type?.value}' : '';
    final auxString = isAux ? ' (Aux)' : '';
    return '$name$levelString$typeString$auxString';
  }

  const Trait.aa({bool isAux = false})
    : this(
        name: 'AA',
        description:
            'Weapons with the AA trait receive +1D6 for ranged attacks '
            'against elevated VTOLs and airstrike counters. This unit may retaliate '
            'against an airstrike counter when they perform an airstrike.',
        isAux: isAux,
      );

  const Trait.agile({bool isAux = false})
    : this(
        name: 'Agile',
        description:
            'Attacks targeting this unit will miss on a Margin Of Success of Zero (MOS:0).',
        isAux: isAux,
      );

  const Trait.airdrop({bool isAux = false})
    : this(
        name: 'Airdrop',
        description:
            'Squads composed entirely of units with the Airdrop trait may '
            'deploy using the Airdrop Special Deployment option. See Airdrop Deployment.',
        isAux: isAux,
      );

  const Trait.ai({bool isAux = false})
    : this(
        name: 'AI',
        description:
            'Weapons with the AI trait add +1 to the result rolled (+1 R) '
            'against Infantry and Cavalry.',
        isAux: isAux,
      );

  const Trait.amphib({bool isAux = false})
    : this(
        name: 'Amphib',
        description:
            'This unit may move over water terrain at its full MR. '
            'Note: When this unit moves, it is considered to be moving on the surface of the water.',
        isAux: isAux,
      );

  const Trait.ams({bool isAux = false})
    : this(
        name: 'AMS',
        description:
            'An Anti-Missile System (AMS) is used to intercept indirectly fired enemy munitions. '
            'As long as the munitions arc, the hang time allows the AMS a viable way to catch a bead on incoming fire. '
            '4,000 years in the future, these systems have advanced enough to intercept artillery rounds as well as actual missiles.\n\n'
            '- Units with an AMS may perform a GU Check after being declared the target of an Indirect Attack. '
            'Success provides +1 to the Result for the upcoming defense roll.',
        isAux: isAux,
      );

  const Trait.aoe({bool isAux = false, int? level})
    : this(
        name: 'AOE',
        description:
            'The Area Of Effect, or AOE, is simulating a weapon that can saturate or blow up an area. '
            'A quick example would be a grenade. A common in-universe example would be the shoulder-mounted Rocket Packs (RPs) on many gears’ shoulders. '
            'However, this also includes Artillery Guns (AGs) and more than a few others.\n\n'
            'When you declare an attack with a weapon using the AOE:X trait:\n'
            '- You will need to declare a target point and measure radius from there. Radius is equal to X inches. '
            'I.e., AOE:3 means the AOE has a 3-inch radius.\n'
            '- All models in the radius, friend or foe, become targets.\n'
            '- One Opposed Roll is performed for each targeted unit.\n'
            '- If the attack is centered on one model, then that unit becomes the primary target.\n'
            '  - All other models within the area are considered secondary targets.\n'
            '- Attack rolls against secondary targets have a -1D6 modifier.',
        isAux: isAux,
        level: level,
      );

  const Trait.ap({bool isAux = false, required int level})
    : this(
        name: 'AP',
        description:
            'Armor piercing weapons, or AP Weapons, are able to do damage '
            'on a successful attack even when the Damage does not beat the enemy’s Armor. '
            'For many weapons, this AP:X trait is the only way for it to damage heavily armored '
            'enemy units, such as a Visigoth main battle tank. See Armor Piercing (AP:X) Chapter.',
        isAux: isAux,
        level: level,
      );

  const Trait.apex({bool isAux = false})
    : this(
        name: 'Apex',
        description:
            'This weapon is considered larger than its common analogues. '
            'Add +1 to this weapon’s Damage. Multiple sources of Apex are cumulative.',
        isAux: isAux,
      );

  const Trait.auto({bool isAux = false})
    : this(
        name: 'Auto',
        description:
            'When a weapon is automated, or controlled via some other added means, '
            'the weapon often comes with the Auto trait. This may simulate an additional crewmember '
            'being assigned to a weapon or some form of computerized automation, such as an ONNet controlling '
            'weapons to assist a gear or strider pilot.\n\n'
            'Note: Some units receive an extra Action instead to account for more comprehensive automation or teamwork within a vehicle.\n\n'
            '- A weapon with the Auto trait may be used for Retaliation once per Round without spending an Action point. '
            'If this is a combination weapon, then only one of the weapons may be used in this way per Round.',
        isAux: isAux,
      );

  const Trait.aux({bool isAux = true})
    : this(
        name: 'Aux',
        description:
            'Aux, or auxiliary, implies a more delicate Trait.\n\n'
            '- Traits with – (Aux) – next to them are unavailable when this unit is Critical.',
        isAux: isAux,
      );

  const Trait.b({bool isAux = false})
    : this(
        name: 'B',
        description:
            'Weapons with this trait can only be fired at targets within this unit’s Back Arc '
            '(the back 180 degrees of the model).',
        isAux: isAux,
      );

  const Trait.blast({bool isAux = false})
    : this(
        name: 'Blast',
        description:
            'The Blast trait simulates a different type of AOE-Attack from salvos of rockets.\n\n'
            '- The Blast+AOE traits for a Hand Grenade (HG) are simulating a single munition exploding outward from one point while the Artillery Rockets’ (ARs’) AOE is being used to saturate an area.\n\n'
            'Abstract: Perfectly rolling a grenade behind an enemy is a pro-move, but it’s also based on the operator’s skill. '
            'And doing this also means your intended Target is not a Primary Target in the same sense as the rules (because the target point behind them becomes the actual Primary Target in the Blitz-Rule’s context).\n\n'
            'This trait simulates pro-moves like above. And it does it in a way that takes the mental work off of you and incorporates it into your unit’s Gunnery (GU) Skill. '
            'You don’t need to work out how Blast removes cover based on a target point. You can simply declare it when you want and use your unit’s GU Skill to facilitate the effect (after all commander, it’s your units throwing the grenade, not you personally).\n\n'
            'Blast Rules:\n'
            '- First, Blast is optional. You can choose not to use the Blast trait and just declare a regular AOE Attack instead.\n'
            '  - Note: Blast will not benefit every situation. Ex: It’s less useful for things such as Fire Missions in many situations.\n\n'
            'To use Blast:\n'
            '- When you declare a ranged attack, and you want to incorporate Blast’s ability, you will declare Blast with the declared attack.\n'
            '- Roll a GU Check after declaring the attack.\n'
            '  - Success means – all – the models caught in the AOE cannot declare Cover or Smoke.\n'
            '  - However, all targets in the AOE are considered Secondary. A Primary Target may not be selected.\n'
            '  - Failure means the attack will be carried out as a regular AOE attack instead.\n\n'
            'So, you effectively lose the ability to declare a Primary Target for the benefit of removing their Cover (if your Skill Check succeeds). '
            'In some cases, this only goes so far. You accepting a -1D6 modifier to remove the enemy’s +1D6 from Cover starts somewhat neutral. '
            'However, it’s not that simple on the table. You can further enhance dice advantages and Blast affects – all – the units in an AOE (so, it’s not just about one enemy’s Cover bonus).',
        isAux: isAux,
      );

  const Trait.brawl({bool isAux = false, int? level})
    : this(
        name: 'Brawl',
        description:
            'When you see the Brawl:X trait next to a Weapon on a unit’s profile, '
            'it provides that weapon with a modifier of XD6 when the unit uses that weapon to Attack.\n\n'
            '- When you see a Brawl:X trait in the unit’s Traits column of a unit’s Profile, '
            'it provides the unit with a modifier of XD6 for all melee rolls (Attack and Defense).\n\n'
            '- Multiple instances of the Brawl:X trait are cumulative. I.e., two sources of Brawl:1 can be combined for Brawl:2.\n\n'
            'Note: Several Brawl:X Upgrades are available to you throughout the rules. Duelists usually have better access and can generally combine more of the Brawl-Upgrades to accumulate a higher modifier than non-duelists. '
            'However, non-duelists can collect a significant amount of Brawl Upgrades too.',
        isAux: isAux,
        level: level,
      );

  const Trait.burst({bool isAux = false, int? level})
    : this(
        name: 'Burst',
        description:
            'This Trait simulates a weapon firing in the fully automatic mode as opposed to a semi-automatic mode. '
            'Some weapons, such as Rotary Cannons (RCs), only have a fully automatic mode and may only be fired with the Burst:X trait.\n\n'
            'Add a +XD6 modifier to any Attack Roll made using this weapon. This is usually +1D6 or +2D6.',
        isAux: isAux,
        level: level,
      );

  const Trait.climb({bool isAux = false})
    : this(
        name: 'Climb',
        description:
            'You will find this Trait on units that are specially trained and outfitted for Climbing. See the Climbing Chapter.',
        isAux: isAux,
      );

  const Trait.corrosion({bool isAux = false})
    : this(
        name: 'Corrosion',
        description:
            'When an attack with the Corrosion trait hits a unit, apply damage as normal and then place a Corrosion Token next to the model.\n\n'
            '- In each Cleanup Phase, each unit with a corrosion token rolls one die.\n'
            '  - If you roll a 4, 5 or 6, the unit takes 1 Damage.\n'
            '  - If you roll a 1, 2 or 3, your unit is lucky enough to not take 1 Damage (until next Cleanup at least).\n\n'
            'If not removed by a Patch action, a corrosion token will stay with the unit until the game ends, or the unit is destroyed. '
            'A unit can only have one corrosion token at a time.',
        isAux: isAux,
      );

  const Trait.demo({bool isAux = false, int? level})
    : this(
        name: 'Demo',
        description:
            'The Demo:X trait allows weapons to do extra damage to buildings.\n\n'
            '- When attacking a building, destructible terrain feature or fortification, increase this Weapon’s Damage by the trait’s rating (X).\n\n'
            'For example, the Demo:4 trait will add 4 to the weapon’s damage rating when used against applicable terrain.',
        isAux: isAux,
        level: level,
      );

  const Trait.eComms({bool isAux = false})
    : this(
        name: 'E-Comms',
        description:
            'The E-Comms trait simulates – enhanced communications. Technically all units would have some type of radio or communications. '
            'Many would have several comms devices just on their person. The E-Comms trait is marking units that either have additional training, better equipment, or a little bit of both.\n\n'
            'All of your commanders come with the E-Comms trait as a standard. Some units come with the E-Comms trait on their profile, which is useful for performing Forward Observations (FOs). '
            'You can also select it for your units when they don’t already have the trait, to give any unit a slight boost for performing FOs.\n\n'
            'E-Comms in the rules is specifically useful for issuing Orders and performing Forward Observations (FOs).\n\n'
            'The E-Comms trait provides +1D6 when performing – Unopposed – Rolls for Issuing Orders and Performing FOs.\n\n'
            'Note: If your opponent attempts to Jam your Order or FO, as a Reaction, the Roll will switch to being an Opposed Roll, and you will lose the +1D6 modifier. '
            'However, also having the SatUp trait allows you to keep the +1D6 modifier when the roll switches to being an Opposed Roll.',
        isAux: isAux,
      );

  const Trait.ecm({bool isAux = false})
    : this(
        name: 'ECM',
        description:
            'Electronic Countermeasure (ECM) systems are one of your key ingredients for your offensive E-War. '
            'You can use ECMs to Jam your opponent’s units, electronically attack them and even microwave some infantry for 2 minutes until there are a few seconds between each pop you hear. '
            'An alternative option, which requires less of your cognitive assets when managing your CG, is to just turn on their ECM Defense for some added protection.\n\n'
            'You may use units with ECMs to perform the below trait-enabled actions and reactions:\n'
            '- ECM Attack (Action)\n'
            '- Jamming (Action or Reaction)\n'
            '- ECM Defense (Action or Reaction)\n\n'
            'See the E-War Actions and Reactions section for more details on how to perform each one.',
        isAux: isAux,
      );

  const Trait.ecmPlus({bool isAux = false})
    : this(
        name: 'ECM+',
        description:
            'ECM+ comes with all the same features as ECM except this unit receives a +1D6 modifier when performing ECM Attacks and Jamming.',
        isAux: isAux,
      );

  const Trait.eccm({bool isAux = false})
    : this(
        name: 'ECCM',
        description:
            'Electronic Counter-Countermeasure (ECCM) systems provide you with a way to assertively defend your units against Jamming and ECM Attacks coming from your opponent. '
            'This even comes with a chance to reverse the voodoo back onto them. However, no unit holds the perfect set of keys to E-War. ECCMs are your front-line E-Defenders. '
            'As most front lines go, wish for the best but expect casualties.\n\n'
            '- You may use units with ECCMs to perform Firewalls as a Reaction to Jamming and ECM Attacks.\n'
            '- These Firewalls may be used to protect this unit, or friendly units within sensor range.\n'
            '- Successful Firewalls will reverse Jamming or ECM Attacks back onto the originator.\n'
            '- Failed Firewalls will at least divert the electronic attack to the Firewalling unit. So, even failed Firewalls have tactical utility.\n\n'
            'See the E-War Actions and Reactions section for more details on how to perform Firewalls.',
        isAux: isAux,
      );

  const Trait.eccmPlus({bool isAux = false})
    : this(
        name: 'ECCM+',
        description:
            'ECCM+ comes with the same features as ECCM. However, ECCM+ provides this unit with a +1D6 modifier when performing Firewalls and E-Patch.\n\n'
            '- ECCM+ also provides a +1D6 modifier when passively defending against ECM Attacks and Jamming. But only for the unit with the ECCM+ trait. '
            'In other words, if your unit is not spending an Action point to Firewall, this unit will still get the +1D6 modifier when defending against ECM Attacks and Jamming attempts.',
        isAux: isAux,
      );

  const Trait.fire({bool isAux = false, int? level})
    : this(
        name: 'Fire',
        description:
            'When an attack with the Fire:X trait hits, apply damage as normal, then roll XD6. '
            'For each die that meets or exceeds 4, apply 1 additional Damage. After this roll there are no further effects.\n\n'
            'Example: An attack with a Light Flamer (LFL) hits an enemy unit with a MOS:0 or better. '
            'The LFL has the Fire:2 trait. The regular damage is calculated and then two more dice are rolled. '
            'All results of 4+ produce 1 more Damage (per die).',
        isAux: isAux,
        level: level,
      );

  const Trait.frag({bool isAux = false})
    : this(
        name: 'Frag',
        description:
            'Weapons with the Frag trait will add a +2D6 modifier to attack rolls when used to attack.',
        isAux: isAux,
      );

  const Trait.green()
    : this(
        name: 'Green',
        description:
            'This unit is -1 to all Skills when out of formation with a friendly Commander. '
            'This unit may not select Regular, Veteran or Elite Upgrades. '
            'This unit may not be a Commander or a Duelist.',
      );

  const Trait.guided({bool isAux = false})
    : this(
        name: 'Guided',
        description:
            'The Guided trait has two options to exploit it. One is for regular Indirect Attacks. The other is for Fire Missions.\n\n'
            'Regular Indirect Attacks:\n'
            '- When you Focus an Indirect Attack with this weapon, at an enemy that is Target Locked and designated the Primary Target, '
            'perform a GU Skill Check after declaring the attack. Success provides +1 to the Result Die on the Primary Target of the following attack. '
            'Note, this ability cannot be used with Fire Missions (summarized below).\n\n'
            'Tactical Tip: Units with the Sensor:X trait can share their Target Locks with units In Formation with it. '
            'Popular combinations include Cheetahs with Grizzlies. The Cheetahs can enhance the Grizzlies’ target diversity just by being In Formation with them because the Grizzlies gain access to the Cheetah’s Targeting Locks.\n\n'
            'Fire Missions:\n'
            '- The Guided trait also provides +1 to the Result Die for the Primary Target when performing a Fire Mission. '
            'But only if the Forward Observation (FO) used to initiate the Fire Mission also used a Target Designator (TD).\n'
            '-- See Forward Observations and Fire Missions for the full details about performing them.',
        isAux: isAux,
      );

  const Trait.hands({bool isAux = false})
    : this(
        name: 'Hands',
        description:
            'This unit has hands or at least some fancy manipulators. '
            'As the game revolves around robotic humanoids you can imagine how this trait is a key ingredient for a few features.\n\n'
            '- Hands will allow units to Climb. Units with the Climb trait can climb faster. However, just having Hands can allow you to efficiently get over smaller obstacles or buildings, etc. While not something you may do often, don’t forget you can. See Climbing for more specific details on climbing.\n'
            '- Units with Hands will be able to pick things up and put them down much easier than other units. This is why Gears and Striders have certain additional customization options past other type of units. They can easily put one handheld weapon down and pick up a different one.\n'
            '- With some exceptions, handheld weapons are typically considered Reaction Weapons. This is more of a built-in feature than something you have to remember while playing. '
            'However, it’s useful to remember that during CG construction any upgrades that provide a handheld weapon are able to be used for Reactions unless explained otherwise. '
            'The main exception is HGs and PZs, which are not normally considered Reaction/Retaliation-based weapons.',
        isAux: isAux,
      );

  const Trait.haywire({bool isAux = false})
    : this(
        name: 'Haywire',
        description:
            'Haywire is a Trait you will find on some weapons. ECMs can also be used to ‘Haywire’ enemy units via ECM Attacks. '
            'So, you can think of ECM Attacks as also having the Haywire trait.\n\n'
            '- Weapons with the Haywire trait automatically apply the Haywire status to the target on a successful attack.\n'
            '- ECM Attacks also apply the Haywire status when they succeed.\n\n'
            'Being Haywired comes with 2 things:\n'
            '1. Your unit might take Haywire damage. Roll 1D6. On a 4 or better, your unit takes 1 Damage.\n'
            '2. Haywired units have a negative modifier of -1D6 on all PI, GU and EW Rolls for the rest of the Round.\n\n'
            '- Place a Haywire token next to any units that become Haywired. Remove these tokens during the Cleanup phase. '
            'Haywired tokens may not be removed by the Patch action.\n\n'
            'Notes:\n'
            '- Resist:H and Vuln:H will increase or decrease the likelihood of Haywire Damage but do not change your chances of getting the Haywired status.\n'
            '-- To reduce your chances of suffering the Haywired status, avoid enemy ECMs and try your best to not get shot by Particle Accelerators (PAs). '
            'This probably sounds snarky. But it’s not meant to. Consider Cover when being shot at by PAs and ECCMs as a way to mitigate an enemy ECM’s voodoo.',
        isAux: isAux,
      );

  const Trait.hiTech({bool isAux = false})
    : this(
        name: 'Hi-Tech',
        description:
            'Hi-Tech is a trait you’ll find on Automatons or Drones.\n\n'
            'Units with Hi-Tech can receive unit upgrades as any unit would (as opposed to units with the Lo-Tech trait, which are treated like Green units and have limited upgrade options past their profile). '
            'They can even become duelists.\n\n'
            'It’s the opposite of Lo-Tech. Some Automatons and Drones will have this on their Profile instead of Lo-Tech. '
            'Units with the Lo-Tech trait often have a Hi-Tech upgrade available just for enhancing an Automaton or Drone out of the Lo-Tech category.',
        isAux: isAux,
      );

  const Trait.immobilize({bool isAux = false})
    : this(
        name: 'Immobilize',
        description: 'Causes the immobilized status on a successful attack. ',
        isAux: isAux,
      );

  const Trait.initPlus({bool isAux = false})
    : this(
        name: 'Init+',
        description:
            'Init+ adds 1 to the Initiative Skill. Since Init+ applies to the Initiative and Setup rolls, this trait is intended for the Combat Group Leader (CGL). '
            'Other units can have it. However, it does not benefit you unless your CGL has it.',
        isAux: isAux,
      );

  const Trait.jetpack({bool isAux = false, int? level})
    : this(
        name: 'Jetpack',
        description:
            'Jetpacks can be used to perform Jetpack Moves. X is the number of inches in height and length that it can jump.\n\n'
            'See Jetpack Movement in the Movement Chapter for more details.',
        isAux: isAux,
        level: level,
      );

  const Trait.jump({bool isAux = false, int? level})
    : this(
        name: 'Jump',
        description:
            'Units with the Jump:X trait have enhanced Jumping ability past the standard ability inherent to the Walker (W) Movement Type.\n\n'
            'Note: Units with the W Movement Type may Jump up to half their listed Height stat.\n\n'
            'You can use the Jump:X trait to perform jumps (instead of the Height stat in the case of most gears and striders).\n'
            '- X is the number of inches in height and length that it can jump.\n'
            '- Unlike using a Jetpack, you will perform these jumps while you use your unit’s regular Movement Types (where your Jetpack-use disregards the unit’s other Movement Types).',
        isAux: isAux,
        level: level,
      );

  const Trait.la({bool isAux = false, int? level})
    : this(
        name: 'LA',
        description:
            'Weapons with the LA:X trait may only be fired X times before running out of ammunition. '
            'Mark this unit with a token to indicate the ammunition remaining.\n\n'
            'Note: Units with 2 x XYZ Weapons will use twice the ammo if they declare a Dual Strike Action with those weapons.',
        isAux: isAux,
        level: level,
      );

  const Trait.linked({bool isAux = false})
    : this(
        name: 'Linked',
        description:
            'This trait is listed before a weapon to help you easily spot – linked-weapons – which are calibrated to always be fired together. '
            'This is different from just simply having two weapons (which is written as 2 x XYZ Weapons), which may be fired individually or fired together via Dual Strike Attacks.\n\n'
            '- Weapons with the Linked trait automatically add a +1D6 modifier to attack rolls made with this weapon.',
        isAux: isAux,
      );

  const Trait.loTech({bool isAux = false})
    : this(
        name: 'Lo-Tech',
        description:
            'Units with Lo-Tech are treated like Green units and have limited upgrade options past what’s on their profile. '
            'Very similar to Green Units, Lo-Tech units are helpful towards your CG’s attrition factor.\n\n'
            '- Lo-Tech units receive a -1 Skill modifier to all Skills when out of formation with a commander.\n'
            '- Lo-Tech units cannot select Unit Upgrades unless specifically stated otherwise.',
        isAux: isAux,
      );

  const Trait.lumbering({bool isAux = false})
    : this(
        name: 'Lumbering',
        description:
            'This unit does not receive the +1D6 Defense Roll Modifier for being at Top Speed. This unit cannot perform Free Turns.',
        isAux: isAux,
      );

  const Trait.medic({bool isAux = false, int? level})
    : this(
        name: 'Medic',
        description:
            'You will use your Medics (units with the Medic:X trait) to Patch your damaged units. The Medic:X trait is a skill with X determining the skill’s value. '
            'For example, Medic:4 comes with a skill of 4, which you will use when performing Patch actions. See Patch Actions.\n\n'
            'Also, Medics have a special conditional rule that applies to them.\n\n'
            'Medic’s Grace:\n'
            '- If you use your Medics as combatants, they can be attacked with impunity.\n'
            '- If you only use your Medics for Westphalia Cabinet approved medical tasks (i.e., Patching, Evading and Hiding), your opponent will suffer immediate consequences for attacking them directly.\n\n'
            'How this relates to the rules:\n'
            '- If you only use your Medics for non-aggressive Actions, your opponent will not be able to attack them without a penalty. The following Actions are Considered non-aggressive:\n'
            '  -- Patch\n'
            '  -- Evade\n'
            '  -- Hide\n\n'
            'As long as your Medics – maintain their grace – by only performing the above actions and moving, the following penalty will apply to your opponent when they directly attack your Medics:\n'
            '- When a Medic is the primary target of an attack, immediately mark the attacking unit with a token. All attacks on this marked enemy unit receive a free Flex Die until the Cleanup phase. Remove this token during the Cleanup phase.\n\n'
            'However, if at any point during the game, you use your Medic to:\n'
            '- Attack\n'
            '- Retaliate\n'
            '- Perform EW Actions\n'
            '- Roll for Initiative\n'
            '- Issue an Order\n'
            '- Pop Smoke\n'
            '- Plant Mines\n'
            '- Forward Observe\n'
            '- or Score Objective Points in any way\n'
            'Then they are considered to have lost their grace and may be fired upon with impunity.\n\n'
            'Note: Many of the above Actions are not usually possible with Medics. For example, Medics usually don’t come with an ECM to perform EW Actions. '
            'We’re listing things like EW Actions because of how transports work. See below.\n\n'
            'This also extends to medical transports (transports with the Medic trait) and non-medical transports (transports without the Medic trait) when they transport Medics.\n'
            '- If a transport is or is carrying only Medics (units with the Medic trait), and it is directly attacked, then it too will proc a punitive Flex Die for the attack. '
            'And if a medical transport fails to refrain from aggressive actions as listed above, it may be attacked with impunity (regardless of whether there are Medics inside or not).\n'
            '- Also, if a medical transport ever transports non-medics who are not injured, they may be attacked with impunity. '
            'And if any injured infantry being carried ever attack or perform aggressive actions, then they and the medical transport may be attacked with impunity.\n\n'
            'Note: Using your medical transports to transport (uninjured) combatants is exactly – maneuvering against the enemy. '
            'Since the intent is to use the infantry to attack, medical transports delivering combatants are therefore not covered by Westphalia conventions and may be fired upon with impunity.',
        isAux: isAux,
        level: level,
      );

  const Trait.occupancy({
    this.isAux = false,
    this.level,
    required TraitType this.type,
  }) : name = 'Occupancy',
       description =
           'The Occupancy:X trait effectively lists how many units can fit inside a building.\n\n'
           'I.e., a Building with the Occupancy: 2 Cadres trait may have up to 2 infantry Cadres inside of it.\n\n'
           '- 3 Infantry Teams, Singles or Drones may be substituted in place of 1 Infantry Cadre.\n'
           '- Units do not have to spend any actions in order to enter or exit a building.',
       assert(
         type == TraitType.drones ||
             type == TraitType.nKIDUs ||
             type == TraitType.armigers ||
             type == TraitType.cadres ||
             type == TraitType.teams ||
             type == TraitType.gears,
         'Invalid type for Trait.occupancy. Allowed types are: drones, nKIDUs, armigers, cadres, teams, gears.',
       );

  const Trait.offroad({bool isAux = false})
    : this(
        name: 'Offroad',
        description:
            'Offroad is a supplemental trait for the Ground (G) movement type. It will provide two things:\n\n'
            '- Your units with the Offroad trait may move over difficult ground without being slowed down to half their speed.\n\n'
            '- Offroad will also allow units with the G movement type to still acquire their +1 inch for movement while travelling over Difficult Terrain '
            '(if they can move their MR rating in a straight line. See Movement Types). Units using G, without the Offroad trait, will not be able to acquire the same bonus if any of the movement goes over Difficult Terrain.',
        isAux: isAux,
      );

  const Trait.openTop({bool isAux = false})
    : this(
        name: 'Open Top',
        description:
            'Units like the Anakite are made to be Open Top APCs. Other units such as the Camel Truck are treated as an Open Top Transport when they carry troops '
            'because nothing on its truck bed would be enclosed. See the Transport Rules in the Movement Section for more details on Open Top Transports.',
        isAux: isAux,
      );

  const Trait.precise({bool isAux = false})
    : this(
        name: 'Precise',
        description:
            'Precision tools come in a handful of different variations:\n\n'
            '- Ranged weapons with the Precise trait add +1 to the result rolled (+1 R) when used in Optimal range.\n'
            '- Melee weapons with the Precise trait add +1 to the result rolled (+1 R) when used to attack.\n'
            '- Multiple sources of Precise are not cumulative. Precise will only ever provide a single +1 R to the attack roll.',
        isAux: isAux,
      );

  const Trait.precisePlus({bool isAux = false})
    : this(
        name: 'Precise+',
        description:
            'Precision tools with the Precise+ trait provide additional benefits:\n\n'
            '- Ranged weapons with the Precise+ trait add +1 to the result rolled (+1 R) when used in Optimal Range and out to the maximum range (Max Sub-Optimal Range).\n'
            '- Precise+ does not benefit melee weapons further than Precise.\n'
            '- Multiple sources of Precise+ are not cumulative. Precise+ will only ever provide a single +1 R to the attack roll.',
        isAux: isAux,
      );

  const Trait.proximity({bool isAux = false})
    : this(
        name: 'Proximity',
        description:
            'This weapon projects its attack all around this unit at close range.\n\n'
            '- The AOE is centered on this unit.\n'
            '- This unit is not damaged by this attack.\n'
            '- All other units (friendly or enemy) caught by the AOE are considered Primary targets.\n'
            '- This weapon cannot be used to attack elevated VTOLs unless the model using it is also an elevated VTOL.\n'
            '- Elevated VTOLs cannot use this weapon to attack non-elevated VTOLs.\n'
            '- This weapon cannot be used to attack buildings or terrain.\n\n'
            'Note: APGLs are not meant to be your primary anti-infantry weapon. However, they can damage lower-armored units from splash damage too. So, don’t hit that button unless you mean it.',
        isAux: isAux,
      );

  const Trait.r({bool isAux = false})
    : this(
        name: 'R',
        description:
            'A weapon with this trait can only be fired at targets within the model’s Right Arc.\n\n'
            'See Arcs for more information on all Arcs.',
        isAux: isAux,
      );

  const Trait.reach({bool isAux = false, int? level})
    : this(
        name: 'Reach',
        description:
            'This melee weapon can attack a target X inches from its base.\n\n'
            '- This is not considered a ranged attack.\n'
            '- This can be useful for avoiding Lockup by allowing you to attack with melee weapons from a slight distance.\n'
            '- This can also neutralize their possible melee counters if they cannot also ‘Reach’ you.',
        isAux: isAux,
        level: level,
      );

  const Trait.react({bool isAux = false})
    : this(
        name: 'React',
        description:
            'React Weapons can be used for Retaliations.\n\n'
            'Normally, React Weapons are just weapons found in the React column of your unit’s profile. '
            'You may encounter an upgrade that specifically declares that a weapon is a React Weapon. This is just to let you know it would go into the React Column if it were on the unit’s profile.',
        isAux: isAux,
      );

  const Trait.reactPlus({bool isAux = false})
    : this(
        name: 'React+',
        description:
            'Units with the React+ trait have a special ability:\n\n'
            '- This unit may perform 1 Reaction per Round without spending an Action point.\n'
            '- You may also Focus this Reaction by paying 1 Action point.',
        isAux: isAux,
      );

  const Trait.reflex({bool isAux = false})
    : this(
        name: 'Reflex',
        description:
            'When attacking with a weapon with the Reflex trait, cancel the enemy unit’s Agile trait (if it has it).\n\n'
            '- Reflex does not cancel the effect of Agile+.',
        isAux: isAux,
      );

  const Trait.repair({bool isAux = false, int? level})
    : this(
        name: 'Repair',
        description:
            'You can use this unit to perform Patch actions. X is the skill rating.\n\n'
            'See Patch actions for details on how to Repair your units of damage and some status effects.',
        isAux: isAux,
        level: level,
      );

  const Trait.resist({bool isAux = false, TraitType? type})
    : this(
        name: 'Resist',
        description:
            'Resist:X on a unit marks a Resistance it has against certain types of Damage.\n\n'
            'There are three different types of Resist:Xs:\n'
            '- Resist:F (Fire)\n'
            '- Resist:C (Corrosion)\n'
            '- Resist:H (Haywire)\n\n'
            'Whenever a unit encounters a roll for the extra damage associated with their resistance, then the threshold number goes up by 1. '
            'For example, instead of taking damage on a roll of 4 or higher, this unit will only take damage on a roll of 5 or higher.',
        isAux: isAux,
        type: type,
      );

  const Trait.satUp({bool isAux = false})
    : this(
        name: 'SatUp',
        description:
            'SatUps help secure your unit’s communications.\n\n'
            'Note: SatUps are only useful to units that already come with the E-Comms trait. This is because they are related to the E-Comms modifier of +1D6 for Issuing Orders and performing Forward Observations (FOs).\n\n'
            '- The E-Comms trait provides the +1D6 modifier only for Unopposed Rolls.\n'
            '- The SatUp trait allows this unit’s E-Comms bonus to also take effect during Opposed Rolls.\n\n'
            'This makes your communications harder to Jam.',
        isAux: isAux,
      );

  const Trait.sensorBoom({bool isAux = false})
    : this(
        name: 'Sensor Boom',
        description:
            'This unit may check LOS and Target Locks from a point up to 1” away from the unit’s model.\n\n'
            'This unit may then use this LOS and any Targeting Locks to make Indirect Attacks, perform Forward Observations (with TD to boot), or even use other EW Actions.\n\n'
            'Note: The only reason the unit with the Sensor Boom cannot attack Directly is because everything that’s not the Sensor Boom is still assumed to be behind Full Cover.',
        isAux: isAux,
      );

  const Trait.sensor({bool isAux = false, int? level})
    : this(
        name: 'Sensor',
        description:
            'Sensor:X provides this unit with 3 features:\n\n'
            '1 This unit has a sensor range of “X” inches.\n'
            '2 This unit may share any Targeting Locks it has with units In-Formation with it. This does not cost an Action point or require a Roll. It’s considered constant as long as the units are In-Formation.\n'
            '3 Only units with the Sensor:X trait may be used to initiate Counterstrikes. This is because a unit is required to have the Sensor:X trait in order to acquire a Counter-Battery Sensor Lock (CBS Lock).\n\n'
            'See Sensors and Counterstrikes for additional details on Targeting Locks and Counterstrikes.',
        isAux: isAux,
        level: level,
      );

  const Trait.shield({bool isAux = false})
    : this(
        name: 'Shield',
        description:
            'Prior to rolling Defense for an attack originating from this unit’s Front Arc, perform a PI Check.\n\n'
            'Success provides this unit with +1 to the Result for the following defense roll.',
        isAux: isAux,
      );

  const Trait.silent({bool isAux = false})
    : this(
        name: 'Silent',
        description:
            'Units do not lose the Hidden Status when attacking with a weapon that has the Silent trait.',
        isAux: isAux,
      );

  const Trait.smoke({bool isAux = false})
    : this(
        name: 'Smoke',
        description:
            'This unit comes with – Smoke Grenades –. Smoke Launchers are more common on Vehicles and Hand-Thrown Smoke Grenades are more common on Gears.\n\n'
            'See the Pop Smoke Action for more detailed steps in their use. Keep an eye out for upgrades you can use to fire smoke grenades via a unit’s GL or IGL (for more range).',
        isAux: isAux,
      );

  const Trait.sp1({bool isAux = false})
    : this(
        name: 'SP+1',
        description:
            'This unit will gain 1 Skill Point (1 SP) in addition to any it may have from other sources. '
            'If the unit is upgraded to a commander, its SP will automatically convert into CP.\n\n'
            'SPs can be spent for Flex Die, if you’re into that kind of thing. 1 SP will provide 1 Flex Die.',
        isAux: isAux,
        level: 1,
      );

  const Trait.spray({bool isAux = false})
    : this(
        name: 'Spray',
        description:
            'Units attacked with this weapon do not gain defense modifiers from Partial Cover. '
            'This weapon is likely a flamer, AKA flame thrower. This weapon is also the one ranged weapon that cannot be fired through Full Light Cover.',
        isAux: isAux,
      );

  const Trait.stable({bool isAux = false})
    : this(
        name: 'Stable',
        description:
            'This Weapon does not suffer the -1D6 modifier for attacking at Top Speed.\n\n'
            'You will find this on certain weapons that have an advanced fire-control system, such as the one found on the Aller incorporated with its main cannon. '
            'And note, while the Aller has Lumbering, its main cannon has Stable.',
        isAux: isAux,
      );

  const Trait.stationary({bool isAux = false})
    : this(
        name: 'Stationary',
        description:
            'This unit is a building.\n\n'
            'Buildings:\n'
            '- Are always braced,\n'
            '- Cannot move or turn,\n'
            '- And may not Plant Mines, Hide or Evade.',
        isAux: isAux,
      );

  const Trait.stealth({bool isAux = false})
    : this(
        name: 'Stealth',
        description:
            'Enemy units cannot Target Lock this unit until it is within half their Sensor Range.\n\n'
            'For example, a unit with a standard sensor range of 18 inches can only Target Lock a unit with the Stealth trait at 9 inches or less.\n\n'
            'Note: This can be a passive counter to many E-War actions and can even reduce the effectiveness of Indirect Attacks.',
        isAux: isAux,
      );

  const Trait.sub({bool isAux = false})
    : this(
        name: 'Sub',
        description:
            'This unit uses its full MR through Water.\n\n'
            'When in water, this unit is assumed to be traveling just below the surface.\n'
            '- While in water, this unit has Partial Cover.\n\n'
            'Units with the Sub trait may use the Submerged Special Deployment option. See Submerged Deployment.',
        isAux: isAux,
      );

  const Trait.supply({bool isAux = false})
    : this(
        name: 'Supply',
        description:
            'Units with this trait may perform the Reload Action to replenish ammunition for weapons with the LA:X trait.\n\n'
            'See the Reload action.',
        isAux: isAux,
      );

  const Trait.td({bool isAux = false})
    : this(
        name: 'TD',
        description:
            'A Target Designator (TD) is a precision laser marking device your units may use to help steer guided weapons to a target.\n\n'
            'In order to use the TD, you must successfully perform a Forward Observation (FO) action with LOS and a Target Lock '
            '(Note: FOs without a TD do not require LOS and only require a Targeting Lock).\n\n'
            'After a successful FO using a TD, Fire Missions using Guided Weapons receive +1 on the Result Die for the Attack Roll for the Primary Target '
            'in addition to the regular +1D6 bonus from the FO.\n\n'
            '-- See Forward Observations and Fire Missions for the full details about performing them.',
        isAux: isAux,
      );

  const Trait.towed({bool isAux = false})
    : this(
        name: 'Towed',
        description:
            'A unit with this trait may be towed behind a gear, strider or vehicle with the W or G movement type.\n\n'
            'See Towed in the Movement Section.',
        isAux: isAux,
      );

  const Trait.transport({
    this.isAux = false,
    this.level,
    required TraitType this.type,
  }) : name = 'Transport',
       description =
           'This unit may transport or carry other units.\n\n'
           'For example, an APC might have the trait Transport: 2 Cadres. This is simply letting you know that APC can carry 2 Cadres of Infantry. '
           'There are often substitutions allowed, especially for infantry as they can be organized into Cadres or Teams.\n\n'
           'See Transports in the Movement section for more details on how to use Transports.',
       assert(
         type == TraitType.drones ||
             type == TraitType.nKIDUs ||
             type == TraitType.armigers ||
             type == TraitType.cadres ||
             type == TraitType.teams ||
             type == TraitType.gears,
         'Invalid type for Trait.transport. Allowed types are: drones, nKIDUs, armigers, cadres, teams, gears.',
       );

  const Trait.t({bool isAux = false})
    : this(
        name: 'T',
        description:
            '- A turret mounted weapon has 360-degree rotation and can be used to fire within any Arc.\n'
            '- Turrets do not remove the back arc modifier when this unit is attacked.\n\n'
            'Note: Sometimes a weapon is clearly mounted on a ‘turret’, but it does not always have the (T) next to it to indicate it is on a turret. '
            'This is because the Turret in question probably can’t actually turn all the way around. For example, the HHT-90’s HRL is on a smaller forward turret. '
            'But it’s pointless to even try to turn the turret all the way around because the tank’s superstructure would block the HRLs shots. Just modelling it that way would seem rather odd.\n\n'
            'So, if the Turret (T) trait is not where you would expect it, it’s more than likely because the Turret in question can’t actually rotate all the way around.',
        isAux: isAux,
      );

  const Trait.vtol({bool isAux = false})
    : this(
        name: 'VTOL',
        description:
            'This unit can take to the sky or get low via NOE.\n\n'
            'See VTOLs for specific details on how to use the VTOL trait when moving.',
        isAux: isAux,
      );

  const Trait.vuln({this.isAux = false, required TraitType this.type})
    : name = 'Vuln',
      description =
          'Vuln:X is the opposite of Resist:X. Units with the Vuln:X trait are specifically Vulnerable to certain types of Damage.\n\n'
          'There are three different types of Vuln:Xs:\n'
          '- Vuln:F (Fire)\n'
          '- Vuln:C (Corrosion)\n'
          '- Vuln:H (Haywire)\n\n'
          'Whenever a unit encounters a roll for the extra damage associated with their vulnerability, then the threshold number goes down by 1. '
          'For example, instead of taking damage on a roll of 4 or higher, this unit will only take damage on a roll of 3 or higher.',
      level = null,
      assert(
        type == TraitType.h || type == TraitType.c || type == TraitType.f,
        'Invalid type for Trait.vuln. Allowed types are: H, C, F.',
      );
}
