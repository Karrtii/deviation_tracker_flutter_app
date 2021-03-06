import 'package:deviation_tracker_flutter_app/models/recently_viewed_model.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:deviation_tracker_flutter_app/models/user_model.dart';
import 'package:deviation_tracker_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/auth_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/turbine_service.dart';
import 'package:flutter/cupertino.dart';

import 'LoadingStatus.dart';

class TurbineViewModel with ChangeNotifier
{
  LoadingStatus loadingStatus = LoadingStatus.Empty;
  TurbineService turbineService = new TurbineService();
  var turbineModel;
  UserModel? userModel;

  var turbines = <TurbineModel>[];
  var turbinesByProjectName = <TurbineModel>[];
  var recentlyViewed = <RecentlyViewedModel>[];

  final _storage = new UserLocalStorageService();

  Future<void> getAllTurbines() async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.turbines = (await turbineService.getAllTurbines(userModel!.access_token))!;

    if (this.turbines.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }

  Future<void> getAllTurbinesByProjectName(String projectName) async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.turbinesByProjectName = (await turbineService.getAllTurbinesByProjectName(userModel!.access_token, projectName))!;

    if (this.turbinesByProjectName.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }

  Future<void> getTurbineByTurbineId(String turbineId) async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.turbineModel = (await turbineService.getTurbineByTurbineId(userModel!.access_token, turbineId))!;

    if (this.turbineModel == null) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }

  Future<void> addView(String turbineId) async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    await turbineService.addView(userModel!.access_token, turbineId);
  }

  Future<void> getAllRecentlyViewed() async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.recentlyViewed = (await turbineService.getAllRecentlyViewed(userModel!.access_token))!;

    if (this.recentlyViewed.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }
}