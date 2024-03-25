import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/view_factory.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/modules/main/dataLayer/repositories/categories_repository.dart';

import "package:flutter/material.dart";

import "package:expenso/modules/main/dataLayer/models/category.dart";
import 'package:expenso/modules/main/views/cells/category_cell.dart';

class SelectCategoriesList extends StatefulWidget {
  Category? selectedCategory;
  final Function(Category?) doneButtonCallback;
  final Function() backButtonCallback;

  SelectCategoriesList({
    Key? key,
    this.selectedCategory,
    required this.doneButtonCallback,
    required this.backButtonCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectCategoriesListState();
}

class SelectCategoriesListState extends State<SelectCategoriesList> {
  final CategoriesRepository repository = CategoriesRepository();

  @override
  Widget build(BuildContext context) {
    return _getKeyboard(context);
  }

  Widget _getKeyboard(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        _getKeyboardHeader(context),
        const Divider(thickness: 1, color: AppColors.appBlack),
        _getCategoriesList(context)
      ]),
      ViewFactory.getDoneButton(context, () {
        widget.doneButtonCallback(widget.selectedCategory);
      })
    ]);
  }

// todo move text to special class
  Widget _getKeyboardHeader(BuildContext context) {
    var plustText = const Text("+",
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appGreen));
    var addCategoryText = const Text("Создать категорию",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: AppColors.appGreen));
    var titlesRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          plustText,
          const SizedBox(width: 8, height: 0),
          addCategoryText
        ]);

    var addCategoryButton = TextButton(
      child: titlesRow,
      onPressed: () {
        _addCategoryButtonHandler(context);
      },
    );

    var backButton = IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: AppColors.appBlack,
        ),
        onPressed: () {
          widget.backButtonCallback();
        });

    Row header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [addCategoryButton, backButton]);
    EdgeInsets padding =
        const EdgeInsets.only(left: 32, right: 32, top: 14, bottom: 4);

    return Container(
      padding: padding,
      height: 74,
      child: header,
    );
  }

  Widget _getCategoriesList(BuildContext context) {
    var categories = repository.readAllCategories();
    var listView = ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var needSetBold = _isNeedSetBoldCategoryTitle(categories[index]);
          var tile = ListTile(
            title: CategoryCell(
                needSetBold: needSetBold, category: categories[index]),
            onTap: () {
              _selectCategory(categories[index]);
            },
          );
          return tile;
        });
    var container = Container(
        padding: const EdgeInsets.only(left: 32, right: 32), child: listView);
    return Expanded(child: container);
  }

  void _addCategoryButtonHandler(BuildContext context) {
    var sheet = EnterTextBottomSheet(
      //todo get text from special class
      hintText: "Enter category name",
      callback: (categoryName) {
        var category = Category(title: categoryName);
        repository.insertCategory(category);
        _selectCategory(category);
      },
    );
    _showSheet(context, sheet);
  }

  bool _isNeedSetBoldCategoryTitle(Category category) {
    var currentState = widget.selectedCategory;
    if (currentState != null) {
      var res = category.id == currentState.id;
      return res;
    }
    return false;
  }

  void _selectCategory(Category category) {
    Category? currentCategory = widget.selectedCategory;
    Category? newCategory = category;
    bool areCategoriesSame =
        currentCategory != null && currentCategory.id == category.id;

    if (areCategoriesSame) {
      newCategory = null;
    }

    setState(() {
      widget.selectedCategory = newCategory;
    });
  }

  Future _showSheet(BuildContext context, Widget child) async {
    var container = Container(
        height: 100,
        margin: const EdgeInsets.only(left: 32, right: 32),
        child: child);
    showModalBottomSheet(context: context, builder: (context) => container);
  }
}
