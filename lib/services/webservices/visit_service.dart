import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:http/http.dart';

class VisitService
{
  //base url
  final String url = "http://karrtii.com:8080/api/visit";

  Future<List<VisitModel>?> getAllVisits(String access_token) async
  {
    try {
      var response = await get(Uri.parse(url), headers: {
        "Authorization": "Bearer $access_token"
      });

      if (response.statusCode == 200) {
        var responseDetails = jsonDecode(response.body);

        List<VisitModel> visits = [];

        for (var r in responseDetails) {
          VisitModel visitModel = VisitModel(
              visitId: r['visitId'],
              activityStartDate: r['activityStartDate'],
              activityEndDate: r['activityEndDate'],
              activityStartTime: r['activityStartTime'],
              activityEndTime: r['activityEndTime'],
              turbine: TurbineModel.fromJson(r['turbine'])
          );
          visits.add(visitModel);
        }
        return visits;
      }
      else {
        throw Exception('Response failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}