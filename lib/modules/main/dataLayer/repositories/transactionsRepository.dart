import "package:expenso/objectbox.g.dart";
import '../../../../main.dart';
import '../models/transaction.dart';
import 'storageCreator.dart';

class TransactionRepository {
  final Box<Transaction> _transactions = objectBoxStore.box<Transaction>();

  void insertTransaction(Transaction transaction) {
    _transactions.put(transaction);
  }
}
