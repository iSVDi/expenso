import 'package:expenso/extensions/date_time.dart';

import '../../../../common/data_layer/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenso/extensions/app_colors.dart';

enum TransactionCellMode { today, analyze }

class TransactionCell extends StatelessWidget {
  final Transaction transaction;
  final TransactionCellMode mode;
  const TransactionCell(
      {Key? key, required this.transaction, required this.mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getCell();
  }

  Row _getCell() {
    var title = mode == TransactionCellMode.today
        ? transaction.stringAmount
        : transaction.date.formattedTime;
    var leftWidget = _getLabel(title, Colors.black, 24, FontWeight.w300);
    var column = _getTransactionsColumn();
    var crossAxisAlignment = transaction.comment.isEmpty
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    var children = [leftWidget, const SizedBox(width: 20, height: 0), column];
    if (mode == TransactionCellMode.analyze) {
      children.add(Spacer(
        flex: 1,
      ));
      children.add(Text(transaction.stringAmount));
    }
    var row = Row(crossAxisAlignment: crossAxisAlignment, children: children);
    return row;
  }

  Text _getLabel(
      String title, Color titleColor, double fontSize, FontWeight fontWeight) {
    return Text(title,
        style: TextStyle(
            fontSize: fontSize, color: titleColor, fontWeight: fontWeight));
  }

// todo get text from special class
  Widget _getTransactionsColumn() {
    var categoryText = _getLabel(
        transaction.category.target?.title ?? "no category",
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
