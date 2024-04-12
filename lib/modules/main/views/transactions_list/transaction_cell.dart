import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/extensions/date_time.dart';
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
      color: Theme.of(context).colorScheme.background,
      child: listTile,
    );

    var menuHolder = FocusedMenuHolder(
      menuOffset: 10,
      menuWidth: MediaQuery.of(context).size.width * 0.34,
      onPressed: onTap,
      menuItems: menuItems,
      child: coloredListTile,
    );
    return SizedBox(height: 56, child: menuHolder);
  }

  Widget _getCell(BuildContext context) {
    var title = mode == TransactionCellMode.today
        ? transaction.stringAmount
        : transaction.date.formattedTime;

    var textStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontWeight: FontWeight.w300);
    var leftWidget = Text(title, style: textStyle);
    var column = _getTransactionsColumn(context);

    var children = [leftWidget, const SizedBox(width: 20, height: 0), column];

    if (mode == TransactionCellMode.history) {
      children.add(const Spacer(flex: 1));
      children.add(Text(
        transaction.stringAmount,
        style: textStyle,
      ));
    }

    var crossAxisAlignment = transaction.comment.isEmpty
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    var row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    return row;
  }

// TODO get text from special class
  Widget _getTransactionsColumn(BuildContext context) {
    var categoryStyle = Theme.of(context).textTheme.titleMedium;
    var categoryText =
        Text(transaction.category.target!.title, style: categoryStyle);

    if (transaction.comment.isNotEmpty) {
      var commentStyle = Theme.of(context).textTheme.labelMedium;
      var commentText = Text(transaction.comment, style: commentStyle);
      var column = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [categoryText, commentText]);
      return column;
    }
    return categoryText;
  }
}
