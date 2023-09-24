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
  IncidentModel? newIncident;
  String errorMessages = "";

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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Ce champ est requis.";
                              }
                              return null;
                            },
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
                                await _createUserIncident();
                              }
                            },
                            child: Text('VALIDER'),
                          ),
                          Text(errorMessages)
                        ]))))
          ]),
    ));
  }

  _createUserIncident() async {
    final snackBar = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );

    User? existedUser;

    /** On vérifie si le compte utilisateur existe, en faisant une recherche par son mail */
    try {
      existedUser = await _userRepository.findUserByEmail(mailController.text);
    } catch (error) {
      _handleErrors(error);
    }

    if (existedUser != null) {
      newUser = User(
          id: existedUser.id,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          mail: mailController.text,
          phone: phoneController.text);
      // TODO: faire l'update des données de l'USER
      print("Utilisateur existant : todo : mettre à jour ses infos...");
    } else {
      /** Création de l'utilisateur */
      try {
        newUser = await _userRepository.postUser(User(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            mail: mailController.text,
            phone: phoneController.text));
      } catch (error) {
        newUser = null;
        _handleErrors(error);
      }
    }

    if (newUser != null) {
      Category category = Category(id: selectedCategory, name: '');

      /** Nouvel incident */
      IncidentModel incident = IncidentModel(
          category: category,
          description: descriptionController.text,
          user: newUser!);

      try {
        newIncident = await _incidentRepository.postIncident(incident);

        snackBar.close();
        widget.callbackWidget(newIncident!.id);
      } catch (error) {
        newIncident = null;

        _handleErrors(error);
      }
    }
  }

  _handleErrors(errors) {
    var errorSB = StringBuffer();

    if (errors is String) {
      setState(() {
        errorMessages = errors;
      });
    } else {
      errors.forEach((final String key, final value) {
        errorSB.write("- $value \r\n");
      });

      setState(() {
        errorMessages = errorSB.toString();
      });
    }
  }
}
