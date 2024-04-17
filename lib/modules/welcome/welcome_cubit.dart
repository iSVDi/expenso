// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/categories_repository.dart';
import 'package:expenso/theme/cubit/app_preferences.dart';
import 'package:flutter/material.dart';

class SlideModel {
  final int number;
  final String title;
  final Image? image;

  SlideModel({
    required this.number,
    required this.title,
    required this.image,
  });
}

class SelectableCategory {
  final String name;
  bool isSelected;

  SelectableCategory({required this.name, this.isSelected = false});
}

class WelcomeCubit {
  final categoryRepository = CategoriesRepository();
  var _isEnteringNewCategory = false;
  // ignore: prefer_final_fields
  var _categories = [
    SelectableCategory(name: "🏠 household"),
    SelectableCategory(name: "⛽️ gas"),
    SelectableCategory(name: "🛒 groceries"),
    SelectableCategory(name: "🛍 shopping"),
    SelectableCategory(name: "🍽 food & dinning"),
    SelectableCategory(name: "🚕 transport"),
    SelectableCategory(name: "💊 health"),
    SelectableCategory(name: "💪 fitness"),
    SelectableCategory(name: "🎓 education"),
    SelectableCategory(name: "🍿 entertainment"),
    SelectableCategory(name: "💸 bills"),
    SelectableCategory(name: "🐱 🐶 pet"),
    SelectableCategory(name: "🎁 gifts"),
    SelectableCategory(name: "❓ other"),
  ];

  List<SlideModel> getSlideModels(Brightness brightness) {
    //TODO localize
    var titles = [
      "введите\nпотраченную сумму",
      "выберите дату и время,\nесли транзакция была\nсовершена ранее",
      "выберите\nкатегорию расходов",
      "создайте категорию,\nесли её нет в списке",
      "выберите свои\nкатегории расходов",
      "анализируйте свои\nрасходы",
    ];
    var res = titles.map((e) {
      var id = titles.indexOf(e) + 1;
      var image = _getImage(id, brightness);
      return SlideModel(
        number: id,
        title: e,
        image: image,
      );
    }).toList();
    return res;
  }

  List<SelectableCategory> get getCategories => _categories;
  bool get getIsInteringNewCategory => _isEnteringNewCategory;

  void createCategoryHandler() {
    _isEnteringNewCategory = true;
  }

  void selectCategory(int id) {
    _categories[id].isSelected = !_categories[id].isSelected;
  }

  void saveNewCategory(String name) {
    var element = SelectableCategory(name: name, isSelected: true);
    _categories.insert(0, element);
  }

  String getButtonTitle(int id) {
    var isSelectedCategory =
        _categories.indexWhere((element) => element.isSelected == true) != -1;
    if (id == 4 && isSelectedCategory) {
      return "это мои категории";
    } else if (id == 5) {
      return "начать пользоваться";
    }
    return "продолжить знакомство";
  }

  void lastSlidePresentedHander() {
    var selectedCategoriesIterable =
        _categories.where((element) => element.isSelected == true);
    if (selectedCategoriesIterable.isNotEmpty) {
      var newCategories = selectedCategoriesIterable
          .map((e) => Category(title: e.name))
          .toList();
      categoryRepository.insertCategories(newCategories);
    }

    AppPreferences().setIsNotFirstLaunch();
  }

//* ids must starts from 1
  Image? _getImage(int id, Brightness brightness) {
    if (id == 5) {
      return null;
    }

    String imageName;
    if (brightness == Brightness.light) {
      imageName = "welcome$id.png";
    } else {
      imageName = "welcomeDark$id.png";
    }

    return Image.asset("assets/welcome/$imageName");
  }
}
