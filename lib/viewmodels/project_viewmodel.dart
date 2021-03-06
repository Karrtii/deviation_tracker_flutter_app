import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/models/user_model.dart';
import 'package:deviation_tracker_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/auth_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/project_service.dart';
import 'package:flutter/cupertino.dart';

import 'LoadingStatus.dart';

class ProjectViewModel with ChangeNotifier
{
  LoadingStatus loadingStatus = LoadingStatus.Empty;
  ProjectService projectService = new ProjectService();
  ProjectModel? projectModel;
  UserModel? userModel;

  var projects = <ProjectModel>[];

  var projectNames = <String>[];

  final _storage = new UserLocalStorageService();

  Future<void> getAllProjects() async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.projects = (await projectService.getAllProjects(userModel!.access_token))!;

    this.projectNames.clear();
    for(var p in this.projects)
      {
        this.projectNames.add(p.projectName);
      }

    if (this.projects.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }
}