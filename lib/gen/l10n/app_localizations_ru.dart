import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get noCategory => 'Нет категории';

  @override
  String get apply => 'Принять';

  @override
  String get cancel => 'Отмена';

  @override
  String get enterCategoryName => 'Введите название категории';

  @override
  String get expensesAnalysis => 'Анализ трат';

  @override
  String get historyPlugTitle => 'Начните вносить расходы и здесь появится статистика по категориям';

  @override
  String get view => 'Просмотр';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Изменить';

  @override
  String get addComment => 'Добавить комментарий';

  @override
  String get spentToday => 'Траты за сегодня';

  @override
  String get enterComment => 'Введите комментарий';

  @override
  String get areYouSureTitle => 'Вы уверены, что хотите удалить ';

  @override
  String get categoryName => 'Название категории';

  @override
  String get createCategory => 'Создать категорию';

  @override
  String get myCategories => 'Мои категории';

  @override
  String get welcome1Title => 'Введите\nпотраченную сумму';

  @override
  String get welcome2Title => 'Выберите дату и время,\nесли транзакция была\nсовершена ранее';

  @override
  String get welcome3Title => 'Выберите\nкатегорию расходов';

  @override
  String get welcome4Title => 'Создайте категорию,\nесли её нет в списке';

  @override
  String get welcome5Title => 'Выберите свои\nкатегории расходов';

  @override
  String get welcome6Title => 'Анализируйте свои\nрасходы';

  @override
  String get continueIntro => 'Продолжить знакомство';

  @override
  String get itsMyCategories => 'Это мои категории';

  @override
  String get startUsing => 'Начать пользоваться';

  @override
  String secondsTitle(Object numeric) {
    return '$numeric с';
  }

  @override
  String get appearanceTitle => 'Оформление';

  @override
  String get systemThemeMode => 'Системное';

  @override
  String get darkThemeMode => 'Темное';

  @override
  String get lightThemeMode => 'Светлое';

  @override
  String get startCategories => '🏠 дом,⛽️ бензин,🛒 продукты,🛍 шоппинг,🍽 обеды,🚕 транспорт,💊 здоровье,💪 финес,🎓 образование,🍿 развлечения,💸 налоги,🐱 🐶 питомцы,🎁 подарки,❓ остальное';

  @override
  String get reminderTitle => 'Напоминать в ';

  @override
  String get notificationTitle => 'eXpenso';

  @override
  String get notificationBody => 'Не забудьте внести свои траты за сегодня!';

  @override
  String get settings => 'Настройки';
}
