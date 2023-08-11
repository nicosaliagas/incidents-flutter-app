import 'package:flutter/material.dart';
import 'package:my_app/src/core/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var localState = context.read<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).routeSettings),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    localState.setLocale(Locale("fr"));
                  },
                  child: Text('Fr'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    localState.setLocale(Locale("en"));
                  },
                  child: Text('En'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
