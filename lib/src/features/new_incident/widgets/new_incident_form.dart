import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/category.dart';
import 'package:my_app/src/core/model/user.dart';
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

  int selectedCategory = 1;

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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final snackBar =
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

                                _userRepository
                                    .postUser(user)
                                    .then((User newUser) {
                                  snackBar.close();
                                  widget.callbackWidget(newUser.id);
                                });
                              }
                            },
                            child: Text('VALIDER $selectedCategory'),
                          ),
                        ]))))
          ]),
    ));
  }
}
