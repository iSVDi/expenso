import 'package:expenso/notifications/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expenso/common/object_box_store_keeper.dart';
import 'package:expenso/common/shared_preferences_keeper.dart';
import 'package:expenso/my_app/my_app.dart';
import 'package:expenso/theme/cubit/theme_mode_cubit.dart';

final objectBoxStoreKeeper = ObjectBoxStoreKeeper();
final sharedPreferencesKeeper = SharedPreferencesKeeper();
final notificationService = NotificationsService();

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  await objectBoxStoreKeeper.prepareProperty();
  await sharedPreferencesKeeper.prepareProperty();
  await notificationService.initialize();

  runApp(
    BlocProvider(
      create: (context) => ThemeModeCubit(),
      child: const MyApp(),
    ),
  );
}
