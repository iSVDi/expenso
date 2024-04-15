import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
  //TODO localize
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textStyle = theme.textTheme.titleMedium
        ?.copyWith(color: theme.colorScheme.onBackground);
    var buttonsText = Text("добавить комментарий", style: textStyle);
    var button = TextButton(
      onPressed: () => prepareForClose(true),
      child: buttonsText,
    );

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [button, _getTimer(context)],
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

  Widget _getTimer(BuildContext context) {
    var theme = Theme.of(context);
    var textStyle = theme.textTheme.headlineSmall
        ?.copyWith(color: theme.colorScheme.primary);
    var timer = CircularCountDownTimer(
      duration: 4,
      width: 60,
      strokeWidth: 2,
      height: 60,
      fillColor: theme.colorScheme.primary,
      ringColor: theme.colorScheme.background,
      textStyle: textStyle,
      isReverse: true,
      isReverseAnimation: true,
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        return "${duration.inSeconds} c"; //TODO localize
      },
      onComplete: () {
        prepareForClose(false);
      },
    );

    return timer;
  }
}
