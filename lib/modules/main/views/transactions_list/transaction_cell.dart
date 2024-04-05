import 'package:expenso/common/constants.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:flutter/material.dart';
import 'package:expenso/extensions/app_colors.dart';
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
    var cell = _getCell();
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

  Widget _getCell() {
    var title = mode == TransactionCellMode.today
        ? transaction.stringAmount
        : transaction.date.formattedTime;
    var leftWidget = _getLabel(title, Colors.black, 24, FontWeight.w300);
    var column = _getTransactionsColumn();

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

  Text _getLabel(
    String title,
    Color titleColor,
    double fontSize,
    FontWeight fontWeight,
  ) {
    var style = TextStyle(
      fontSize: fontSize,
      color: titleColor,
      fontWeight: fontWeight,
    );
    return Text(title, style: style);
  }

// todo get text from special class
  Widget _getTransactionsColumn() {
    var categoryText = _getLabel(
        transaction.category.target!.title,
        AppColors.appGreen,
        18,
        FontWeight.w400);

    if (transaction.comment.isNotEmpty) {
      var commentText = _getLabel(
          transaction.comment, AppColors.appGreen, 12, FontWeight.w300);
      var column = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [categoryText, commentText]);
      return column;
    }
    return categoryText;
  }
}
