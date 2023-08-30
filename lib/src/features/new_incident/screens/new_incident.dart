import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/new_incident/api/category_api.dart';
import 'package:my_app/src/features/new_incident/models/category.dart';
import 'package:my_app/src/features/new_incident/widgets/new_incident_form.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/features/incidents/models/incident_model.dart';
import 'package:my_app/src/features/incidents/widgets/incident.dart';
import 'package:http/http.dart' as http;

class NewIncident extends StatefulWidget {
  @override
  State<NewIncident> createState() => _IncidentsState();
}

// TODO: Sortir dans un fichier
Future<List<Category>> fetchIncidentCategories() async {
  final response = await CategoryApi.getCategories();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable list = json.decode(response.body);

    return list.map((model) => Category.fromJson(model)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load incident categories');
  }
}

class _IncidentsState extends State<NewIncident> {
  late Future<List<Category>> futureCategories;

  @override
  initState() {
    super.initState();
    futureCategories = fetchIncidentCategories();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signaler"),
      ),
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NewIncidentForm(
                  categories: snapshot.data!,
                  callbackWidget: (datas) {
                    setState(() {
                      print("Return from the widget $datas");
                    });
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
