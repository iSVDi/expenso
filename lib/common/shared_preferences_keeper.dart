import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeeper {
  late SharedPreferences _sharedPreferences;

  SharedPreferences get getSharedPreferences => _sharedPreferences;

  Future<void> prepareProperty() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
