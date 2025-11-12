import 'package:http/http.dart' as http;
import 'dart:convert';

import '../domain/models/alert.dart';
import 'alert_assembler.dart';

class AlertsApi {
  final String baseUrl = "http://192.168.1.47:8080/api/v1";
  final String alertsEndpoint = "/alerts";

  Future<List<Alert>> getAlerts() async {
    final res = await http.get(Uri.parse("$baseUrl$alertsEndpoint"));
    final data = jsonDecode(res.body) as List;
    return data.map((e) => AlertAssembler.fromJson(e)).toList();
  }

  Future<Alert> acknowledgeAlert(int id) async {
    final res = await http.patch(Uri.parse("$baseUrl$alertsEndpoint/$id/acknowledge"));
    return AlertAssembler.fromJson(jsonDecode(res.body));
  }

  Future<Alert> closeAlert(int id) async {
    final res = await http.patch(Uri.parse("$baseUrl$alertsEndpoint/$id/close"));
    return AlertAssembler.fromJson(jsonDecode(res.body));
  }
}
