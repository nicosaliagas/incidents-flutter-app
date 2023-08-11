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

class _IncidentsState extends State<NewIncident> {
  int? selectedCategory;
  List<Category> categories = <Category>[];

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
    _getCategories();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              // Initial Value
              value: selectedCategory,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: categories.map((Category category) {
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
            ),
          ],
        ),
      ),
    );
  }
}
