import 'package:expenso/common/views/date_time_picker.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import 'package:expenso/extensions/int.dart';
import 'package:expenso/extensions/string.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';

class TransactionView extends StatefulWidget {
  final Transaction transaction;

  const TransactionView({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionViewState();
}

ThemeData _getTheme(BuildContext context) => Theme.of(context);

class TransactionViewState extends State<TransactionView> {
  Transaction get transaction => widget.transaction;
  final _repository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getBody(context), appBar: _getAppBar(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(actions: [_getDeleteBarButton(context)]);
  }

  IconButton _getDeleteBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _repository.deleteTransaction(transaction);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.delete,
        ));
  }

  Widget _getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getDateButton(),
          _getCategoryButton(AppLocalizations.of(context)!),
          _getCommentButton(),
          _getAmountButton()
        ],
      ),
    );
  }

  Widget _getDateButton() {
    var colorScheme = _getTheme(context).colorScheme;
    var textStyle = _getTheme(context).textTheme.headlineSmall;
    var title = Text(
      "${transaction.date.formattedDate}, ${transaction.date.formattedTime}",
      style: textStyle?.copyWith(color: colorScheme.onBackground),
    );
    var dateTimePicker = DateTimePicker(
      selectedDate: transaction.date,
      callback: (date) {
        _updateDate(date);
        Navigator.of(context).pop();
      },
    );
    var textButton = TextButton(
      child: title,
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => dateTimePicker);
      },
    );
    return textButton;
  }

  Widget _getCategoryButton(AppLocalizations localization) {
    var title = transaction.category.target!.title;
    if (title.isEmpty) {
      title = localization.noCategory;
    }
    var textStyle = _getTheme(context).textTheme.displaySmall;
    var text = Text(title, style: textStyle);

    selectCategoriesList(BuildContext builderContext) {
      return SelectCategoriesList(
        isManagingCategories: false,
        selectedCategory: transaction.category.target!,
        doneButtonCallback: (category) {
          _updateCategory(category);
          Navigator.pop(builderContext);
        },
        backButtonCallback: () {
          Navigator.pop(builderContext);
        },
        categoryUpdatedCallback: (category) {
          _updateCategory(category);
        },
      );
    }

    var textButton = _getPresentModallyButton(
      child: text,
      builder: (context) => selectCategoriesList(context),
    );
    return textButton;
  }

  Widget _getCommentButton() {
    var comment = transaction.comment.isEmpty
        ? AppLocalizations.of(context)!.addComment
        : transaction.comment;
    var textStyle = _getTheme(context).textTheme.titleMedium;
    var text = Text(comment, style: textStyle);
    enterTextBottomSheet(BuildContext builderContext) {
      return EnterTextBottomSheet(
          hintText: AppLocalizations.of(context)!.addComment,
          bottomInsets: MediaQuery.of(context).viewInsets.bottom,
          callback: (comment) => _updateComment(comment));
    }

    var textButton = _getPresentModallyButton(
      child: text,
      builder: (context) => enterTextBottomSheet(context),
    );
    return textButton;
  }

  Widget _getAmountButton() {
    keyboard(BuildContext buildContext) {
      return SizedNumericKeyboard.sizedKeyboard(
        context: context,
        amount: transaction.amount.toStringAmount,
        doneButtonCallback: (amountString, dateTime) {
          setState(() {
            _updateAmount(amountString);
            Navigator.pop(buildContext);
          });
        },
      );
    }

    var textStyle = _getTheme(context).textTheme.displayMedium;
    var text = Text(transaction.amount.toStringAmount, style: textStyle);

    var textButton = _getPresentModallyButton(
      child: text,
      builder: (context) => keyboard(context),
    );
    return textButton;
  }

  void _updateDate(DateTime? date) {
    if (date != null) {
      setState(() {
        transaction.date = date;
        _repository.insertTransaction(transaction);
      });
    }
  }

  void _updateComment(String comment) {
    setState(() {
      transaction.comment = comment;
      _repository.insertTransaction(transaction);
    });
  }

  void _updateAmount(String amountString) {
    setState(() {
      transaction.amount = amountString.toIntAmount();
      _repository.insertTransaction(transaction);
    });
  }

  void _updateCategory(Category category) {
    setState(() {
      transaction.category.target = category;
      _repository.insertTransaction(transaction);
    });
  }

  TextButton _getPresentModallyButton({
    required Widget child,
    required Widget Function(BuildContext) builder,
  }) {
    var textButton = TextButton(
        child: child,
        onPressed: () =>
            showModalBottomSheet(context: context, builder: builder));
    return textButton;
  }
}
