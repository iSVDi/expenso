import 'package:expenso/common/views/rounded_button.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<T?> showDeleteAlert<T>({
  required BuildContext context,
  required String deletedItemName,
  required Function() onDeletePressed,
}) {
  return showDialog(
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
              text: deletedItemName,
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
            onDeletePressed();
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
