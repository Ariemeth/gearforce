import 'package:gearforce/src/models/roster/weapon/weapon.dart';
import 'package:gearforce/src/predefined/trait_factory.dart';
import 'package:gearforce/src/predefined/weapon_factory.dart';

class WeaponParser {
  /// Parses a string like "2 x LATM (LA:2)" or "LATM (LA:2, Precise)" into a `Weapon` object.
  static Weapon parseWeaponString(String input, {bool hasReact = false}) {
    // Remove "2 x" or "2 X" from the start of the string
    final trimmedInput = input
        .trim()
        .replaceFirst(RegExp(r'^2\s+x\s+', caseSensitive: false), '');

    final regex = RegExp(r'^(?<code>\w+)\s*\((?<traits>.+)\)$');
    final match = regex.firstMatch(trimmedInput);

    if (match == null) {
      // If no traits are provided, just fetch the weapon by code
      final weapon =
          WeaponFactory.getWeaponByCode(trimmedInput, hasReact: hasReact);
      if (weapon == null) {
        throw ArgumentError('Invalid weapon code: $input');
      }
      return weapon;
    }

    final code = match.namedGroup('code')!.trim();
    final traitsString = match.namedGroup('traits')!;
    final additionalTraits = traitsString
        .split(',')
        .map((trait) => TraitFactory.traitFromString(trait.trim()))
        .toList();

    final baseWeapon = WeaponFactory.getWeaponByCode(code, hasReact: hasReact);
    if (baseWeapon == null) {
      throw ArgumentError('Invalid weapon code: $code');
    }

    // Add additional traits to the weapon
    return baseWeapon.copyWith(
      primaryTraits: additionalTraits,
      replacePrimaryTraits: false,
      secondaryTraits:
          baseWeapon.secondaryTraits != null ? additionalTraits : null,
      replaceSecondaryTraits: false,
    );
  }
}
