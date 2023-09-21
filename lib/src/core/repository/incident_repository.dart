import 'dart:convert';

import 'package:my_app/src/core/api/incident_api.dart';
import 'package:my_app/src/core/model/incident.dart';

class IncidentRepository {
  Future<IncidentModel> postIncident(IncidentModel datas) async {
    final response = await IncidentApi.postIncident(datas);

    if (response.statusCode == 201) {
      return IncidentModel.fromJson(json.decode(response.body));
    } else {
      throw json.decode(response.body);
    }
  }
}
