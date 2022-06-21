import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:deviation_tracker_flutter_app/models/deviation_model.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:http/http.dart';

class DeviationService
{
  //base url
  final String url = "http://karrtii.com:8080/api/deviation";

  Future<List<DeviationModel>?> getAllDeviationsByVisitId(String access_token, int? visitId) async
  {
    try {
      var response = await get(Uri.parse("$url?visitId=$visitId"), headers: {
        "Authorization": "Bearer $access_token"
      });

      if (response.statusCode == 200) {
        var responseDetails = jsonDecode(response.body);

        List<DeviationModel> deviations = [];

        for (var r in responseDetails) {
          DeviationModel deviationModel = DeviationModel(
              deviationId: r['deviationId'],
              deviationStartDate: r['deviationStartDate'],
              deviationEndDate: r['deviationEndDate'],
              deviationStartTime: r['deviationStartTime'],
              deviationEndTime: r['deviationEndTime'],
              problem: r['problem'],
              solution: r['solution'],
              approved: r['approved'],
              visit: VisitModel.fromJson(r['visit'])
          );
          deviations.add(deviationModel);
        }
        return deviations;
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