import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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
    var itemExtent = MediaQuery.of(context).size.height * 0.04;

    var selectedId =
        themeModes.indexWhere((element) => element.$2 == cubit.state.themeMode);
    var colorScheme = Theme.of(context).colorScheme;
    var list = ListWheelScrollView(
        controller: FixedExtentScrollController(initialItem: selectedId),
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (id) {
          cubit.setNewThemeMode(themeModes[id].$2);
        },
        itemExtent: itemExtent,
        children: themeModes.map((mode) {
          var text = Text(mode.$1, textAlign: TextAlign.center);

          var color = mode.$2 == cubit.state.themeMode
              ? colorScheme.primary
              : colorScheme.background;
          var width = MediaQuery.of(context).size.width * 0.9;

          return Container(
            color: color,
            width: width,
            height: MediaQuery.of(context).size.height * 0.01,
            child: text,
          );
        }).toList());

    var height = MediaQuery.of(context).size.height * 0.2;
    var sizedBox = SizedBox(
      height: height,
      child: list,
    );
    return sizedBox;
  }
}
