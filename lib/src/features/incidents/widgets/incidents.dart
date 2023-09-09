import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/core/model/incident.dart';
import 'package:my_app/src/features/incidents/widgets/incident.dart';

class Incidents extends StatefulWidget {
  @override
  State<Incidents> createState() => _IncidentsState();
}

class _IncidentsState extends State<Incidents> {
  @override
  Widget build(BuildContext context) {
    var incidents = <IncidentModel>[
      /*IncidentModel(
          category: 1, description: "Description de dingue", user: 1),
      IncidentModel(
          category: 1, description: "Description de dingue 2", user: 1),
      IncidentModel(
          category: 1, description: "Description de dingue 3", user: 1),*/
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
