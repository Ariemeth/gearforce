import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/data/static/weapon_factory.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

class WeaponParser {
  /// Parses a string like "2 x LATM (LA:2)", "2x LAC", or "LATM (LA:2, Precise)"
  /// into a list of [WeaponSpec]s.
  ///
  /// If the input includes a multiplier prefix like "2 x" or "2x", the list
  /// will contain that many independent [WeaponSpec] instances (e.g., 2 weapons).
  static List<WeaponSpec> parseWeaponString(
    String input, {
    bool hasReact = false,
  }) {
    final trimmedInput = input.trim();

    final quantityRegex = RegExp(
      r'^(?<count>\d+)\s*x\s*',
      caseSensitive: false,
    );
    final quantityMatch = quantityRegex.firstMatch(trimmedInput);

    int count = 1;
    String weaponInput = trimmedInput;

    if (quantityMatch != null) {
      count = int.parse(quantityMatch.namedGroup('count')!);
      weaponInput = trimmedInput.substring(quantityMatch.end);
    }

    final singleSpec = parseSingleWeaponSpec(weaponInput, hasReact: hasReact);

    return List.generate(count, (_) => singleSpec.copySpec());
  }

  /// Parses a single weapon spec string without quantity prefix expansion.
  static WeaponSpec parseSingleWeaponSpec(
    String input, {
    bool hasReact = false,
  }) {
    final trimmedInput = input.trim().replaceFirst(
      RegExp(r'^\d+\s*x\s*', caseSensitive: false),
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
      r'^(?<code1>[a-zA-Z]+)/?(?<code2>[a-zA-Z]+)?\s*(?:\((?<traits>.+)\))?$',
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

    final baseWeapon1 = WeaponFactory.getWeaponByCode(code1);
    if (baseWeapon1 == null) {
      throw ArgumentError('Invalid weapon1 code: $code1');
    }

    final code2 = match.namedGroup('code2');
    if (code2 == null) {
      return SingleWeaponSpec(
        weapon: baseWeapon1,
        customTraits: additionalTraits,
        isReact: hasReact,
      );
    }

    final baseWeapon2 = WeaponFactory.getWeaponByCode(code2);
    if (baseWeapon2 == null) {
      throw ArgumentError('Invalid weapon2 code: $code2');
    }

    return ComboWeaponSpec(
      weapon1: baseWeapon1,
      weapon2: baseWeapon2,
      customTraits: additionalTraits,
      isReact: hasReact,
    );
  }
}
