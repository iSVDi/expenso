import 'package:expenso/modules/main/dataLayer/repository.dart';
import 'package:expenso/modules/main/mainView.dart';
import 'package:flutter/material.dart';

late Repository objectBox;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await Repository.create();
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
