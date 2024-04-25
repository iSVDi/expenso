import 'package:expenso/modules/settings/appearance.dart';
import 'package:expenso/modules/settings/my_categories_list.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Settings extends StatelessWidget {
  const Settings({super.key});

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
    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: ((context, index) {
        var model = listItems[index];
        var cell = ListTile(title: model.child, onTap: model.onTap);
        return cell;
      }),
    );
  }

  List<_SettingsItemModel> _getListItems(BuildContext context) {
    return [
      _getMyCategoriesModel(context),
      _getAppearanceModel(context),
    ];
  }

  _SettingsItemModel _getMyCategoriesModel(BuildContext context) {
    return _SettingsItemModel(
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

_SettingsItemModel _getAppearanceModel(BuildContext context) {
  return _SettingsItemModel(
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

class _SettingsItemModel {
  final Widget child;
  final Function()? onTap;

  _SettingsItemModel({
    required this.child,
    required this.onTap,
  });
}
