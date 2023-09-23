import 'dart:developer';
import 'dart:ffi';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/themes/dark_theme.dart';
import 'package:my_app/config/themes/light_theme.dart';
import 'package:my_app/l10n/support_locale.dart';
import 'package:my_app/src/dialog/theme/theme_dialog.dart';
import 'package:my_app/src/features/new_incident/screens/new_incident.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/core/provider/locale_provider.dart';
import 'package:my_app/src/dialog/language/language_dialog.dart';
import 'package:my_app/src/features/incidents/widgets/incidents.dart';
import 'package:my_app/src/features/settings/controller/settings_controller.dart';
import 'package:my_app/src/page/settings/settings_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MyAppState>(
            create: (_) => MyAppState(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
          ChangeNotifierProvider<SettingsController>(
            create: (_) => settingsController,
          ),
        ],
        builder: (context, child) {
          return Consumer2<LocaleProvider, SettingsController>(
              builder: (context, localeProvider, settingsProvider, child) {
            //return Consumer<SettingsController>(
            // builder: (context, provider, child) {
            return MaterialApp(
              title: 'Namer App',
              // theme: defaultTheme,

              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              theme: lightTheme, // ThemeData(),
              darkTheme: darkTheme,
              themeMode: settingsProvider.themeMode,

              /*theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Color.fromARGB(255, 44, 112, 201)),
              ),*/
              localizationsDelegates: [
                AppLocalizations.delegate, // # Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localeProvider.locale,
              supportedLocales: L10n.support,
              home: MyHomePage(),
            );
          });
        });
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners();
  }

  void removeFavorite(favorite) {
    favorites.remove(favorite);
    notifyListeners();
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = Incidents();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(title: const Text("Futter Demo App"), actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text(AppLocalizations.of(context).appbar_menu_account),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(AppLocalizations.of(context).appbar_menu_language),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text(AppLocalizations.of(context).appbar_menu_themes),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text(AppLocalizations.of(context).appbar_menu_logout),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              print("My account menu is selected.");
            } else if (value == 1) {
              _showLanguageDialog(context);
            } else if (value == 2) {
              _showThemeDialog(context);
            } else if (value == 3) {
              print("Logout menu is selected.");
            }
          })
        ]),
        bottomNavigationBar: constraints.maxWidth < 640
            ? BottomNavigationBar(
                currentIndex: selectedIndex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.indigoAccent,
                // called when one tab is selected
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                // bottom tab items
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.feed), label: 'Favorites'),
                  ])
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 800,
                  selectedIndex: selectedIndex,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
            Expanded(
              child: Container(
                // color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewIncident()),
            )
          },
          tooltip: 'Nouvel incident',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

Future<void> _showLanguageDialog(BuildContext context) async {
  var localState = context.read<LocaleProvider>();

  switch (await showDialog<LocaleEnum>(
    context: context,
    builder: (context) => LanguageSimpleDialog(),
  )) {
    case LocaleEnum.fr:
      localState.setLocale(Locale('fr'));
      break;
    case LocaleEnum.en:
      localState.setLocale(Locale('en'));
      break;
    case null:
      break;
  }
}

Future<void> _showThemeDialog(BuildContext context) async {
  var settingsController = context.read<SettingsController>();

  switch (await showDialog<ThemeMode>(
    context: context,
    builder: (context) => ThemeSimpleDialog(controller: settingsController),
  )) {
    case ThemeMode.light:
      settingsController.updateThemeMode(ThemeMode.light);
      break;
    case ThemeMode.dark:
      settingsController.updateThemeMode(ThemeMode.dark);
      break;
    case ThemeMode.system:
    case null:
      break;
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var listContainer = <Widget>[];

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context).nFavorites(0)),
      );
    }

    appState.favorites
        .asMap()
        .forEach((index, favorite) => listContainer.add(ListTile(
              leading: Icon(Icons.highlight_remove),
              title: Text(favorite.toString()),
              onTap: () {
                appState.removeFavorite(favorite);
              },
            )));

    return ListView(children: [
      Padding(
          padding: const EdgeInsets.all(20),
          child: Text(AppLocalizations.of(context)
              .nFavorites(appState.favorites.length))),
      ...listContainer
    ]);
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context).helloWorld,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              )),
          SizedBox(height: 20),
          BigCard(pair: pair),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asUpperCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
