import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/common/data_layer/repositories/storage_creator.dart';
import 'package:expenso/my_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objectbox.g.dart';

// TODO move to special classes
late Store objectBoxStore;
late SharedPreferences sharedPreferences;
Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  objectBoxStore = await StorageCreator.createStore();
  sharedPreferences = await SharedPreferences.getInstance();
  var cubit = BlocProvider(
    create: (context) => ThemeModeCubit(),
    child: const MyApp(),
  );
  runApp(cubit);
}
