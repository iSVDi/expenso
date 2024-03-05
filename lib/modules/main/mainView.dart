import "package:expenso/modules/main/models/transaction.dart";
import "package:expenso/modules/main/views/cells/transactionCell.dart";
import "package:expenso/modules/settings/settingsView.dart";
import "package:flutter/material.dart";
import 'package:expenso/modules/main/views/numericKeyboard/onScreenNumericKeyboard.dart';
import "package:expenso/extensions/appImages.dart";

class MainView extends StatelessWidget {
  final _MainViewConstants constants = _MainViewConstants();

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
    var listView = ListView(
        children: Transaction.getStampList()
            .map((data) => TransactionCell(transaction: data))
            .toList());
    var container = Container(
        child: listView, padding: EdgeInsets.only(left: 32, right: 32));
    return Expanded(child: container);
  }

  OnScreenNumericKeyboard _getKeyboard(BuildContext context) {
    var height = MediaQuery.of(context).size.height *
        _MainViewConstants.keyboardHeightRatio;
    var width = MediaQuery.of(context).size.width;
    return OnScreenNumericKeyboard(
      size: Size(width, height),
    );
  }
}

class _MainViewConstants {
  static var keyboardHeightRatio = 0.43;
}
