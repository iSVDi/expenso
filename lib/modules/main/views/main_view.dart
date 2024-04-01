import 'package:expenso/modules/main/cubits/keyboard/keyboard_cubit.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:expenso/common/constants.dart";
import 'package:expenso/extensions/app_images.dart';
import 'package:expenso/modules/history/cubit/history_cubit.dart';
import 'package:expenso/modules/history/views/history_list.dart';
import 'package:expenso/modules/main/cubits/spend_today_amount_provider.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/views/enter_transaction_data/enter_transaction_data.dart';
import 'package:expenso/modules/main/views/transactions_list/transactions_list.dart';
import 'package:expenso/modules/settings/settings_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String sum = "";
  late SpendTodayAmountProvider cubit;

  _MainViewState() {
    cubit = SpendTodayAmountProvider(callback: (String amountString) {
      setState(() {
        sum = amountString;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(context), body: _getBody(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sum),
        const Text("spent today"),
      ],
    );
    return AppBar(
      title: column,
      actions: [
        _getAnalyseBarButton(context),
        _getSettingsBarButton(context),
      ],
    );
  }

  IconButton _getAnalyseBarButton(BuildContext context) {
    var bloc = BlocProvider(
      create: (context) => HistoryCubit(),
      child: const HistoryList(),
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
