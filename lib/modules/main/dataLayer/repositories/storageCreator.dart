import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import "package:expenso/objectbox.g.dart";

//? need use singleton?
abstract class StorageCreator {
  static Future<Store> createStore() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "dataBase"));
    return store;
  }
}
