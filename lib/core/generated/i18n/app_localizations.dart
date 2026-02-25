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

  /// Title for the squad details card
  ///
  /// In en, this message translates to:
  /// **'Squad Details'**
  String get squadDetailsTitleText;

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
