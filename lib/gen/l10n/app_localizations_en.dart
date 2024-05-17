import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noCategory => 'No category';

  @override
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get enterCategoryName => 'Enter category name';

  @override
  String get expensesAnalysis => 'expenses';

  @override
  String get historyPlugTitle => 'Start making expenses and statistics by category will appear here';

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
  String get categoryName => 'Category name';

  @override
  String get createCategory => 'Create category';

  @override
  String get myCategories => 'My categories';

  @override
  String get welcome1Title => 'Enter\nspent amount';

  @override
  String get welcome2Title => 'Select date and time\nif transaction were\nmade earlier';

  @override
  String get welcome3Title => 'Select\ntransaction\'s category';

  @override
  String get welcome4Title => 'Create category\nif it isn\'t at list';

  @override
  String get welcome5Title => 'Select your\ntransactions\' categories';

  @override
  String get welcome6Title => 'Analyze your\neXpenses';

  @override
  String get continueIntro => 'Continue introduction';

  @override
  String get itsMyCategories => 'This\'s my categories';

  @override
  String get startUsing => 'Start using';

  @override
  String secondsTitle(Object numeric) {
    return '$numeric s';
  }

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get systemThemeMode => 'System';

  @override
  String get darkThemeMode => 'Dark';

  @override
  String get lightThemeMode => 'Light';

  @override
  String get startCategories => '🏠 household,⛽️ gas,🛒 groceries,🛍 shopping,🍽 food & dinning,🚕 transport,💊 health,💪 fitness,🎓 education,🍿 entertainment,💸 bills,🐱 🐶 pet,🎁 gifts,❓ other';

  @override
  String get reminderTitle => 'Reminde me at ';

  @override
  String get notificationTitle => 'eXpenso';

  @override
  String get notificationBody => 'Don\'t forget to enter your today expenses!';

  @override
  String get settings => 'Settings';
}
