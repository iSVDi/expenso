import 'package:expenso/common/constants.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/my_app.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

enum TransactionCellMode { today, history }

class TransactionCell extends StatelessWidget {
  final Transaction transaction;
  final TransactionCellMode mode;
  final List<FocusedMenuItem> menuItems;
  final Function() onTap;

  const TransactionCell(
      {Key? key,
      required this.transaction,
      required this.mode,
      required this.menuItems,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  Widget _getBody(BuildContext context) {
    var cell = _getCell(context);
    var listTile = ListTile(
      title: cell,
      contentPadding: const EdgeInsets.symmetric(horizontal: 32),
    );

    var coloredListTile = ColoredBox(
      color: Colors.white,
      child: listTile,
    );

    var menuHolder = FocusedMenuHolder(
      menuOffset: 10,
      menuWidth: Constants.sizeFrom(context).width * 0.34,
      onPressed: onTap,
      menuItems: menuItems,
      child: coloredListTile,
    );
    return menuHolder;
  }

  Widget _getCell(BuildContext context) {
    var title = mode == TransactionCellMode.today
        ? transaction.stringAmount
        : transaction.date.formattedTime;

    var leftWidget = Text(title, style: Theme.of(context).textTheme.appTitle3);
    var column = _getTransactionsColumn(context);

    var children = [leftWidget, const SizedBox(width: 20, height: 0), column];

    if (mode == TransactionCellMode.history) {
      children.add(const Spacer(flex: 1));
      children.add(Text(transaction.stringAmount));
    }

    var crossAxisAlignment = transaction.comment.isEmpty
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    var row = Row(
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
    return row;
  }

// todo get text from special class
  Widget _getTransactionsColumn(BuildContext context) {
    var categoryStyle = Theme.of(context).textTheme.appBody;
    var categoryText =
        Text(transaction.category.target!.title, style: categoryStyle);

    if (transaction.comment.isNotEmpty) {
      var commentStyle = Theme.of(context).textTheme.appSubhead;
      var commentText = Text(transaction.comment, style: commentStyle);
      var column = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [categoryText, commentText]);
      return column;
    }
    return categoryText;
  }
}
