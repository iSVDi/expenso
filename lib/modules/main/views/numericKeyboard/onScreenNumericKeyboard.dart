import 'package:expenso/modules/main/cubits/keyboard/keyboardStates.dart';
import 'package:expenso/modules/main/cubits/keyboard/keyboardCubit.dart';
import 'package:expenso/modules/main/models/category.dart';
import 'package:expenso/modules/main/views/cells/categoryCell.dart';
import 'package:expenso/modules/main/views/numericKeyboard/dateTimePicker.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';
import "numericButton.dart";
import 'package:expenso/extensions/dateTime.dart';

enum NumericKeyboardButtonType {
  point("."),
  zero("0"),
  one("1"),
  two("2"),
  three("3"),
  four("4"),
  five("5"),
  six("6"),
  seven("7"),
  eight("8"),
  nine("9"),
  empty(""),
  delete("x");

  final String value;
  const NumericKeyboardButtonType(this.value);
}

class OnScreenNumericKeyboard extends StatelessWidget {
  final Size size;
  List<Category> categories = Category.getStampList();

  OnScreenNumericKeyboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  KeyboardCubit _getCubit(BuildContext context) {
    return context.read<KeyboardCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyboardCubit, KeyboardState>(builder: (context, state) {
      return SizedBox(
          height: size.height, width: size.width, child: _getKeyboard(context));
    });
  }

  Widget _getKeyboard(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        _getKeyboardHeader(context),
        const Divider(
          thickness: 2,
          color: Colors.black,
        ),
        _getNumericKeyboard(context)
      ]),
      _getDoneButton(context)
    ]);
  }

  Future _handleNewDateTime(BuildContext context) async {
    KeyboardCubit cubit = _getCubit(context);
    showDialog(
        context: context,
        builder: (BuildContext context) => DateTimePicker(
              selectedDate: cubit.getDate,
              callback: (date) {
                if (date != null) {
                  cubit.updateDate(date);
                }
                Navigator.pop(context);
              },
            ));
  }

  Widget _getKeyboardHeader(BuildContext context) {
    Row header;
    EdgeInsets padding;
    var cubit = _getCubit(context);

    if (cubit.state is EnteringBasicDataState) {
      DateTime date = cubit.getDate;
      var datePickerButton = TextButton(
          onPressed: () {
            _handleNewDateTime(context);
          },
          child: Text("${date.formattedDate}\n${date.formattedTime}",
              //TODO set color via appColors class
              style: TextStyle(color: Colors.greenAccent[400], fontSize: 18)));

      header = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [datePickerButton, _getAmountLabel(cubit.getAmount)]);
    } else {
      var button = IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            _getCubit(context).backCategoriesButtonHandler();
          });
      header =
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text("+ add category",
            style: TextStyle(color: Colors.black, fontSize: 18)),
        IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              _getCubit(context).backCategoriesButtonHandler();
            })
      ]);
      padding = const EdgeInsets.only(left: 32, right: 32, top: 25, bottom: 25);
    }

    padding = const EdgeInsets.only(left: 32, right: 32);
    return Container(padding: padding, child: header);
  }

  Widget _getNumericKeyboard(BuildContext context) {
    var cubit = _getCubit(context);
    if (cubit.state is SelectingCategoriesState) {
      var listView = ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: CategoryCell(category: categories[index]),
              onTap: () {
                print(index);
              },
            );
          });
      var container = Container(
          padding: const EdgeInsets.only(left: 32, right: 32), child: listView);
      return Expanded(child: container);
    } else {
      var numerics =
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        _getNumericButtonRows([
          NumericKeyboardButtonType.seven,
          NumericKeyboardButtonType.eight,
          NumericKeyboardButtonType.nine,
          NumericKeyboardButtonType.delete
        ], context),
        _getNumericButtonRows([
          NumericKeyboardButtonType.four,
          NumericKeyboardButtonType.five,
          NumericKeyboardButtonType.six,
          NumericKeyboardButtonType.empty
        ], context),
        _getNumericButtonRows([
          NumericKeyboardButtonType.one,
          NumericKeyboardButtonType.two,
          NumericKeyboardButtonType.three,
          NumericKeyboardButtonType.empty
        ], context),
        _getNumericButtonRows([
          NumericKeyboardButtonType.empty,
          NumericKeyboardButtonType.zero,
          NumericKeyboardButtonType.point,
          NumericKeyboardButtonType.empty,
        ], context)
      ]);
      return numerics;
    }
  }

  Row _getNumericButtonRows(
      List<NumericKeyboardButtonType> titles, BuildContext context) {
    var buttons = titles.map((type) {
      switch (type) {
        case NumericKeyboardButtonType.empty:
          return Expanded(child: _getEmptyButton());
        case NumericKeyboardButtonType.delete:
          return Expanded(child: _getDeleteButton(context));
        default:
          return Expanded(child: _getNumericButton(type, context));
      }
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: buttons,
    );
  }

  Widget _getNumericButton(
      NumericKeyboardButtonType type, BuildContext context) {
    var button = NumericButton(
        title: type.value,
        callback: () {
          _buttonHandler(type, context);
        });
    return button;
  }

  IconButton _getDeleteButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _buttonHandler(NumericKeyboardButtonType.delete, context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  Container _getDoneButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 5, bottom: 5),
        child: IconButton(
            onPressed: () {
              _getCubit(context).saveAmount();
            },
            icon: const Icon(Icons.done),
            style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(88, 88)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.greenAccent[400]))));
  }

  TextButton _getEmptyButton() {
    return const TextButton(onPressed: null, child: Text(""));
  }

  void _buttonHandler(NumericKeyboardButtonType type, BuildContext context) {
    _getCubit(context).updateAmount(type);
  }

  Text _getAmountLabel(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 50),
    );
  }
}
