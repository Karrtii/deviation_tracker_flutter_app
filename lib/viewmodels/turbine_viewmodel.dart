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
  TurbineModel? turbineModel;
  UserModel? userModel;

  var turbines = <TurbineModel>[];

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
}