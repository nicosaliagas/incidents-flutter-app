import 'dart:convert';

import 'package:my_app/config/constants/http_constant.dart';
import 'package:my_app/src/core/api/incident_api.dart';
import 'package:my_app/src/core/model/incident.dart';

class IncidentRepository {
  Future<IncidentModel> postIncident(IncidentModel datas) async {
    final response = await IncidentApi.postIncident(datas);

    if (response.statusCode == statusCode['HTTP_CREATED']) {
      return IncidentModel.fromJson(json.decode(response.body));
    } else {
      throw json.decode(response.body);
    }
  }
}
