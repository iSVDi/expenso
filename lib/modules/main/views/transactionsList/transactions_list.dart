import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_states.dart';
import 'package:expenso/modules/main/dataLayer/models/transaction.dart';
import 'package:expenso/modules/main/dataLayer/repositories/categories_repository.dart';
import 'package:expenso/modules/main/views/cells/transaction_cell.dart';
import 'package:expenso/modules/main/views/transactionsList/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  TransactionsCubit getCubit(BuildContext context) {
    return context.read<TransactionsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
      return _getBody(context);
    });
    return bloc;
  }

  Widget _getBody(BuildContext context) {
    var cubit = getCubit(context);
    var transactions = cubit.getTodayTransactions();
    var listView = ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var cell = TransactionCell(transaction: transactions[index]);
          var tile = ListTile(
            title: cell,
            onTap: () {
              _presentTransaction(context, transactions[index]);
            },
          );
          return tile;
        });
    var container =
        Container(padding: const EdgeInsets.only(left: 32), child: listView);
    return Expanded(child: container);
  }

  void _presentTransaction(BuildContext context, Transaction transaction) {
    var transactionView = TransactionView(transaction: transaction);
    var repositoryProvider = RepositoryProvider(
        create: (context) => CategoriesRepository(), child: transactionView);
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => repositoryProvider)));
  }
}
