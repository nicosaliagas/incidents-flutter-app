import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:my_app/config/constants/http_constant.dart';
import 'package:my_app/src/core/api/error_interceptor.dart';
import 'package:my_app/src/core/api/incident_api.dart';
import 'package:my_app/src/core/model/incident.dart';

class IncidentRepository {
  IncidentApi incidentApi = IncidentApi();

  Future<IncidentModel> postIncident(IncidentModel datas) async {
    final response = await incidentApi.postIncident(datas);

    if (response.statusCode == statusCode['HTTP_CREATED']) {
      return IncidentModel.fromJson(json.decode(response.body));
    } else {
      throw json.decode(response.body);
    }
  }
}
