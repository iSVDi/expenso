import "package:expenso/common/constants.dart";
import 'package:expenso/modules/history/cubit/history_cubit.dart';
import 'package:expenso/modules/history/views/history_list.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/views/transactions_list/transactions_list.dart';
import 'package:expenso/modules/settings/settings_view.dart';
import "package:flutter/material.dart";
import 'package:expenso/modules/main/views/enter_transaction_data/enter_transaction_data.dart';
import 'package:expenso/extensions/app_images.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import '../cubits/keyboard/keyboard_cubit.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(context), body: _getBody(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(
        //TODO: set sum of amounts
        title: const Text("Main Title"),
        actions: [
          _getAnalyseBarButton(context),
          _getSettingsBarButton(context)
        ]);
  }

  IconButton _getAnalyseBarButton(BuildContext context) {
    var bloc = BlocProvider(
      create: (context) => HistoryCubit(),
      child: HistoryList(),
    );
    var button = IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => bloc)));
      },
      icon: AppImages.barChartIcon.assetsImage,
    );
    return button;
  }

  IconButton _getSettingsBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SettingsView())));
        },
        icon: AppImages.settingsIcon.assetsImage);
  }

  Widget _getBody(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [_getTransactionListView(), _getKeyboard(context)]);
  }

  Widget _getTransactionListView() {
    var listView = const TransactionsList();
    var bloc = BlocProvider(
      create: (context) => TransactionsCubit(),
      child: listView,
    );

    return bloc;
  }

  Widget _getKeyboard(BuildContext context) {
    var height =
        Constants.sizeFrom(context).height * Constants.keyboardHeightRatio;
    var width = Constants.sizeFrom(context).width;
    var bloc = BlocProvider(
        create: (context) => KeyboardCubit(),
        child: EnterTransactionData(
          size: Size(width, height),
        ));
    return bloc;
  }
}
