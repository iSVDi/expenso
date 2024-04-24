import 'package:expenso/common/app_preferences.dart';

class MyAppCubit {
  final appPreferences = AppPreferences();

  bool needPresentOnBoarding() => appPreferences.getIsFirstLaunch();
}
