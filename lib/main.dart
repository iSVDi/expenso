import 'package:expenso/modules/main/dataLayer/repositories/storageCreator.dart';
import 'package:expenso/modules/main/views/mainView.dart';
import 'package:flutter/material.dart';
import 'objectbox.g.dart';

late Store objectBoxStore;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  objectBoxStore = await StorageCreator.createStore();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
      routes: {"/home": (context) => MainView()},
    );
  }
}
