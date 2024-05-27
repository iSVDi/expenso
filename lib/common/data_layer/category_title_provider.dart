import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryTitleProvider {
  static getTitle(BuildContext context, Category? category) {
    if (category == null) {
      return AppLocalizations.of(context)!.noCategory;
    }
    return category.title;
  }
}
