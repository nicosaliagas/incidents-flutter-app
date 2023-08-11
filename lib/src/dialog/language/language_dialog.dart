import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';

class LanguageSimpleDialog extends StatefulWidget {
  @override
  State<LanguageSimpleDialog> createState() => _LanguageSimpleDialogState();
}

class _LanguageSimpleDialogState extends State<LanguageSimpleDialog> {
  @override
  Widget build(BuildContext context) {
    Widget optionOne = SimpleDialogOption(
      child: Text(AppLocalizations.of(context).language_fr),
      onPressed: () {
        Navigator.pop(context, LocaleEnum.fr);
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: Text(AppLocalizations.of(context).language_en),
      onPressed: () {
        Navigator.pop(context, LocaleEnum.en);
      },
    );

    return SimpleDialog(
      title: Text(AppLocalizations.of(context).language_dialog_title),
      children: <Widget>[
        optionOne,
        optionTwo,
      ],
    );
  }
}
