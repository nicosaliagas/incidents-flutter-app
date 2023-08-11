import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/controller/settings_controller.dart';

class ThemeSimpleDialog extends StatelessWidget {
  const ThemeSimpleDialog({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    Widget optionTwo = SimpleDialogOption(
      child: Text(AppLocalizations.of(context).theme_light),
      onPressed: () {
        Navigator.pop(context, ThemeMode.light);
      },
    );
    Widget optionThree = SimpleDialogOption(
      child: Text(AppLocalizations.of(context).theme_dark),
      onPressed: () {
        Navigator.pop(context, ThemeMode.dark);
      },
    );

    return SimpleDialog(
      title: Text(AppLocalizations.of(context).theme_dialog_title),
      children: <Widget>[optionTwo, optionThree],
    );
  }
}
