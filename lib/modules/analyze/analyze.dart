import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_cell.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

class StampBuilder {
  static List<List<Transaction>> getStamp() {
    List<Transaction> stamp = [];

    for (var i = 1; i < 10; i++) {
      var val = Transaction(
          date: DateTime.now(), comment: "comment $i", amount: i.toDouble());
      stamp.add(val);
    }

    var date = DateTime.now().add(const Duration(days: 1));
    for (var i = 10; i < 20; i++) {
      var val =
          Transaction(date: date, comment: "comment $i", amount: i.toDouble());
      stamp.add(val);
    }

    return [stamp, stamp];
  }
}

class Analyze extends StatelessWidget {
  final sectionsStamp = StampBuilder.getStamp();

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(actions: []),
      body: _getList(),
    );
    return scaffold;
  }

  Widget _getList() {
    return GroupListView(
      sectionsCount: sectionsStamp.length,
      countOfItemInSection: (sectionID) => sectionsStamp[sectionID].length,
      itemBuilder: _itemBuilder,
      groupHeaderBuilder: _groupHeaderBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    var element = sectionsStamp[index.section][index.index];
    var cell = TransactionCell(
      transaction: element,
      mode: TransactionCellMode.analyze,
    );
    var listTile = ListTile(
        title: cell,
        onTap: () {
          // todo handle tap
          print(element.comment);
        });
    return listTile;
  }

  Widget _groupHeaderBuilder(BuildContext context, int sectionID) {
    var title = sectionsStamp[sectionID].first.date.formattedDate;
    var sum = sectionsStamp[sectionID]
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
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
    return padding;
  }
}
