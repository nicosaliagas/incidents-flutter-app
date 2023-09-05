import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/core/model/incident_model.dart';
import 'package:my_app/src/features/incidents/widgets/incident.dart';

class Incidents extends StatefulWidget {
  @override
  State<Incidents> createState() => _IncidentsState();
}

class _IncidentsState extends State<Incidents> {
  @override
  Widget build(BuildContext context) {
    var incidents = <IncidentModel>[
      IncidentModel("Incident 1", DateTime.now(),
          "61 avenue Maryse Bastié, 33520 BRUGES", "Dégradation"),
      IncidentModel("Incident 2", DateTime.now(),
          "32 avenue Maryse Bastié, 33520 BRUGES", "Dégradation"),
      IncidentModel("Incident 3", DateTime.now(),
          "44 avenue Maryse Bastié, 33520 BRUGES", "Dégradation"),
    ];

    var listIncidents = <Widget>[];

    incidents.asMap().forEach((index, element) {
      listIncidents.add(Incident(incident: element));

      listIncidents.add(Divider(height: 0));
    });
    return ListView(
      children: <Widget>[...listIncidents],
    );
  }
}
