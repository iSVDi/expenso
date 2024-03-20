import 'package:expenso/modules/main/cubits/transactions/transactionsCubit.dart';
import 'package:expenso/modules/main/cubits/transactions/transactionsStates.dart';
import 'package:expenso/modules/main/dataLayer/models/transaction.dart';
import 'package:expenso/modules/main/views/cells/transactionCell.dart';
import 'package:expenso/modules/main/views/transactionsList/transactionView.dart';
import 'package:flutter/cupertino.dart';
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
    var transactions = cubit.getTransactions();
    var listView = ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var cell = TransactionCell(transaction: transactions[index]);
          var tile = ListTile(
            title: cell,
            onTap: () {
              // todo implement opening view with selected category
              _presentTransaction(context, transactions[index]);
              // print(
              // "transaction ${transactions[index].category.target?.title} tapped");
            },
          );
          return tile;
        });
    var container =
        Container(padding: const EdgeInsets.only(left: 32), child: listView);
    return Expanded(child: container);
  }

  void _presentTransaction(BuildContext context, Transaction transaction) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => TransactionView(transaction: transaction))));
  }
}
