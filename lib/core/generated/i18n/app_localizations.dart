import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Gearforce'**
  String get appTitle;

  /// Label for the roster name text field
  ///
  /// In en, this message translates to:
  /// **'Roster Name'**
  String get rosterNameField;

  /// Hint text for the roster name text input field
  ///
  /// In en, this message translates to:
  /// **'Enter a roster name'**
  String get rosterNameInputFieldHint;

  /// Hint text on the faction selection dropdown sugggesting that a faction needs to be selected
  ///
  /// In en, this message translates to:
  /// **'Select a Faction'**
  String get factionSelectDropdownHint;

  /// Hint text on the subfaction selection dropdown sugggesting that a subfaction needs to be selected
  ///
  /// In en, this message translates to:
  /// **'Select a Subfaction'**
  String get subfactionSelectDropdownHint;

  /// Text for the button that adds a new squad to the roster
  ///
  /// In en, this message translates to:
  /// **'Add Squad'**
  String get addSquadButtonText;

  /// Text displayed when there are no squads in the combat group
  ///
  /// In en, this message translates to:
  /// **'There are no squads in the combat group.'**
  String get noSquadsText;

  /// Label for the primary role dropdown in the squad card
  ///
  /// In en, this message translates to:
  /// **'Primary Role'**
  String get squadPrimaryRoleLabelText;

  /// Label for the secondary role dropdown in the squad card
  ///
  /// In en, this message translates to:
  /// **'Secondary Role'**
  String get squadSecondaryRoleLabelText;

  /// Text for the 'None' option in the role dropdown
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get squadRoleNoneText;

  /// Text for the button that adds a new unit to the squad
  ///
  /// In en, this message translates to:
  /// **'Add a unit'**
  String get squadAddUnitButtonText;

  /// Title for the remove squad confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Remove Squad'**
  String get removeSquadConfirmTitle;

  /// Confirmation message when removing a squad
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove \"{squadName}\"?'**
  String removeSquadConfirmMessage(String squadName);

  /// Text for the cancel button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonText;

  /// Text for the remove button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeButtonText;

  /// Title for the app settings screen
  ///
  /// In en, this message translates to:
  /// **'{appName} Settings'**
  String appSettingsTitle(String appName);

  /// Title for the about section in the drawer
  ///
  /// In en, this message translates to:
  /// **'About {appName}'**
  String aboutAppTitle(String appName);

  /// Label for the theme dropdown in settings
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeLabel;

  /// Helper text for the theme dropdown in settings
  ///
  /// In en, this message translates to:
  /// **'Choose how the app looks'**
  String get settingsThemeHelper;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// Title for the weapons display screen
  ///
  /// In en, this message translates to:
  /// **'Weapons'**
  String get weaponsTitle;

  /// Title for the weapons table menu item in the drawer
  ///
  /// In en, this message translates to:
  /// **'Weapons Table'**
  String get weaponsTableTitle;

  /// Column header for weapon code
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get weaponColumnCode;

  /// Column header for weapon name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get weaponColumnName;

  /// Column header for weapon range
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get weaponColumnRange;

  /// Column header for weapon damage
  ///
  /// In en, this message translates to:
  /// **'Damage'**
  String get weaponColumnDamage;

  /// Column header for weapon traits
  ///
  /// In en, this message translates to:
  /// **'Traits'**
  String get weaponColumnTraits;

  /// Column header for weapon mode
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get weaponColumnMode;

  /// Title for the unit selection screen
  ///
  /// In en, this message translates to:
  /// **'Select a Unit'**
  String get selectUnitTitle;

  /// Label showing the number of variants for a unit
  ///
  /// In en, this message translates to:
  /// **'{count} variants'**
  String variantsCount(int count);

  /// Text displayed when there are no combat groups
  ///
  /// In en, this message translates to:
  /// **'No combat groups available'**
  String get noCombatGroupsText;

  /// Title for a combat group
  ///
  /// In en, this message translates to:
  /// **'Combat Group {number}'**
  String combatGroupTitle(int number);

  /// Label for a squad with its primary role
  ///
  /// In en, this message translates to:
  /// **'Squad: {role}'**
  String squadRoleLabel(String role);

  /// Label for a squad secondary role
  ///
  /// In en, this message translates to:
  /// **'Secondary Role: {role}'**
  String secondaryRoleLabel(String role);

  /// Label for a unit in a list
  ///
  /// In en, this message translates to:
  /// **'Unit: {name}'**
  String unitLabel(String name);

  /// Label for TV (threat value)
  ///
  /// In en, this message translates to:
  /// **'TV: {value}'**
  String tvLabel(int value);

  /// Label for total TV (threat value) across all squads
  ///
  /// In en, this message translates to:
  /// **'Total TV: {value}'**
  String totalTvLabel(int value);

  /// Label for total actions
  ///
  /// In en, this message translates to:
  /// **'Actions: {value}'**
  String actionsLabel(int value);

  /// Tooltip for the remove unit button
  ///
  /// In en, this message translates to:
  /// **'Remove unit'**
  String get removeUnitTooltip;

  /// Text for delete action button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonText;

  /// Text for duplicate action button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicateButtonText;

  /// Title text for model actions dialog
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get modelActionsTitle;

  /// Tooltip text for model actions button
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get modelActionsTooltip;

  /// Tooltip for the roster settings button
  ///
  /// In en, this message translates to:
  /// **'Roster Settings'**
  String get rosterSettingsTooltip;

  /// Label for the faction selector
  ///
  /// In en, this message translates to:
  /// **'Faction: '**
  String get factionLabel;

  /// Label for the sub-faction selector
  ///
  /// In en, this message translates to:
  /// **'Sub-Faction: '**
  String get subFactionLabel;

  /// Default name for a new squad
  ///
  /// In en, this message translates to:
  /// **'Squad {number}'**
  String defaultSquadName(int number);

  /// Title shown when a squad is not found
  ///
  /// In en, this message translates to:
  /// **'Squad {id}'**
  String squadNotFoundTitle(int id);

  /// Message shown when a squad is not found
  ///
  /// In en, this message translates to:
  /// **'No Squad with id {id} is found'**
  String squadNotFoundMessage(int id);

  /// Column header abbreviation for Threat Value
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get attributeTV;

  /// Column header for Roles
  ///
  /// In en, this message translates to:
  /// **'Roles'**
  String get attributeRoles;

  /// Column header abbreviation for Movement
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get attributeMove;

  /// Column header abbreviation for Armor
  ///
  /// In en, this message translates to:
  /// **'Arm'**
  String get attributeArm;

  /// Column header abbreviation for Hull/Structure
  ///
  /// In en, this message translates to:
  /// **'H/S'**
  String get attributeHS;

  /// Column header abbreviation for Actions
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get attributeA;

  /// Column header abbreviation for Gunnery
  ///
  /// In en, this message translates to:
  /// **'Gu'**
  String get attributeGu;

  /// Column header abbreviation for Piloting
  ///
  /// In en, this message translates to:
  /// **'Pi'**
  String get attributePi;

  /// Column header abbreviation for Electronic Warfare
  ///
  /// In en, this message translates to:
  /// **'Ew'**
  String get attributeEw;

  /// Label for the react weapons row
  ///
  /// In en, this message translates to:
  /// **'React Weapons:'**
  String get reactWeaponsLabel;

  /// Label for the mounted weapons row
  ///
  /// In en, this message translates to:
  /// **'Mounted Weapons:'**
  String get mountedWeaponsLabel;

  /// Label for the traits row
  ///
  /// In en, this message translates to:
  /// **'Traits:'**
  String get traitsLabel;

  /// Title for the roster summary panel on expanded screens
  ///
  /// In en, this message translates to:
  /// **'Roster Summary'**
  String get rosterSummaryTitle;

  /// Label for total number of squads
  ///
  /// In en, this message translates to:
  /// **'Squads: {value}'**
  String totalSquadsLabel(int value);

  /// Label for total number of models
  ///
  /// In en, this message translates to:
  /// **'Models: {value}'**
  String totalModelsLabel(int value);

  /// Label for total number of units in a squad
  ///
  /// In en, this message translates to:
  /// **'Units: {value}'**
  String totalUnitsLabel(int value);

  /// Label showing the selected faction name
  ///
  /// In en, this message translates to:
  /// **'Faction: {name}'**
  String factionFieldLabel(String name);

  /// Label showing the selected sub-faction name
  ///
  /// In en, this message translates to:
  /// **'Sub-Faction: {name}'**
  String subFactionFieldLabel(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
