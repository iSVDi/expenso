import 'package:expenso/common/views/common_focused_menu_item.dart';
import 'package:expenso/common/views/rounded_button.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_states.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_cell.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  TransactionsCubit _getCubit(BuildContext context) {
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
    var cubit = _getCubit(context);
    var transactions = cubit.getTodayTransactions();
    var listView = ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (itemContext, index) =>
            _itemBuilder(context, transactions[index]));
    return Expanded(child: listView);
  }

  Widget _itemBuilder(BuildContext context, Transaction transaction) {
    var localization = AppLocalizations.of(context)!;
    var viewItem = CommonFocusedMenuItem(
        context: context,
        title: Text(localization.view),
        onPressed: () => _presentTransaction(context, transaction));

    var deleteItem = CommonFocusedMenuItem(
        context: context,
        title: Text(localization.delete),
        onPressed: () => _showAlert(context, transaction));

    var cell = TransactionCell(
        transaction: transaction,
        mode: TransactionCellMode.today,
        menuItems: [viewItem, deleteItem],
        onTap: () => _presentTransaction(context, transaction));
    return cell;
  }

  void _presentTransaction(BuildContext context, Transaction transaction) {
    var transactionView = TransactionView(transaction: transaction);
    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => transactionView)),
    );
  }

  void _showAlert(BuildContext context, Transaction transaction) {
    showDialog(
        context: context,
        builder: (buiderContext) {
          var theme = Theme.of(context);

          var title = RichText(
              text: TextSpan(
            text: AppLocalizations.of(context)!.areYouSureTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(
                text: transaction.category.target!.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: "?"),
            ],
          ));

          var cancelButton = RoundedButton.getCancelButton(
            context: context,
            onPressed: () => Navigator.of(context).pop(),
          );

          var deleteButton = RoundedButton.getActionButton(
            context: context,
            text: AppLocalizations.of(context)!.delete,
            onPressed: () {
              _getCubit(context).deleteTransaction(transaction);
              Navigator.of(context).pop();
            },
          );

          var row = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [cancelButton, deleteButton]);

          return AlertDialog(
            surfaceTintColor: theme.colorScheme.background,
            title: title,
            content: row,
          );
        });
  }
}
