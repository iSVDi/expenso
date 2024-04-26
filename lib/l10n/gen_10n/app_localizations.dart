import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @noCategory.
  ///
  /// In en, this message translates to:
  /// **'no category'**
  String get noCategory;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @enterCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get enterCategoryName;

  /// No description provided for @expensesAnalysis.
  ///
  /// In en, this message translates to:
  /// **'expenses'**
  String get expensesAnalysis;

  /// No description provided for @historyPlugTitle.
  ///
  /// In en, this message translates to:
  /// **'start making expenses and statistics by category will appear here'**
  String get historyPlugTitle;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add comment'**
  String get addComment;

  /// No description provided for @spentToday.
  ///
  /// In en, this message translates to:
  /// **'Spent today'**
  String get spentToday;

  /// No description provided for @enterComment.
  ///
  /// In en, this message translates to:
  /// **'Enter comment'**
  String get enterComment;

  /// No description provided for @areYouSureTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete '**
  String get areYouSureTitle;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'category name'**
  String get categoryName;

  /// No description provided for @createCategory.
  ///
  /// In en, this message translates to:
  /// **'create category'**
  String get createCategory;

  /// No description provided for @myCategories.
  ///
  /// In en, this message translates to:
  /// **'my categories'**
  String get myCategories;

  /// No description provided for @welcome1Title.
  ///
  /// In en, this message translates to:
  /// **'enter\nspent amount'**
  String get welcome1Title;

  /// No description provided for @welcome2Title.
  ///
  /// In en, this message translates to:
  /// **'select date and time\nif transaction were\nmade earlier'**
  String get welcome2Title;

  /// No description provided for @welcome3Title.
  ///
  /// In en, this message translates to:
  /// **'select\ntransaction\'s category'**
  String get welcome3Title;

  /// No description provided for @welcome4Title.
  ///
  /// In en, this message translates to:
  /// **'create category\nif it isn\'t at list'**
  String get welcome4Title;

  /// No description provided for @welcome5Title.
  ///
  /// In en, this message translates to:
  /// **'select your\ntransactions\' categories'**
  String get welcome5Title;

  /// No description provided for @welcome6Title.
  ///
  /// In en, this message translates to:
  /// **'analyze your\neXpenses'**
  String get welcome6Title;

  /// No description provided for @continueIntro.
  ///
  /// In en, this message translates to:
  /// **'continue introduction'**
  String get continueIntro;

  /// No description provided for @itsMyCategories.
  ///
  /// In en, this message translates to:
  /// **'this\'s my categories'**
  String get itsMyCategories;

  /// No description provided for @startUsing.
  ///
  /// In en, this message translates to:
  /// **'start using'**
  String get startUsing;

  /// No description provided for @secondsTitle.
  ///
  /// In en, this message translates to:
  /// **'{numeric} s'**
  String secondsTitle(Object numeric);

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'appearance'**
  String get appearanceTitle;

  /// No description provided for @systemThemeMode.
  ///
  /// In en, this message translates to:
  /// **'system'**
  String get systemThemeMode;

  /// No description provided for @darkThemeMode.
  ///
  /// In en, this message translates to:
  /// **'dark'**
  String get darkThemeMode;

  /// No description provided for @lightThemeMode.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get lightThemeMode;

  /// No description provided for @startCategories.
  ///
  /// In en, this message translates to:
  /// **'🏠 household,⛽️ gas,🛒 groceries,🛍 shopping,🍽 food & dinning,🚕 transport,💊 health,💪 fitness,🎓 education,🍿 entertainment,💸 bills,🐱 🐶 pet,🎁 gifts,❓ other'**
  String get startCategories;

  /// No description provided for @spendInAWeek.
  ///
  /// In en, this message translates to:
  /// **'spend in a week'**
  String get spendInAWeek;

  /// No description provided for @spendInAMonth.
  ///
  /// In en, this message translates to:
  /// **'spend in a month'**
  String get spendInAMonth;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
