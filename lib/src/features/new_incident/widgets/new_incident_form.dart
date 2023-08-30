import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/new_incident/models/category.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/features/incidents/models/incident_model.dart';
import 'package:my_app/src/features/incidents/widgets/detail_incident.dart';

class NewIncidentForm extends StatefulWidget {
  final List<Category> categories;
  final ValueChanged<int> callbackWidget;

  NewIncidentForm(
      {super.key, required this.categories, required this.callbackWidget});

  @override
  State<NewIncidentForm> createState() => _NewIncidentFormState();
}

class _NewIncidentFormState extends State<NewIncidentForm> {
  int selectedCategory = 1;

  _NewIncidentFormState();

  var userIndentity = Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Prénom",
            ),
          ),
        ), // <-- Wrapped in Expanded.
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Nom",
            ),
          ),
        ), // <-- Wrapped in Expanded.
      )
    ],
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
      key: _formKey,
      child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
                child: Card(
                    elevation: 8.0,
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: <Widget>[
                          DropdownButton<int>(
                            // Initial Value
                            value: selectedCategory,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: widget.categories.map((Category category) {
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
                                widget.callbackWidget(selectedCategory!);
                              });
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Description",
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          userIndentity,
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Téléphone",
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(30.0),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () => {},
                              minWidth: 150.0,
                              height: 50.0,
                              color: Color(0xFF179CDF),
                              child: Text(
                                "VALIDER",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ]))))
          ]),
    ));
  }
}
