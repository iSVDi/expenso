import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:flutter/material.dart';

class RequestCommentSheet extends StatefulWidget {
  final Function(bool) callback;

  const RequestCommentSheet({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => RequestCommentSheetState();
}

class RequestCommentSheetState extends State<RequestCommentSheet> {
  @override
  // TODO get text from class
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.appBlack,
    );
    var buttonsText = Text("добавить комментарий", style: textStyle);
    var button = TextButton(
      onPressed: () => prepareForClose(true),
      child: buttonsText,
    );

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [button, _getTimer()],
    );
    var height = MediaQuery.of(context).size.height * 0.123;
    var sizedBox = SizedBox(
      height: height,
      child: row,
    );
    return sizedBox;
  }

  void prepareForClose(bool needEnterComment) {
    Navigator.pop(context);
    widget.callback(needEnterComment);
  }

  Widget _getTimer() {
    var timer = CircularCountDownTimer(
      duration: 4,
      width: 60,
      strokeWidth: 2,
      height: 60,
      fillColor: AppColors.appTimerTextColor,
      ringColor: AppColors.appNumericKeyboardColor,
      textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w300,
          color: AppColors.appTimerTextColor),
      isReverse: true,
      isReverseAnimation: true,
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        return "${duration.inSeconds} c"; // TODO get text from special class
      },
      onComplete: () {
        prepareForClose(false);
      },
    );

    return timer;
  }
}
