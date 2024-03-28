import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/modules/history/cubit/history_cubit.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';

class HistoryList extends StatelessWidget {
  HistoryCubit _getCubit(BuildContext context) => context.read<HistoryCubit>();

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(actions: []),
      body: _getList(context),
    );

    var bloc = BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) => scaffold);
    return bloc;
  }

  Widget _getList(BuildContext context) {
    var sectionsData = _getCubit(context).getHistoryListData();
    return GroupListView(
        sectionsCount: sectionsData.length,
        countOfItemInSection: (sectionID) =>
            sectionsData[sectionID].transactions.length,
        itemBuilder: (context, index) {
          var transaction =
              sectionsData[index.section].transactions[index.index];
          var item = _itemBuilder(transaction);
          return item;
        },
        groupHeaderBuilder: (context, sectionID) {
          var sectionDate = sectionsData[sectionID];
          var header = _groupHeaderBuilder(
            sectionDate.headerDate,
            sectionDate.sum,
          );
          return header;
        });
  }

  Widget _itemBuilder(Transaction transaction) {
    var cell = TransactionCell(
      transaction: transaction,
      mode: TransactionCellMode.analyze,
    );
    var listTile = ListTile(
        title: cell,
        onTap: () {
          // todo handle tap
          print(transaction.comment);
        });
    return listTile;
  }

  Widget _groupHeaderBuilder(String title, String sum) {
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(sum.toString()),
      ],
    );
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: row,
    );
    var coloredBox = ColoredBox(
      color: Colors.greenAccent[100]!,
      child: padding,
    );
    return coloredBox;
  }
}
