import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:http/http.dart';

class ProjectService
{
  //base url
  final String url = "http://karrtii.com:8080/api/project";

  Future<List<ProjectModel>?> getAllProjects(String access_token) async
  {
    try {
      var response = await get(Uri.parse(url), headers: {
        "Authorization": "Bearer $access_token"
      });

      if(response.statusCode == 200) {
        var bookingDetails = jsonDecode(response.body);

        List<ProjectModel> projects = [];

        for (var p in bookingDetails) {
          ProjectModel projectModel = ProjectModel(
              projectId: p["projectId"],
              projectName: p["projectName"]
          );
          projects.add(projectModel);
        }
        return projects;
      }
      else
      {
        throw Exception('Response failed');
      }

    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}