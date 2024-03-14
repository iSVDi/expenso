import '../../dataLayer/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenso/extensions/appColors.dart';

class TransactionCell extends StatelessWidget {
  final Transaction transaction;

  const TransactionCell({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getCell();
  }

  Row _getCell() {
    var priceLabel = _getLabel(transaction.amount.toString(), Colors.black, 24);
    var transactionContainer = Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // TODO set another value for default category title
        _getLabel(transaction.category.target?.title ?? "", AppColors.appGreen, 18),
        _getLabel(transaction.comment, AppColors.appGreen, 12)
      ]),
    );
    return Row(children: [priceLabel, transactionContainer]);
  }

  Text _getLabel(String title, Color titleColor, double fontSize) {
    return Text(title, style: TextStyle(fontSize: fontSize, color: titleColor));
  }
}
