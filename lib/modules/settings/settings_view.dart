import "package:expenso/common/data_layer/models/category.dart";
import "package:expenso/common/views/select_categories_list/select_categories_list.dart";
import "package:flutter/material.dart";

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(actions: const []),
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
