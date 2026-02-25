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
  String get squadDetailsTitleText => 'Squad Details';

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
}
