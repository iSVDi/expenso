import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/views/common_focused_menu_item.dart';
import 'package:expenso/common/views/done_button.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/select_categories_list/category_cell.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list_interactor.dart';
import 'package:expenso/common/views/show_common_modal_bottom_sheet.dart';
import 'package:expenso/common/views/show_delete_alert.dart';
import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import "package:flutter/material.dart";
import 'package:focused_menu/focused_menu.dart';

class SelectCategoriesList extends StatefulWidget {
  final bool isManagingCategories;
  final Category? selectedCategory;
  final Function(Category?) doneButtonCallback;
  final Function() backButtonCallback;
  final Function(Category?)? categoryUpdatedCallback;

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

  Color _getBackgroundColor(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var keyboardColor = Theme.of(context).colorScheme.surfaceVariant;
    var backgroundColor =
        widget.isManagingCategories ? colorScheme.background : keyboardColor;
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = _getBackgroundColor(context);
    var body = _getBody(context);
    return ColoredBox(color: backgroundColor, child: body);
  }

  Widget _getBody(BuildContext context) {
    var additionalColors = Theme.of(context).extension<AdditionalColors>()!;
    var dividerColor = widget.isManagingCategories
        ? additionalColors.history
        : additionalColors.keyboard;
    var columnChildren = [
      _getHeader(context),
      Divider(height: 1, color: dividerColor),
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

  Widget _getHeader(BuildContext context) {
    var textColor = Theme.of(context).colorScheme.primary;
    var plusIcon = Icon(
      Icons.add,
      color: textColor,
    );
    var addCategoryText = Text(
      AppLocalizations.of(context)!.createCategory,
      style: Theme.of(context).textTheme.titleMedium,
    );
    var titlesRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          plusIcon,
          const SizedBox(width: 8, height: 0),
          addCategoryText
        ]);

    var addCategoryButton = TextButton(
      child: titlesRow,
      onPressed: () => _addCategoryButtonHandler(context),
    );

    var rowChildren = _interactor.isFromSettings
        ? [addCategoryButton]
        : [addCategoryButton, _getBackButton(context)];
    Row header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowChildren);
    EdgeInsets padding =
        const EdgeInsets.only(left: 20, right: 32, top: 14, bottom: 4);

    return Container(
      padding: padding,
      height: MediaQuery.of(context).size.height * 0.1,
      child: header,
    );
  }

  IconButton _getBackButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: Theme.of(context).colorScheme.onBackground,
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
      color: isSelected
          ? Theme.of(context).colorScheme.background
          : _getBackgroundColor(context),
      child: listTile,
    );

    var localization = AppLocalizations.of(context)!;
    var editItem = CommonFocusedMenuItem(
        context: context,
        title: Text(localization.edit),
        onPressed: () => _showEditCategorySheet(context, category));

    var deleteItem = CommonFocusedMenuItem(
      context: context,
      title: Text(localization.delete),
      onPressed: () {
        showDeleteAlert(
          context: context,
          deletedItemName: category.title,
          onDeletePressed: () => _interactor.deleteCategory(category: category),
        );
      },
    );

    var menuHolder = FocusedMenuHolder(
      menuOffset: 10,
      menuWidth: MediaQuery.of(context).size.width * 0.34,
      onPressed: () {
        if (!_interactor.isFromSettings) {
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
        hintText: AppLocalizations.of(context)!.enterCategoryName,
        bottomInsets: MediaQuery.of(buildContext).viewInsets.bottom,
        callback: (categoryName) => _interactor.addCategory(categoryName),
      );
    }

    showCommonModalBottomSheet(
        context: context,
        builder: (builderContext) => enterTextBottomSheet(builderContext));
  }

  void _showEditCategorySheet(BuildContext context, Category category) {
    enterTextBottomSheet(BuildContext buildContext) {
      return EnterTextBottomSheet(
          text: category.title,
          hintText: AppLocalizations.of(context)!.enterCategoryName,
          bottomInsets: MediaQuery.of(buildContext).viewInsets.bottom,
          callback: (String newCategoryName) {
            _interactor.editCategory(
              category: category,
              newCategoryName: newCategoryName,
              categoryUpdatedCallback: widget.categoryUpdatedCallback,
            );
          });
    }

    showCommonModalBottomSheet(
        context: context,
        builder: (builderContext) => enterTextBottomSheet(builderContext));
  }
}
