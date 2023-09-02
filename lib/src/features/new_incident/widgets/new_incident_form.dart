import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/new_incident/api/user_api.dart';
import 'package:my_app/src/features/new_incident/models/category.dart';
import 'package:my_app/src/features/new_incident/models/user.dart';
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

// TODO: Sortir dans un fichier
Future<User> postIncidentUser(User datas) async {
  final response = await UserApi.postUser(datas);

  if (response.statusCode == 201) {
    return User.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to post user');
  }
}

class _NewIncidentFormState extends State<NewIncidentForm> {
  int selectedCategory = 1;

  _NewIncidentFormState();

  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController mailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    descriptionController.clear();
    mailController.clear();
    phoneController.clear();
    firstNameController.clear();
    lastNameController.clear();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // TODO: exporter dans un fichier
  var userForm = Column(children: <Widget>[
    Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: "Prénom",
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: "Nom",
              ),
            ),
          ),
        )
      ],
    ),
    SizedBox(
      height: 15.0,
    ),
    TextFormField(
      controller: phoneController,
      decoration: InputDecoration(
        labelText: "Téléphone",
      ),
    ),
    SizedBox(
      height: 15.0,
    ),
    TextFormField(
      controller: mailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "L'email est requis.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
      ),
    )
  ]);

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
                          TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: "Description",
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          userForm,
                          SizedBox(
                            height: 15.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );

                                User user = User(
                                    id: -1,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    mail: mailController.text,
                                    phone: phoneController.text);

                                postIncidentUser(user).then((User newUser) {
                                  print(
                                      "Nouvel utilisteur >> ${newUser.toJson()}");

                                  widget.callbackWidget(newUser.id);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Utilisateur créé avec succès ${newUser.id}")));
                                });
                              }
                            },
                            child: Text('VALIDER'),
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
