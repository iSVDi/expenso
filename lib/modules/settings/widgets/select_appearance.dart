import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAppearance extends StatelessWidget {
  const SelectAppearance({super.key});

  ThemeModeCubit _getCubit(BuildContext context) {
    return context.read<ThemeModeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (builderContext, state) {
      return getList(context);
    });
    return bloc;
  }

  Widget getList(BuildContext context) {
    var cubit = _getCubit(context);

    var themeModes = cubit.getThemeModes(AppLocalizations.of(context)!);
    var itemExtent =
        MediaQuery.of(context).size.height * _SelectAppearanceRatios.itemExtent;
    0.04;

    var selectedId = themeModes
        .indexWhere((element) => element.mode == cubit.state.themeMode);
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    var controller = FixedExtentScrollController(initialItem: selectedId);
    var list = ListWheelScrollView(
        controller: controller,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (id) {
          cubit.setNewThemeMode(themeModes[id].mode);
        },
        itemExtent: itemExtent,
        children: themeModes.map((mode) {
          var text = Text(mode.title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium!
                  .copyWith(color: colorScheme.onBackground));

          var color = mode.mode == cubit.state.themeMode
              ? colorScheme.primary
              : colorScheme.background;
          var width = MediaQuery.of(context).size.width *
              _SelectAppearanceRatios.containerWidth;
          var height = MediaQuery.of(context).size.height *
              _SelectAppearanceRatios.containerHeight;

          var containter = Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                )),
            // color: color,
            width: width,
            height: height,
            child: text,
          );

          var gestureDetector = GestureDetector(
            onTapUp: (_) {
              var id = themeModes.indexOf(mode);
              cubit.setNewThemeMode(themeModes[id].mode);
              controller.animateToItem(id,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceIn);
            },
            child: containter,
          );
          return gestureDetector;
        }).toList());

    var height =
        MediaQuery.of(context).size.height * _SelectAppearanceRatios.listHeight;
    var sizedBox = SizedBox(
      height: height,
      child: list,
    );
    return sizedBox;
  }
}

class _SelectAppearanceRatios {
  static var itemExtent = 0.04;
  static var containerWidth = 0.9;
  static var containerHeight = 0.01;
  static var listHeight = 0.2;
}
