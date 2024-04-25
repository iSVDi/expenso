import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/select_category_model.dart';

class ChartModel {
  int sum;
  ChartType chartType;
  List<SelectCategoryModel> chartCategories;
  List<SelectCategoryModel> selectedCategories;
  List<SelectCategoryModel> notSelectedCategories;
  Function()? backTimeFrameButtonHandler;
  Function()? forwardTimeFrameButtonHandler;

  ChartModel(
      {required this.sum,
      required this.chartType,
      required this.chartCategories,
      required this.selectedCategories,
      required this.notSelectedCategories,
      this.backTimeFrameButtonHandler,
      this.forwardTimeFrameButtonHandler});
}
