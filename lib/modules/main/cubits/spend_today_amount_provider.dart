import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';

class SpendTodayAmountProvider implements RepositoryObserver {
  final Function(String) _callback;
  final _repository = TransactionRepository();

  SpendTodayAmountProvider({required dynamic Function(String) callback})
      : _callback = callback {
    _repository.registerObserver(this);
  }

  @override
  void update() {
    var transactions = _repository.readTodayTransactions();
    if (transactions.isEmpty) {
      _callback(NumericKeyboardButtonType.zero.value);
    } else {
      var sum = transactions
          .map((transaction) => transaction.amount)
          .reduce((value, element) => value + element)
          .toString();
      _callback(sum);
    }
  }
}
