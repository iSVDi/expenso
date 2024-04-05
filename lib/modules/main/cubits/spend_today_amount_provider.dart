import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';

//TODO! E/flutter (16686): #1      SpendTodayAmountProvider.update (package:expenso/modules/main/cubits/spend_today_amount_provider.dart:18:10)
class SpendTodayAmountProvider implements RepositoryObserver {
  final Function(String) _callback;
  final _repository = TransactionRepository();

  SpendTodayAmountProvider({required dynamic Function(String) callback})
      : _callback = callback {
    _repository.registerObserver(this);
  }

// TODO handle there aren't todays transaction
  @override
  void update() {
    var sum = _repository
        .readTodayTransactions()
        .map((transaction) => transaction.amount)
        .reduce((value, element) => value + element)
        .toString();
    _callback(sum);
  }
}
