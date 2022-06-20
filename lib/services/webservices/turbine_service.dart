import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/models/recently_viewed_model.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:http/http.dart';

class TurbineService
{
  //base url
  final String url = "http://karrtii.com:8080/api/turbine";
  final String urlRecentlyViewed = "http://karrtii.com:8080/api/recent";

  Future<List<TurbineModel>?> getAllTurbines(String access_token) async
  {
    try {
      var response = await get(Uri.parse("$url/all"), headers: {
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

  Future<TurbineModel?> getTurbineByTurbineId(String access_token, String turbineId) async
  {
    try {
      var response = await get(Uri.parse("$url?turbineId=$turbineId"), headers: {
        "Authorization": "Bearer $access_token"
      });

      if (response.statusCode == 200) {
        var responseDetails = jsonDecode(response.body);

          TurbineModel turbineModel = TurbineModel(
              turbineId: responseDetails['turbineId'],
              project: ProjectModel.fromJson(responseDetails['project'])
          );

        return turbineModel;
      }
      else {
        throw Exception('Response failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future addView(String access_token, String turbineId) async
  {
    try {
      await post(Uri.parse("$urlRecentlyViewed?turbineId=$turbineId"), headers: {
        "Authorization": "Bearer $access_token", "Content-Type": "application/json"
      },
      );
    }
    catch(e) {
      print(e.toString());
    }
  }

  Future<List<RecentlyViewedModel>?> getAllRecentlyViewed(String access_token) async
  {
    try {
      var response = await get(Uri.parse(urlRecentlyViewed), headers: {
        "Authorization": "Bearer $access_token"
      });

      if (response.statusCode == 200) {
        var responseDetails = jsonDecode(response.body);

        List<RecentlyViewedModel> recent = [];

        for (var t in responseDetails) {
          RecentlyViewedModel recentlyViewedModel = RecentlyViewedModel(
              recentId: t['recentId'],
              userId: t['userId'],
              turbineId: t['turbineId']
          );
          recent.add(recentlyViewedModel);
        }
        return recent;
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
