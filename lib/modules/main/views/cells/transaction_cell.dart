import '../../dataLayer/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenso/extensions/app_colors.dart';

class TransactionCell extends StatelessWidget {
  final Transaction transaction;

  const TransactionCell({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getCell();
  }

  Row _getCell() {
    var priceLabel =
        _getLabel(transaction.stringAmount, Colors.black, 24, FontWeight.w300);
    var column = _getTransactionsColumn();
    var crossAxisAlignment = transaction.comment.isEmpty
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    return Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [priceLabel, const SizedBox(width: 20, height: 0), column]);
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
