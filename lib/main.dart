import 'package:expenso/common/data_layer/repositories/storage_creator.dart';
import 'package:expenso/my_app.dart';
import 'package:flutter/material.dart';
import 'objectbox.g.dart';

// TODO move to special class
late Store objectBoxStore;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  objectBoxStore = await StorageCreator.createStore();
  runApp(const MyApp());
}
