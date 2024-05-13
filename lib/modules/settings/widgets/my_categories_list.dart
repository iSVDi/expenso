import "package:expenso/common/data_layer/models/category.dart";
import "package:expenso/common/views/select_categories_list/select_categories_list.dart";
import "package:expenso/l10n/gen_10n/app_localizations.dart";
import "package:flutter/material.dart";

class MyCategoriesList extends StatelessWidget {
  const MyCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var scaffold = Scaffold(
      appBar: AppBar(
        actions: const [],
        title: Text(localizations.myCategories),
      ),
      body: _getBody(),
    );
    return scaffold;
  }

  Widget _getBody() {
    return SelectCategoriesList(
      isManagingCategories: true,
      selectedCategory: Category.emptyCategory(),
      doneButtonCallback: (category) {},
      backButtonCallback: () {},
    );
  }
}
