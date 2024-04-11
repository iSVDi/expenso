import 'package:expenso/extensions/app_colors.dart';
import "package:flutter/material.dart";
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/select_categories_list/category_cell.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list_interactor.dart';
import 'package:expenso/common/views/done_button.dart';

class SelectCategoriesList extends StatefulWidget {
  final bool isManagingCategories;
  final Category selectedCategory;
  final Function(Category) doneButtonCallback;
  final Function() backButtonCallback;
  final Function(Category)? categoryUpdatedCallback;

  const SelectCategoriesList({
    Key? key,
    required this.isManagingCategories,
    required this.selectedCategory,
    required this.doneButtonCallback,
    required this.backButtonCallback,
    this.categoryUpdatedCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectCategoriesListState();
}

class SelectCategoriesListState extends State<SelectCategoriesList> {
  late final SelectCategoriesListInteractor _interactor =
      SelectCategoriesListInteractor(
          isManagingCategories: widget.isManagingCategories,
          selectedCategory: widget.selectedCategory,
          setState: () => setState(() {}));

  @override
  Widget build(BuildContext context) {
    var body = _getBody(context);
    return ColoredBox(color: AppColors.appNumericKeyboardColor, child: body);
  }

  Widget _getBody(BuildContext context) {
    var columnChildren = [
      _getHeader(context),
      const Divider(height: 1, color: AppColors.appBlack),
      _getCategoriesList(context)
    ];
    var column = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: columnChildren);
    var stackChildren = _interactor.isFromSettings
        ? [column]
        : [column, _getDoneButton(context)];
    var stack = Stack(
        alignment: AlignmentDirectional.bottomEnd, children: stackChildren);
    return stack;
  }

// TODO move text to special class
  Widget _getHeader(BuildContext context) {
    var textColor = AppColors.appGreen;
    var plustText = Text(
      "+",
      //TODO use textTheme
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
    var addCategoryText = Text(
      "Создать категорию",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: textColor,
      ),
    );
    var titlesRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          plustText,
          const SizedBox(width: 8, height: 0),
          addCategoryText
        ]);

    var addCategoryButton = TextButton(
      child: titlesRow,
      onPressed: () => _addCategoryButtonHandler(context),
    );

    var rowChildren = _interactor.isFromSettings
        ? [addCategoryButton]
        : [addCategoryButton, _getBackButton()];
    Row header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowChildren);
    EdgeInsets padding =
        const EdgeInsets.only(left: 32, right: 32, top: 14, bottom: 4);

    return Container(
      padding: padding,
      height: 74,
      child: header,
    );
  }

  IconButton _getBackButton() {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          // TODO use color scheme
          color: AppColors.appBlack,
        ),
        onPressed: widget.backButtonCallback);
  }

  Widget _getDoneButton(BuildContext context) {
    return DoneButton(
      onPressed: () => widget.doneButtonCallback(_interactor.selectedCategory),
    );
  }

  Widget _getCategoriesList(BuildContext context) {
    var categories = _interactor.readAllCategories;
    var listView = ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) => _getListCell(categories[index]));
    var container = Container(child: listView);
    return Expanded(child: container);
  }

  Widget _getListCell(Category category) {
    var isSelected = _interactor.isNeedSetBoldCategoryTitle(category);
    var cell = CategoryCell(isSelected: isSelected, category: category);
    var listTile = ListTile(
        contentPadding: const EdgeInsets.only(left: 32, right: 32),
        title: cell);

    var coloredListTile = ColoredBox(
      color:
          isSelected ? AppColors.appWhite : AppColors.appNumericKeyboardColor,
      child: listTile,
    );

    var editItem = FocusedMenuItem(
      title: const Text("Edit"),
      onPressed: () => _showEditCategorySheet(context, category),
    );

    var deleteItem = FocusedMenuItem(
      title: const Text("Delete"),
      onPressed: () => _interactor.deleteCategory(category: category),
    );

    var menuHolder = FocusedMenuHolder(
      menuOffset: 10,
      menuWidth: MediaQuery.of(context).size.width * 0.34,
      onPressed: () {
        if (_interactor.isFromSettings) {
          // TODO implement show pop up
          print("handler pop up");
        } else {
          _interactor.selectCategory(category);
        }
      },
      menuItems: [editItem, deleteItem],
      child: coloredListTile,
    );

    return menuHolder;
  }

  void _addCategoryButtonHandler(BuildContext context) {
    enterTextBottomSheet(BuildContext buildContext) {
      return EnterTextBottomSheet(
        //TODO get text from special class
        hintText: "Enter category name",
        bottomInsets: MediaQuery.of(buildContext).viewInsets.bottom,
        callback: (categoryName) => _interactor.addCategory(categoryName),
      );
    }

    _showSheet(
        context: context,
        builder: (builderContext) => enterTextBottomSheet(builderContext));
  }

  void _showEditCategorySheet(BuildContext context, Category category) {
    enterTextBottomSheet(BuildContext buildContext) {
      return EnterTextBottomSheet(
          // TODO move to special class
          text: category.title,
          hintText: "hintText",
          bottomInsets: MediaQuery.of(buildContext).viewInsets.bottom,
          callback: (String newCategoryName) {
            _interactor.editCategory(
              category: category,
              newCategoryName: newCategoryName,
              categoryUpdatedCallback: widget.categoryUpdatedCallback,
            );
          });
    }

    _showSheet(
        context: context,
        builder: (builderContext) => enterTextBottomSheet(builderContext));
  }

  Future _showSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) async {
    showModalBottomSheet(context: context, builder: builder);
  }
}
