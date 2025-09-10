import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:gearforce/src/predefined/trait_factory.dart';
import 'package:gearforce/src/predefined/weapon_factory.dart';

class WeaponParser {
  /// Parses a string like "2 x LATM (LA:2)" or "LATM (LA:2, Precise)" into a `Weapon` object.
  static WeaponSpec parseWeaponString(String input, {bool hasReact = false}) {
    // Remove "2 x" or "2 X" from the start of the string
    final trimmedInput = input.trim().replaceFirst(
      RegExp(r'^2\s+x\s+', caseSensitive: false),
      '',
    );

    // The code1 named group will match on either a single weapon or the first part of a combo weapon
    // The code2 named group will match on the second weapon of a combo weapon
    // The traits named group will match on any custom traits the weapon will have
    /*
    This regex has been verified against the following strings
    LATM
    LATM (LA:2)
    LATM(LA:2)
    LATM (LA:2, Precise)
    LAC/LFC
    LAC/LFC (LA:2)
    LAC/LFC(LA:2)
    LAC/LFC (LA:2, Precise)
     */
    final weaponParsingRegex = RegExp(
      r'^(?<code1>[a-zA-Z]+)(?:\/)?(?<code2>[a-zA-Z]+)?\s*(?:\((?<traits>.+)\))?$',
    );
    final match = weaponParsingRegex.firstMatch(trimmedInput);

    if (match == null) {
      throw ArgumentError('Invalid weapon code: $input');
    }

    final code1 = match.namedGroup('code1');
    if (code1 == null) {
      throw ArgumentError('Invalid weapon code1: $input');
    }
    final traitsString = match.namedGroup('traits');
    final List<Trait> additionalTraits = traitsString == null
        ? const []
        : traitsString
              .split(',')
              .map((trait) => TraitFactory.traitFromString(trait.trim()))
              .toList();

    final baseWeapon1 = WeaponFactory.getWeaponByCode(
      code1,
      hasReact: hasReact,
    );
    if (baseWeapon1 == null) {
      throw ArgumentError('Invalid weapon1 code: $code1');
    }

    final code2 = match.namedGroup('code2');
    if (code2 == null) {
      return SingleWeaponSpec(
        weapon: baseWeapon1,
        customTraits: additionalTraits,
      );
    }

    final baseWeapon2 = WeaponFactory.getWeaponByCode(
      code2,
      hasReact: hasReact,
    );
    if (baseWeapon2 == null) {
      throw ArgumentError('Invalid weapon2 code: $code2');
    }

    return ComboWeaponSpec(
      weapon1: baseWeapon1,
      weapon2: baseWeapon2,
      customTraits: additionalTraits,
    );
  }
}
