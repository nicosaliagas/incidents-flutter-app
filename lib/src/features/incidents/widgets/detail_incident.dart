import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/core/model/incident.dart';

class DetailIncident extends StatelessWidget {
  DetailIncident({
    super.key,
    required this.incident,
  });

  final IncidentModel incident;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text("Catégorie du signalement"),
          centerTitle: true,
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/beach.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverFixedExtentList(
            delegate: SliverChildListDelegate([
              Text(incident.description),
              Text(incident.description),
              Text(incident.description),
              Text(incident.description),
              Text(incident.description),
              Text(incident.description),
            ]),
            itemExtent: 200.00)
      ],
    )));
  }
}
