import 'package:expenso/modules/main/cubits/transactions/transactionsStates.dart';
import 'package:expenso/modules/main/dataLayer/repositories/transactionsRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dataLayer/models/transaction.dart';

class TransactionsCubit extends Cubit<TransactionsState>
    implements RepositoryObserver {
  TransactionsCubit()
      : super(TransactionsState(
            transactions: TransactionRepository().readAllTransactions())) {
    _transactionRepository.registerObserver(this);
  }
  final _transactionRepository = TransactionRepository();

  List<Transaction> getTransactions() {
    return state.transactions;
  }

  @override
  void update() {
    var transactions = _transactionRepository.readAllTransactions();
    emit(TransactionsState(transactions: transactions));
  }
}
