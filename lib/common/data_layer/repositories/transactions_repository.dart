import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/main.dart';
import "package:expenso/objectbox.g.dart";
import 'package:flutter/material.dart';

abstract class RepositoryObserver {
  void update();
}

abstract class RepositorySubject {
  void registerObserver(RepositoryObserver observer);
  void removeObserver(RepositoryObserver observer);
}

class TransactionRepository implements RepositorySubject {
  final Box<Transaction> _transactions = objectBoxStore.box<Transaction>();
  final List<RepositoryObserver> _observers = [];

  TransactionRepository() {
    _transactions
        .query()
        .watch(triggerImmediately: true)
        .listen(observersNotifier);
  }

  //* Observer implementation
  void observersNotifier(Query<Transaction> event) {
    for (var observer in _observers) {
      observer.update();
    }
  }

  int insertTransaction(Transaction transaction) {
    return _transactions.put(transaction);
  }

  @override
  void registerObserver(RepositoryObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(RepositoryObserver observer) {
    _observers.remove(observer);
  }

//* Data queries
  // dateRange = 01/04/2024 - 02/04/2024
  // result = [02/04/2024 10:45, 02/04/2024 10:00, 01/04/2024 09:34, 01/04/2024 09:01]
  List<Transaction> readByDateRange({
    required DateTimeRange dateRange,
    required Set<Category> selectedCategories,
  }) {
    var query = _transactions
        .query(Transaction_.date.betweenDate(
          dateRange.start,
          dateRange.end.add(const Duration(days: 1)),
        ))
        .order(Transaction_.date, flags: Order.descending)
        .build();

    var res = query.find();
    if (selectedCategories.isNotEmpty) {
      res = res.where((element) {
        return selectedCategories.contains(element.category.target);
      }).toList();
    }
    return res;
  }

  List<Transaction> readTodayTransactions() {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var tommorrow = today.add(const Duration(days: 1));
    var query = _transactions
        .query(Transaction_.date.betweenDate(today, tommorrow))
        .order(Transaction_.id, flags: Order.descending)
        .build();
    var res = query.find();
    return res;
  }

  void updateLastTransactionsComment(String comment) {
    var id = _transactions.getAll().last.id;
    var transaction = _transactions.get(id);
    if (transaction != null) {
      transaction.comment = comment;
      _transactions.put(transaction);
    }
  }

  void deleteTransaction(Transaction transaction) {
    _transactions.remove(transaction.id);
  }

  void replaceCategories({required Category from, required Category to}) {
    var transactions = _transactions.query().build().find();
    var transactionsWithCategory = transactions
        .where((element) => element.category.target!.id == from.id)
        .toList();

    for (var element in transactionsWithCategory) {
      element.category.target = to;
    }

    _transactions.putMany(transactionsWithCategory);
  }
}
