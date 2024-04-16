import 'package:expenso/my_app/my_app_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = MyAppCubit();
    var home = cubit.getHomeWidget();
    var bloc = BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (builderContext, state) {
        var themeProvider = ThemeProvider();

        var materialApp = MaterialApp(
          theme: themeProvider.getTheme(),
          darkTheme: themeProvider.getDarkTheme(),
          themeMode: state.themeMode,
          home: home,
          routes: {"/home": (builderContext) => home},
        );
        return materialApp;
      },
    );

    return bloc;
  }
}
