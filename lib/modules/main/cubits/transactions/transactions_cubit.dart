import 'package:expenso/modules/main/cubits/transactions/transactions_states.dart';
import 'package:expenso/modules/main/dataLayer/repositories/transactions_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dataLayer/models/transaction.dart';

class TransactionsCubit extends Cubit<TransactionsState>
    implements RepositoryObserver {
  final _transactionRepository = TransactionRepository();

  TransactionsCubit()
      : super(TransactionsState(
            transactions: TransactionRepository().readTodayTransactions())) {
    _transactionRepository.registerObserver(this);
  }

  List<Transaction> getTodayTransactions() {
    return state.transactions;
  }

  @override
  void update() {
    var transactions = _transactionRepository.readTodayTransactions();
    emit(TransactionsState(transactions: transactions));
  }
}