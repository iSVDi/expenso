// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/rounded_button.dart';
import 'package:expenso/modules/main/views/main_view.dart';
import 'package:expenso/modules/welcome/welcome_cubit.dart';
import 'package:flutter/material.dart';

import 'package:expenso/theme/theme_provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

// TODO? move code for creating categories' list in separate file
class _WelcomeState extends State<Welcome> {
  final _cubit = WelcomeCubit();
  final _pageController = PageController();
  final _createCategorySlideId = 4;
  final _lastSlideId = 5;
  var _currentSlideId = 0;

  @override
  Widget build(BuildContext context) {
    var models = _cubit.getSlideModels(Theme.of(context).brightness);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(actions: const []),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getPageView(context, models),
          _getPageIndicator(context, models.length),
          const SizedBox(height: 30),
          _getButton(context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _getPageView(BuildContext context, List<SlideModel> models) {
    var pageView = PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: models.length,
      onPageChanged: (value) {
        setState(() {
          _currentSlideId = value;
        });
      },
      itemBuilder: ((context, index) => _itemBuilder(context, models[index])),
    );

    return Expanded(child: pageView);
  }

  Widget _itemBuilder(BuildContext context, SlideModel model) {
    var theme = Theme.of(context);
    var numberStyle = theme.textTheme.displayLarge
        ?.copyWith(color: theme.colorScheme.primary);
    var titleStyle =
        theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w300);

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${model.number}", style: numberStyle),
        const SizedBox(width: 12),
        Text(model.title, style: titleStyle),
      ],
    );
    var height = MediaQuery.of(context).size.height * 0.191;
    var sizedHeader = SizedBox(height: height, child: header);

    Widget body;
    if (model.number == _createCategorySlideId + 1) {
      body = _getSelectCategoriiesSlide(context);
    } else {
      body = model.image!;
    }

    return Column(children: [sizedHeader, body]);
  }

  Widget _getSelectCategoriiesSlide(BuildContext context) {
    var categories = _cubit.getCategories;
    var header = _getSelectingCategoriesHeader(context);

    var divider = Divider(
      height: 1,
      color: Theme.of(context).dividerTheme.color,
    );
    var list = ListView.builder(
      itemCount: categories.length,
      itemBuilder: (buildContext, id) {
        var titleStyle = Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground);

        var checkBoxColor = Theme.of(context).colorScheme.onBackground;
        var listTile = ListTile(
          leading: Checkbox(
              fillColor: const MaterialStatePropertyAll(Colors.transparent),
              checkColor: checkBoxColor,
              side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(color: checkBoxColor)),
              value: categories[id].isSelected,
              onChanged: (value) {
                _cubit.selectCategory(id);
                setState(() {});
              }),
          title: Text(
            categories[id].name,
            style: categories[id].isSelected
                ? titleStyle.copyWith(fontWeight: FontWeight.w500)
                : titleStyle,
          ),
          onTap: () {
            _cubit.selectCategory(id);
            setState(() {});
          },
        );

        return SizedBox(height: 48, child: listTile);
      },
    );

    var listHeght = MediaQuery.of(context).size.height * 0.415;
    var column = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        header,
        divider,
        SizedBox(
          height: listHeght,
          child: list,
        ),
        // Expanded(child: Container(child: list)),
      ],
    );

    return column;
  }

  Widget _getSelectingCategoriesHeader(BuildContext context) {
    Widget header;
    if (!_cubit.getIsInteringNewCategory) {
      var textColor = Theme.of(context).colorScheme.primary;
      var plusIcon = Icon(
        Icons.add,
        color: textColor,
      );
      var addCategoryText = Text(
        "Создать категорию", // todo localize
        style: Theme.of(context).textTheme.titleMedium,
      );
      var titlesRow =
          Row(children: [plusIcon, const SizedBox(width: 8), addCategoryText]);

      var addCategoryButton = TextButton(
          child: titlesRow,
          onPressed: () {
            _cubit.createCategoryHandler();
            setState(() {});
          });

      var padding = Padding(
        padding: const EdgeInsets.only(left: 20),
        child: addCategoryButton,
      );
      header = padding;
    } else {
      header = EnterTextBottomSheet(
        hintText: "category name", //TODO localize
        bottomInsets: 0,
        isPresentedModally: false,
        callback: (categoryName) {
          //TODO implement
          _cubit.saveNewCategory(categoryName);
          setState(() {});
        },
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.0911,
      width: double.maxFinite,
      child: header,
    );
  }

  Widget _getPageIndicator(BuildContext context, int itemsCount) {
    var theme = Theme.of(context);
    var children = List.generate(itemsCount, (index) {
      var dotColor = index == _currentSlideId
          ? theme.colorScheme.primary
          : theme.extension<AdditionalColors>()!.dotInactiveColor;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: dotColor,
        ),
      );
    });

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
    return row;
  }

  Widget _getButton(BuildContext context) {
    return RoundedButton.getActionButton(
        context: context,
        text: _cubit.getButtonTitle(_currentSlideId),
        onPressed: () {
          if (_currentSlideId == _lastSlideId) {
            _cubit.lastSlidePresentedHander();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const MainView()),
              ),
            );
          } else {
            _pageController.animateToPage(
              _currentSlideId + 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          }
        });
  }
}
