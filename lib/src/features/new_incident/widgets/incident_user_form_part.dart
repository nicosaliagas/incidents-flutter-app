import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/core/model/incident.dart';
import 'package:my_app/src/features/incidents/widgets/detail_incident.dart';

class IncidentUserFormPart extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController mailController;

  IncidentUserFormPart({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.mailController,
  });

  @override
  State<IncidentUserFormPart> createState() => _IncidentUserFormPartState();
}

class _IncidentUserFormPartState extends State<IncidentUserFormPart> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextFormField(
                controller: widget.firstNameController,
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
                controller: widget.lastNameController,
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
        controller: widget.phoneController,
        decoration: InputDecoration(
          labelText: "Téléphone",
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      TextFormField(
        controller: widget.mailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Ce champ est requis.";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Email",
        ),
      )
    ]);
  }
}
