import "package:expenso/modules/main/cubits/transactions/transactionsCubit.dart";
import 'package:expenso/modules/main/views/transactionsList/transactionsList.dart';
import "package:expenso/modules/settings/settingsView.dart";
import "package:flutter/material.dart";
import 'package:expenso/modules/main/views/numericKeyboard/onScreenNumericKeyboard.dart';
import "package:expenso/extensions/appImages.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../cubits/keyboard/keyboardCubit.dart";

class MainView extends StatelessWidget {
  final constants = _MainViewConstants();

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(context), body: _getBody(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(
        //TODO: move text to special class
        title: Text("Main Title"),
        actions: [
          _getAnalyseBarButton(context),
          _getSettingsBarButton(context)
        ]);
  }

  IconButton _getAnalyseBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => SettingsView())));
        },
        icon: AppImages.barChartIcon.assetsImage);
  }

  IconButton _getSettingsBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => SettingsView())));
        },
        icon: AppImages.settingsIcon.assetsImage);
  }

  Widget _getBody(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [_getTransactionListView(), _getKeyboard(context)]);
  }

  Widget _getTransactionListView() {
    // TODO implement list
    var listView = const TransactionsList();
    var bloc = BlocProvider(
      create: (context) => TransactionsCubit(),
      child: listView,
    );

    return bloc;
  }

  Widget _getKeyboard(BuildContext context) {
    var height = MediaQuery.of(context).size.height *
        _MainViewConstants.keyboardHeightRatio;
    var width = MediaQuery.of(context).size.width;
    var bloc = BlocProvider(
        create: (context) => KeyboardCubit(),
        child: OnScreenNumericKeyboard(
          size: Size(width, height),
        ));
    return bloc;
  }
}

class _MainViewConstants {
  static var keyboardHeightRatio = 0.43;
}
