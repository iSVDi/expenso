import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:expenso/modules/settings/settings_cubit.dart';
import 'package:expenso/modules/settings/settings_list_item_model.dart';
import 'package:expenso/modules/settings/widgets/my_categories_list.dart';
import 'package:expenso/modules/settings/widgets/select_appearance.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _cubit = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(actions: const []),
      body: _getBody(context),
    );
    return scaffold;
  }

  Widget _getBody(BuildContext context) {
    var listItems = _getListItems(context);
    var list = ListView.builder(
      itemCount: listItems.length,
      itemBuilder: ((context, index) {
        var model = listItems[index];
        var cell = ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            title: model.child,
            onTap: model.onTap);
        return cell;
      }),
    );

    return list;
  }

  List<SettingsListItemModel> _getListItems(BuildContext context) {
    return [
      _getReminderModel(context),
      _getMyCategoriesModel(context),
      _getAppearanceModel(context),
    ];
  }

  //TODO set switch style
  SettingsListItemModel _getReminderModel(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    var richTextChild = TextSpan(
      text: _cubit.getForamttedTime(),
      style: textTheme.headlineLarge!
          .copyWith(color: colorScheme.primary, fontWeight: FontWeight.w300),
      recognizer: TapGestureRecognizer()..onTap = () => _showTimePickerHander(),
    );

    var richText = RichText(
      text: TextSpan(
        text: AppLocalizations.of(context)!.reminderTitle,
        style: textTheme.titleMedium!.copyWith(color: colorScheme.onBackground),
        children: [richTextChild],
      ),
    );

    var reminderSwitch = Switch(
      value: (_cubit.getSwitchState()),
      onChanged: (value) => setState(() {
        _cubit.switchHandler(context, value);
      }),
    );

    var child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [richText, reminderSwitch],
    );
    return SettingsListItemModel(child: child, onTap: null);
  }

  Future _showTimePickerHander() async {
    var time = await showTimePicker(
      context: context,
      initialTime: _cubit.getTime(),
    );
    if (time != null) {
      setState(() {
        _cubit.setTime(context, time);
      });
    }
  }

  SettingsListItemModel _getMyCategoriesModel(BuildContext context) {
    return SettingsListItemModel(
      child: Text(AppLocalizations.of(context)!.myCategories,
          style: Theme.of(context).textTheme.titleMedium),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MyCategoriesList(),
            ));
      },
    );
  }
}

SettingsListItemModel _getAppearanceModel(BuildContext context) {
  return SettingsListItemModel(
    child: Text(
      AppLocalizations.of(context)!.appearanceTitle,
      style: Theme.of(context).textTheme.titleMedium,
    ),
    onTap: () {
      showModalBottomSheet(
          context: context,
          builder: (builderContext) {
            return const SelectAppearance();
          });
    },
  );
}
