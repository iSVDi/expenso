import 'package:expenso/common/data_layer/repositories/storage_creator.dart';
import 'package:expenso/objectbox.g.dart';

class ObjectBoxStoreKeeper {
  late Store _objectBoxStore;

  Store get getObjectBoxStore => _objectBoxStore;

  Future<void> prepareProperty() async {
    _objectBoxStore = await StorageCreator.createStore();
  }
}

