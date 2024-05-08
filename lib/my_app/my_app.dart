import 'package:expenso/l10n/app_localizator.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:expenso/main.dart';
import 'package:expenso/modules/main/views/main_view.dart';
import 'package:expenso/modules/welcome/welcome.dart';
import 'package:expenso/my_app/my_app_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    notificationService.setListeners();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      notificationService.resetGlobalBadge();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizator = AppLocalizator();
    var home = _getHomeWidget();

    var bloc = BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (builderContext, state) {
        var themeProvider = ThemeProvider();
        var materialApp = MaterialApp(
          onGenerateTitle: (context) {
            //* Don't use localeResolutionCallback() for updating.
            //* AppLocalizations is not ready when callback is called
            appLocalizator.update(AppLocalizations.of(context)!);
            return "";
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: themeProvider.getTheme(true),
          darkTheme: themeProvider.getTheme(false),
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
