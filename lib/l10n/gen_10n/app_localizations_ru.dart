import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get noCategory => 'нет категории';

  @override
  String get apply => 'Принять';

  @override
  String get cancel => 'Отмена';

  @override
  String get enterCategoryName => 'Введите название категории';

  @override
  String get expensesAnalysis => 'анализ трат';

  @override
  String get historyPlugTitle => 'начните вносить расходы и здесь появится статистика по категориям';

  @override
  String get view => 'просмотр';

  @override
  String get delete => 'удалить';

  @override
  String get edit => 'редактировать';

  @override
  String get addComment => 'добавить комментарий';

  @override
  String get spentToday => 'траты за сегодня';

  @override
  String get enterComment => 'введите комментарий';

  @override
  String get areYouSureTitle => 'Вы уверены, что хотите удалить ';

  @override
  String get categoryName => 'Название категории';

  @override
  String get createCategory => 'Создать категорию';

  @override
  String get myCategories => 'Мои категории';

  @override
  String get welcome1Title => 'введите\nпотраченную сумму';

  @override
  String get welcome2Title => 'выберите дату и время,\nесли транзакция была\nсовершена ранее';

  @override
  String get welcome3Title => 'выберите\nкатегорию расходов';

  @override
  String get welcome4Title => 'создайте категорию,\nесли её нет в списке';

  @override
  String get welcome5Title => 'выберите свои\nкатегории расходов';

  @override
  String get welcome6Title => 'анализируйте свои\nрасходы';

  @override
  String get continueIntro => 'продолжить знакомство';

  @override
  String get itsMyCategories => 'Это мои категории';

  @override
  String get startUsing => 'начать пользоваться';

  @override
  String secondsTitle(Object numeric) {
    return '$numeric с';
  }

  @override
  String get appearanceTitle => 'оформление';

  @override
  String get systemThemeMode => 'системное';

  @override
  String get darkThemeMode => 'темное';

  @override
  String get lightThemeMode => 'светлое';

  @override
  String get startCategories => '🏠 дом,⛽️ бензин,🛒 продукты,🛍 шоппинг,🍽 обеды,🚕 транспорт,💊 здоровье,💪 финес,🎓 образование,🍿 развлечения,💸 налоги,🐱 🐶 питомцы,🎁 подарки,❓ остальное';

  @override
  String get spendInAWeek => 'потрачено за неделю';

  @override
  String get spendInAMonth => 'потрачено за месяц';
}
