import 'package:expenso/modules/main/models/category.dart';

abstract class KeyboardState<T> {
  T data;
  KeyboardState({
    required this.data,
  });
}

//* KeyboardState<(AmountString, Transaction DateTime)>
class EnteringBasicDataState extends KeyboardState<(String, DateTime)> {
  EnteringBasicDataState({required super.data});
}

class SelectingCategoriesState extends KeyboardState<Category?> {
  SelectingCategoriesState({required super.data});
}