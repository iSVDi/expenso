import 'package:expenso/gen/objectbox/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';



abstract class StorageCreator {
  static Future<Store> createStore() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "dataBase"));
    return store;
  }
}
