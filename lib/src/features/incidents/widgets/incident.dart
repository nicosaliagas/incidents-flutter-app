import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/core/model/incident_model.dart';
import 'package:my_app/src/features/incidents/widgets/detail_incident.dart';

class Incident extends StatelessWidget {
  Incident({
    super.key,
    required this.incident,
  });

  final IncidentModel incident;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(child: Text('A')),
        title: Text(incident.title),
        subtitle: Text('Supporting text'),
        onTap: () {
          print("Tap on tile  : ${incident.title}");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailIncident(incident: incident)),
          );
        });
  }
}
