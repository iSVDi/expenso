import 'package:expenso/modules/main/views/main_view.dart';
import 'package:expenso/modules/welcome/welcome.dart';
import 'package:expenso/my_app/my_app_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var home = _getHomeWidget();
    var bloc = BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (builderContext, state) {
        var themeProvider = ThemeProvider();
        var materialApp = MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: themeProvider.getTheme(),
          darkTheme: themeProvider.getDarkTheme(),
          themeMode: state.themeMode,
          home: home,
        );
        return materialApp;
      },
    );

    return bloc;
  }

  Widget _getHomeWidget() {
    var cubit = MyAppCubit();
    if (cubit.needPresentOnBoarding()) {
      return const Welcome();
    }
    return const MainView();
  }
}
