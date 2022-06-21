import 'package:deviation_tracker_flutter_app/models/deviation_model.dart';
import 'package:deviation_tracker_flutter_app/models/user_model.dart';
import 'package:deviation_tracker_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/deviation_service.dart';
import 'package:flutter/cupertino.dart';

import 'LoadingStatus.dart';

class DeviationViewModel with ChangeNotifier
{
  LoadingStatus loadingStatus = LoadingStatus.Empty;
  DeviationService deviationService = new DeviationService();
  DeviationModel? deviationModel;
  UserModel? userModel;

  var deviations = <DeviationModel>[];

  final _storage = new UserLocalStorageService();

  Future<void> getAllDeviationsByVisitId(int? visitId) async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.deviations = (await deviationService.getAllDeviationsByVisitId(userModel!.access_token, visitId))!;

    if (this.deviations.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }
}