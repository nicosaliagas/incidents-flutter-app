import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/category.dart';
import 'package:my_app/src/core/model/incident.dart';
import 'package:my_app/src/core/model/user.dart';
import 'package:my_app/src/core/repository/incident_repository.dart';
import 'package:my_app/src/core/repository/user_repository.dart';
import 'package:my_app/src/features/new_incident/widgets/incident_user_form_part.dart';

class NewIncidentForm extends StatefulWidget {
  final List<Category> categories;
  final ValueChanged<int> callbackWidget;

  NewIncidentForm(
      {super.key, required this.categories, required this.callbackWidget});

  @override
  State<NewIncidentForm> createState() => _NewIncidentFormState();
}

class _NewIncidentFormState extends State<NewIncidentForm> {
  final UserRepository _userRepository = UserRepository();
  final IncidentRepository _incidentRepository = IncidentRepository();

  int selectedCategory = 1;

  User? newUser;

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
                            isExpanded: true,
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
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
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
                          IncidentUserFormPart(
                              firstNameController: firstNameController,
                              lastNameController: lastNameController,
                              mailController: mailController,
                              phoneController: phoneController),
                          SizedBox(
                            height: 15.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final snackBar =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );

                                /** Définition de l'utilisateur */
                                User user = User(
                                    id: -1,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    mail: mailController.text,
                                    phone: phoneController.text);

                                Category category =
                                    Category(id: selectedCategory, name: '');

                                /** Création de l'utilisateur */
                                Future<User> future =
                                    _userRepository.postUser(user);

                                await future
                                    .then((User newUser) =>
                                        _handleUserLoaded(newUser))
                                    .catchError(
                                        (error) => _handleErrorUser(error));

                                if (newUser != null) {
                                  print(
                                      "on va créer maintenant l'incident ! ${newUser!.mail}");
                                }

                                /** Nouvel incident */
                                /*IncidentModel incident = IncidentModel(
                                    category: category,
                                    description: descriptionController.text,
                                    user: newUser);

                                IncidentModel newIncident =
                                    await _incidentRepository
                                        .postIncident(incident);

                                snackBar.close();
                                widget.callbackWidget(newIncident.id);*/

                                /*_userRepository
                                    .postUser(user)
                                    .then((User newUser) {
                                  IncidentModel incident = IncidentModel(
                                      category: category,
                                      description: descriptionController.text,
                                      user: newUser);

                                  _incidentRepository
                                      .postIncident(incident)
                                      .then((IncidentModel newIncident) {
                                    snackBar.close();

                                    widget.callbackWidget(newIncident.id);
                                  });
                                });*/
                              }
                            },
                            child: Text('VALIDER'),
                          ),
                        ]))))
          ]),
    ));
  }

  _handleUserLoaded(User user) {
    setState(() {
      newUser = user;
    });
  }

  _handleErrorUser(errors) {
    print("_handleErrorUser $errors");

    errors.forEach((final String key, final value) {
      print("Key: {{$key}} -> value: $value");
    });
  }
}
