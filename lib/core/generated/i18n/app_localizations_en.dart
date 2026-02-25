// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gearforce';

  @override
  String get rosterNameField => 'Roster Name';

  @override
  String get rosterNameInputFieldHint => 'Enter a roster name';

  @override
  String get factionSelectDropdownHint => 'Select a Faction';

  @override
  String get subfactionSelectDropdownHint => 'Select a Subfaction';

  @override
  String get addSquadButtonText => 'Add Squad';

  @override
  String get noSquadsText => 'There are no squads in the combat group.';

  @override
  String get squadPrimaryRoleLabelText => 'Primary Role';

  @override
  String get squadSecondaryRoleLabelText => 'Secondary Role';

  @override
  String get squadRoleNoneText => 'None';

  @override
  String get squadAddUnitButtonText => 'Add a unit';

  @override
  String get removeSquadConfirmTitle => 'Remove Squad';

  @override
  String removeSquadConfirmMessage(String squadName) {
    return 'Are you sure you want to remove \"$squadName\"?';
  }

  @override
  String get cancelButtonText => 'Cancel';

  @override
  String get removeButtonText => 'Remove';

  @override
  String appSettingsTitle(String appName) {
    return '$appName Settings';
  }

  @override
  String aboutAppTitle(String appName) {
    return 'About $appName';
  }

  @override
  String get settingsThemeLabel => 'Theme';

  @override
  String get settingsThemeHelper => 'Choose how the app looks';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get weaponsTitle => 'Weapons';

  @override
  String get weaponsTableTitle => 'Weapons Table';

  @override
  String get weaponColumnCode => 'Code';

  @override
  String get weaponColumnName => 'Name';

  @override
  String get weaponColumnRange => 'Range';

  @override
  String get weaponColumnDamage => 'Damage';

  @override
  String get weaponColumnTraits => 'Traits';

  @override
  String get weaponColumnMode => 'Mode';

  @override
  String get selectUnitTitle => 'Select a Unit';

  @override
  String variantsCount(int count) {
    return '$count variants';
  }

  @override
  String get noCombatGroupsText => 'No combat groups available';

  @override
  String combatGroupTitle(int number) {
    return 'Combat Group $number';
  }

  @override
  String squadRoleLabel(String role) {
    return 'Squad: $role';
  }

  @override
  String secondaryRoleLabel(String role) {
    return 'Secondary Role: $role';
  }

  @override
  String unitLabel(String name) {
    return 'Unit: $name';
  }

  @override
  String tvLabel(int value) {
    return 'TV: $value';
  }

  @override
  String actionsLabel(int value) {
    return 'Actions: $value';
  }

  @override
  String get removeUnitTooltip => 'Remove unit';

  @override
  String get rosterSettingsTooltip => 'Roster Settings';

  @override
  String get factionLabel => 'Faction: ';

  @override
  String get subFactionLabel => 'Sub-Faction: ';

  @override
  String defaultSquadName(int number) {
    return 'Squad $number';
  }

  @override
  String squadNotFoundTitle(int id) {
    return 'Squad $id';
  }

  @override
  String squadNotFoundMessage(int id) {
    return 'No Squad with id $id is found';
  }

  @override
  String get attributeTV => 'TV';

  @override
  String get attributeRoles => 'Roles';

  @override
  String get attributeMove => 'Move';

  @override
  String get attributeArm => 'Arm';

  @override
  String get attributeHS => 'H/S';

  @override
  String get attributeA => 'A';

  @override
  String get attributeGu => 'Gu';

  @override
  String get attributePi => 'Pi';

  @override
  String get attributeEw => 'Ew';

  @override
  String get reactWeaponsLabel => 'React Weapons:';

  @override
  String get mountedWeaponsLabel => 'Mounted Weapons:';

  @override
  String get traitsLabel => 'Traits:';
}
