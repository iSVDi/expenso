import "package:expenso/common/constants.dart";
import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/views/transactionsList/transactions_list.dart';
import 'package:expenso/modules/settings/settings_view.dart';
import "package:flutter/material.dart";
import 'package:expenso/modules/main/views/keyboard/on_screen_keyboard.dart';
import 'package:expenso/extensions/app_images.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import '../cubits/keyboard/keyboard_cubit.dart';

class MainView extends StatelessWidget {
  final constants = Constants();

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(context), body: _getBody(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(
        //TODO: move text to special class
        title: const Text("Main Title"),
        actions: [
          _getAnalyseBarButton(context),
          _getSettingsBarButton(context)
        ]);
  }

  IconButton _getAnalyseBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SettingsView())));
        },
        icon: AppImages.barChartIcon.assetsImage);
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
    // TODO implement list
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
        child: OnScreenKeyboard(
          size: Size(width, height),
        ));
    return bloc;
  }
}
