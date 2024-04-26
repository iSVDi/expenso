import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noCategory => 'no category';

  @override
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get enterCategoryName => 'Enter category name';

  @override
  String get expensesAnalysis => 'expenses';

  @override
  String get historyPlugTitle => 'start making expenses and statistics by category will appear here';

  @override
  String get view => 'View';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get addComment => 'Add comment';

  @override
  String get spentToday => 'Spent today';

  @override
  String get enterComment => 'Enter comment';

  @override
  String get areYouSureTitle => 'Are you sure you want to delete ';

  @override
  String get categoryName => 'category name';

  @override
  String get createCategory => 'create category';

  @override
  String get myCategories => 'my categories';

  @override
  String get welcome1Title => 'enter\nspent amount';

  @override
  String get welcome2Title => 'select date and time\nif transaction were\nmade earlier';

  @override
  String get welcome3Title => 'select\ntransaction\'s category';

  @override
  String get welcome4Title => 'create category\nif it isn\'t at list';

  @override
  String get welcome5Title => 'select your\ntransactions\' categories';

  @override
  String get welcome6Title => 'analyze your\neXpenses';

  @override
  String get continueIntro => 'continue introduction';

  @override
  String get itsMyCategories => 'this\'s my categories';

  @override
  String get startUsing => 'start using';

  @override
  String secondsTitle(Object numeric) {
    return '$numeric s';
  }

  @override
  String get appearanceTitle => 'appearance';

  @override
  String get systemThemeMode => 'system';

  @override
  String get darkThemeMode => 'dark';

  @override
  String get lightThemeMode => 'light';

  @override
  String get startCategories => '🏠 household,⛽️ gas,🛒 groceries,🛍 shopping,🍽 food & dinning,🚕 transport,💊 health,💪 fitness,🎓 education,🍿 entertainment,💸 bills,🐱 🐶 pet,🎁 gifts,❓ other';
}
