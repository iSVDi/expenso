import 'dart:async';

import "package:expenso/objectbox.g.dart";
import '../../../../main.dart';
import '../models/transaction.dart';

abstract class RepositoryObserver {
  void update();
}

abstract class RepositorySubject {
  List<RepositoryObserver> _observers = [];
  void registerObserver(RepositoryObserver observer);
  void removeObserver(RepositoryObserver observer);
  void _notifyObservers();
}

class TransactionRepository implements RepositorySubject {
  final Box<Transaction> _transactions = objectBoxStore.box<Transaction>();
  late StreamSubscription<Query<Transaction>> subscription;

  TransactionRepository() {
    subscription =
        _transactions.query().watch(triggerImmediately: true).listen((event) {
      _notifyObservers();
    });
  }

  void subscriptionListener(Query<Transaction> event) {
    _notifyObservers();
  }

  void insertTransaction(Transaction transaction) {
    var res = _transactions.put(transaction);
    print(res);
  }

  List<Transaction> readAllTransactions() {
    var query = _transactions
        .query()
        .order(Transaction_.id, flags: Order.descending)
        .build();
    var res = query.find();
    return res;
  }

  @override
  List<RepositoryObserver> _observers = [];

  @override
  void _notifyObservers() {
    for (var observer in _observers) {
      observer.update();
    }
  }

  @override
  void registerObserver(RepositoryObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(RepositoryObserver observer) {
    _observers.remove(observer);
  }
}
