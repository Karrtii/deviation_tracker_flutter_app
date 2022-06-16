import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:http/http.dart';

class TurbineService
{
  //base url
  final String url = "http://karrtii.com:8080/api/turbine";

  Future<List<TurbineModel>?> getAllTurbines(String access_token) async
  {
    try {
      var response = await get(Uri.parse(url), headers: {
        "Authorization": "Bearer $access_token"
      });

      if (response.statusCode == 200) {
        var responseDetails = jsonDecode(response.body);

        List<TurbineModel> turbines = [];

        for (var t in responseDetails) {
          TurbineModel turbineModel = TurbineModel(
              turbineId: t['turbineId'],
              project: ProjectModel.fromJson(t['project'])
          );
          turbines.add(turbineModel);
        }
        return turbines;
      }
      else {
        throw Exception('Response failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<TurbineModel>?> getAllTurbinesByProjectName(String access_token, String projectName) async
  {
    try {
      var response = await get(Uri.parse("$url/project?projectName=$projectName"), headers: {
        "Authorization": "Bearer $access_token"
      });

      if (response.statusCode == 200) {
        var responseDetails = jsonDecode(response.body);

        List<TurbineModel> turbines = [];

        for (var t in responseDetails) {
          TurbineModel turbineModel = TurbineModel(
              turbineId: t['turbineId'],
              project: ProjectModel.fromJson(t['project'])
          );
          turbines.add(turbineModel);
        }
      }
      else {
        throw Exception('Response failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Future<List<TurbineModel>?> getAllTurbines(String access_token) async
  // {
  //   try{
  //
  //     Response response = await get(Uri.parse(url));
  //     Iterable responseGet = jsonDecode(response.body);
  //     List<TurbineModel> turbines = List<TurbineModel>.from(responseGet.map((e) => TurbineModel.fromJson(e)));
  //
  //     print(turbines[0]);
  //     return turbines;
  //   } catch(e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
