import 'package:expenso/common/data_layer/category_title_provider.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/common/views/common_focused_menu_item.dart';
import 'package:expenso/common/views/show_delete_alert.dart';
import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_states.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_cell.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    var deletedItemName =
        CategoryTitleProvider.getTitle(context, transaction.category.target);
    var deleteItem = CommonFocusedMenuItem(
      context: context,
      title: Text(localization.delete),
      onPressed: () {
        showDeleteAlert(
          context: context,
          deletedItemName: deletedItemName,
          onDeletePressed: () =>
              _getCubit(context).deleteTransaction(transaction),
        );
      },
    );

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
}
