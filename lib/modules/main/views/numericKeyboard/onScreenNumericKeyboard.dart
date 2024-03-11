import 'package:expenso/modules/main/cubits/keyboard/keyboardStates.dart';
import 'package:expenso/modules/main/cubits/keyboard/keyboardCubit.dart';
import 'package:expenso/modules/main/models/category.dart';
import 'package:expenso/modules/main/views/cells/categoryCell.dart';
import 'package:expenso/modules/main/views/numericKeyboard/dateTimePicker.dart';
import 'package:expenso/modules/main/views/numericKeyboard/enterCategoryTextField.dart';
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

//TODO too big class. Need do less via add a few classes for create keyboard and header
//? maybe should create private property of context?
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
    var bloc =
        BlocBuilder<KeyboardCubit, KeyboardState>(builder: (context, state) {
      return SizedBox(
          height: size.height, width: size.width, child: _getKeyboard(context));
    });
    return bloc;
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
      var addCategoryButton = TextButton(
        child: const Text("+ add Category",
            style: TextStyle(color: Colors.black, fontSize: 18)),
        onPressed: () {
          _addCategoryButtonHandler(context);
        },
      );
      var backButton = IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            _getCubit(context).backCategoriesButtonHandler();
          });
      header = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [addCategoryButton, backButton]);
      padding = const EdgeInsets.only(left: 32, right: 32, top: 25, bottom: 25);
    }

    padding = const EdgeInsets.only(left: 32, right: 32);
    return Container(padding: padding, child: header);
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

  void _addCategoryButtonHandler(BuildContext mainContext) {
    var builder;
    showModalBottomSheet(
        context: mainContext,
        builder: ((context) {
          return _getEnterNewCategory(mainContext);
        }));
  }

  Widget _getEnterNewCategory(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.only(left: 32, right: 32),
        child: EnterCategoryTextField(
          callback: (categoryName) {
            _getCubit(context).addNewCategory(categoryName);
          },
        ));
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

// TODO divide on 2 or more func
  Widget _getNumericKeyboard(BuildContext context) {
    var cubit = _getCubit(context);
    if (cubit.state is SelectingCategoriesState) {
      return _getCategoriesList(context);
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

  Widget _getCategoriesList(BuildContext context) {
    var categories = _getCubit(context).getCategories();
    return FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var categories = snapshot.requireData;
            var listView = ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var needSetBold = _getCubit(context)
                      .isNeedSetBoldCategoryTitle(categories[index]);
                  var tile = ListTile(
                    title: CategoryCell(
                        needSetBold: needSetBold, category: categories[index]),
                    onTap: () {
                      _getCubit(context).selectCategory(categories[index]);
                    },
                  );
                  return tile;
                });
            var container = Container(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: listView);
            return Expanded(child: container);
          }
          //? need set another widget?
          return const Expanded(child: Text(""));
        });
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

  TextButton _getEmptyButton() {
    return const TextButton(onPressed: null, child: Text(""));
  }

  IconButton _getDeleteButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _buttonHandler(NumericKeyboardButtonType.delete, context);
        },
        icon: const Icon(Icons.arrow_back));
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

  Container _getDoneButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 5, bottom: 5),
        child: IconButton(
            onPressed: () {
              _getCubit(context).doneButtonHandler();
            },
            icon: const Icon(Icons.done),
            style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(88, 88)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.greenAccent[400]))));
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
