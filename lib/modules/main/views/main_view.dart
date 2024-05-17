import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/gen/assets.gen.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:expenso/modules/main/cubits/keyboard/keyboard_cubit.dart';
import 'package:expenso/modules/settings/settings.dart';
import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import 'package:expenso/modules/history/cubit/history_cubit.dart';
import 'package:expenso/modules/history/views/history.dart';
import 'package:expenso/modules/main/cubits/spend_today_amount_provider.dart';
import 'package:expenso/modules/main/cubits/transactions/transactions_cubit.dart';
import 'package:expenso/modules/main/views/enter_transaction_data/enter_transaction_data.dart';
import 'package:expenso/modules/main/views/transactions_list/transactions_list.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String sum = NumericKeyboardButtonType.zero.value;
  late SpendTodayAmountProvider cubit;

  _MainViewState() {
    cubit = SpendTodayAmountProvider(callback: (String amountString) {
      setState(() {
        sum = amountString;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: _getAppBar(context),
      body: _getBody(context),
      resizeToAvoidBottomInset: false,
    );
    return scaffold;
  }

  PreferredSizeWidget? _getAppBar(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sum, style: textTheme.displayMedium),
        Text(
          AppLocalizations.of(context)!.spentToday,
          style: textTheme.titleMedium,
        ),
      ],
    );
    var appBar = AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: column,
      actions: [
        _getAnalyseBarButton(context),
        _getSettingsBarButton(context),
      ],
    );
    var padding = Padding(
      padding: const EdgeInsets.only(left: 32, right: 20),
      child: appBar,
    );

    var height = MediaQuery.of(context).size.height * 0.111;
    var preferredSize = PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: SafeArea(child: padding),
    );
    return preferredSize;
  }

  IconButton _getAnalyseBarButton(BuildContext context) {
    var bloc = BlocProvider(
      create: (context) => HistoryCubit(),
      child: const History(),
    );
    var button = IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => bloc)));
        },
        icon: Assets.barChartIcon.image(
          width: 24,
          height: 24,
          color: Theme.of(context).colorScheme.primary,
        ));
    return button;
  }

  IconButton _getSettingsBarButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const Settings())));
      },
      icon: Assets.settingsIcon.image(
        width: 24,
        height: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _getTransactionListView(),
        ColoredBox(
          color: Theme.of(context).extension<AdditionalColors>()!.background1,
          child: SafeArea(child: _getKeyboard(context)),
        ),
      ],
    );
  }

  Widget _getTransactionListView() {
    var listView = const TransactionsList();
    var bloc = BlocProvider(
      create: (context) => TransactionsCubit(),
      child: listView,
    );

    return bloc;
  }

  Widget _getKeyboard(BuildContext context) {
    var keyboardHeightRatio = 0.398;
    var size = MediaQuery.of(context).size;
    var height = size.height - MediaQuery.of(context).padding.vertical;
    var bloc = BlocProvider(
        create: (context) => KeyboardCubit(),
        child: EnterTransactionData(
          size: Size(size.width, height * keyboardHeightRatio),
        ));
    return bloc;
  }
}
