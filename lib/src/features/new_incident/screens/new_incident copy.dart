import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/new_incident/api/category_api.dart';
import 'package:my_app/src/features/new_incident/models/category.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/features/incidents/models/incident_model.dart';
import 'package:my_app/src/features/incidents/widgets/incident.dart';
import 'package:http/http.dart' as http;

class NewIncident extends StatefulWidget {
  @override
  State<NewIncident> createState() => _IncidentsState();
}

Future<List<Category>> fetchCategories() async {
  final response = await CategoryApi.getCategories();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable list = json.decode(response.body);

    return list.map((model) => Category.fromJson(model)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _IncidentsState extends State<NewIncident> {
  int? selectedCategory;
  List<Category> categories = <Category>[];
  late Future<List<Category>> futureCategories;

  _getCategories() {
    CategoryApi.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        categories = list.map((model) => Category.fromJson(model)).toList();

        selectedCategory = categories.isNotEmpty ? categories.first.id : 1;
      });
    });
  }

  @override
  initState() {
    super.initState();
    futureCategories = fetchCategories();
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
              // TODO: le sortir dans un fichier widget
              return DropdownButton<int>(
                // Initial Value
                value: selectedCategory,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: snapshot.data!.map((Category category) {
                  return DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (int? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
              );
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