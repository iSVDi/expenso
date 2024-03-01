// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:expenso/modules/main/views/onScreenNumericKeyboard.dart';
import "package:expenso/extensions/appImages.dart";

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _getAppBar(),
        bottomSheet: _getBottomSheet(context),
        body: Center(
          child: Text('Hello World!'),
          // child: ,
        ),
      ),
    );
  }

  PreferredSizeWidget _getAppBar() {
    return AppBar(
        //TODO: move text to special class
        title: Text("Main Title"),
        actions: [
          //TODO: implement handlers
          IconButton(
              onPressed: () {}, icon: AppImages.barChartIcon.assetsImage),
          IconButton(onPressed: () {}, icon: AppImages.settingsIcon.assetsImage)
        ]);
  }

  OnScreenNumericKeyboard _getBottomSheet(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.479;
    var width = MediaQuery.of(context).size.width;
    return OnScreenNumericKeyboard(
      size: Size(width, height),
    );
  }
}
