import 'package:expenso/common/data_layer/models/transaction.dart';


//? does state must keep transactions?
class TransactionsState {
  List<Transaction> transactions;
  TransactionsState({
    required this.transactions,
  });
}
