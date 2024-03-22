// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:expenso/extensions/appColors.dart';
import 'package:flutter/material.dart';

class CommentSheet extends StatefulWidget {
  final Function(bool, BuildContext) callback;

  const CommentSheet({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => CommentSheetState();
}

class CommentSheetState extends State<CommentSheet> {
  late Timer _timer;
  int _timerValue = 3;
  bool isTimerWorking = true;

  @override
  // todo get text from class
  Widget build(BuildContext context) {
    _startTimer(context);
    var buttonsText = Text("добавить комментарий",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.appBlack));
    var button = TextButton(
        onPressed: () {
          prepareForClose(true);
        },
        child: buttonsText);

    return Row(children: [button, _getTimer()]);
  }

  Widget _getTimer() {
    return Text("${_timerValue}c");
  }

  // todo! callback execute a few times for the same tick. Need fix
  void _startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_timerValue == 0 && isTimerWorking) {
        prepareForClose(false);
      } else {
        if (isTimerWorking) {
          setState(() {
            _timerValue--;
          });
        }
      }
    });
  }

  void prepareForClose(bool needEnterComment) {
    isTimerWorking = false;
    _timer.cancel();
    widget.callback(needEnterComment, context);
  }
}