import 'package:expenso/modules/main/dataLayer/models/transaction.dart';


//? does state must keep transactions?
class TransactionsState {
  List<Transaction> transactions;
  TransactionsState({
    required this.transactions,
  });
}
