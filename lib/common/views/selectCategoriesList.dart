// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/views/enterTextBottomSheet.dart';
import 'package:expenso/common/views/viewFactory.dart';
import "package:expenso/extensions/appColors.dart";

import "package:flutter/material.dart";

import "package:expenso/modules/main/dataLayer/models/category.dart";
import "package:expenso/modules/main/views/cells/categoryCell.dart";

class SelectCategoriesList extends StatefulWidget {
  List<Category> categories;
  Category? selectedCategory;
  Function(Category?) doneButtonCallback;
  Function(String) addCategoryCallback;
  Function() backButtonCallback;

  SelectCategoriesList({
    Key? key,
    required this.categories,
    this.selectedCategory,
    required this.doneButtonCallback,
    required this.addCategoryCallback,
    required this.backButtonCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectCategoriesListState();
}

class SelectCategoriesListState extends State<SelectCategoriesList> {
  @override
  Widget build(BuildContext context) {
    return _getKeyboard(context);
  }

  Widget _getKeyboard(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        _getKeyboardHeader(context),
        Divider(thickness: 2, color: AppColors.appBlack),
        _getCategoriesList(context)
      ]),
      ViewFactory.getDoneButton(context, () {
        widget.doneButtonCallback(widget.selectedCategory);
      })
    ]);
  }

  Widget _getKeyboardHeader(BuildContext context) {
    var addCategoryButton = TextButton(
      // todo move to special class
      child: Text("+ add Category",
          style: TextStyle(color: AppColors.appBlack, fontSize: 18)),
      onPressed: () {
        _addCategoryButtonHandler(context);
        // widget.addCategoryCallback();
      },
    );
    var backButton = IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          // _getCubit(context).backCategoriesButtonHandler();
          widget.backButtonCallback();
        });
    Row header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [addCategoryButton, backButton]);
    EdgeInsets padding =
        const EdgeInsets.only(left: 32, right: 32, top: 25, bottom: 25);

    return Container(padding: padding, child: header);
  }

  Widget _getCategoriesList(BuildContext context) {
    var categories = widget.categories;
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
        // _getCubit(context).addNewCategory(categoryName);
        setState(() {
          widget.addCategoryCallback(categoryName);
        });
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
