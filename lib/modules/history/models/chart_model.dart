import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/select_category_model.dart';

class ChartModel {
  double sum;
  ChartType chartType;
  List<SelectCategoryModel> chartCategories;
  List<SelectCategoryModel> selectableCategories;
  Function()? backTimeFrameButtonHandler;
  Function()? forwardTimeFrameButtonHandler;

  ChartModel(
      {required this.sum,
      required this.chartType,
      required this.chartCategories,
      required this.selectableCategories,
      this.backTimeFrameButtonHandler,
      this.forwardTimeFrameButtonHandler});
}
