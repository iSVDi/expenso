import 'package:expenso/modules/main/cubits/transactions/transactionsCubit.dart';
import 'package:expenso/modules/main/views/cells/transactionCell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  TransactionsCubit getCubit(BuildContext context) {
    return context.read<TransactionsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
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
              print(
                  "transaction ${transactions[index].category.target?.title} tapped");
            },
          );
          return tile;
        });
    var container =
        Container(padding: const EdgeInsets.only(left: 32), child: listView);
    return Expanded(child: container);
  }
}
