import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import "package:expenso/objectbox.g.dart";

import 'models/category.dart';
import 'models/transaction.dart';

class Repository {
  late final Store _store;
  late Box<Category> _userBox;
  late Box<Transaction> _transactionBox;

  Repository._create(this._store) {
    _userBox = _store.box<Category>();
    _transactionBox = _store.box<Transaction>();
  }

  static Future<Repository> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "dataBase"));
    return Repository._create(store);
  }

  void insertCategory(Category category) {
    _userBox.put(category);
  }

  List<Category> readAllCategories() {
    var query =
        _userBox.query().order(Category_.id, flags: Order.descending).build();
    var res = query.find();
    return res;
  }

  void insertTransaction(Transaction transaction) {
    _transactionBox.put(transaction);
  }
}
