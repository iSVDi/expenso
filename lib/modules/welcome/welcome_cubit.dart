// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/material.dart';

import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/categories_repository.dart';

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
  List<SelectableCategory> _categories = [];

  // ignore: prefer_final_fields

  void prepareCategories(AppLocalizations localization) {
    _categories = localization.startCategories
        .split(",")
        .map((e) => SelectableCategory(name: e))
        .toList();
  }

  List<SlideModel> getSlideModels(
      AppLocalizations localization, Brightness brightness) {
    var titles = [
      localization.welcome1Title,
      localization.welcome2Title,
      localization.welcome3Title,
      localization.welcome4Title,
      localization.welcome5Title,
      localization.welcome6Title,
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

  String getButtonTitle(BuildContext context, int id) {
    var localization = AppLocalizations.of(context)!;
    var isSelectedCategory =
        _categories.indexWhere((element) => element.isSelected == true) != -1;
    if (id == 4 && isSelectedCategory) {
      return localization.itsMyCategories;
    } else if (id == 5) {
      return localization.startUsing;
    }
    return localization.continueIntro;
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
