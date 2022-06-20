import 'package:deviation_tracker_flutter_app/models/user_model.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/visit_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingStatus.dart';

class VisitViewModel with ChangeNotifier
{
  LoadingStatus loadingStatus = LoadingStatus.Empty;
  VisitService visitService = new VisitService();
  VisitModel? visitModel;
  UserModel? userModel;

  var visits = <VisitModel>[];
  var visitStartDates = <String>[];
  var uniqueVisitStartDates = <String>[];
  var visitsByTurbineId = <VisitModel>[];

  final _storage = new UserLocalStorageService();

  Future<void> getAllVisits() async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.visits = (await visitService.getAllVisits(userModel!.access_token))!;

    //getAllUniqueVisitStartDates(visits);

    if (this.visits.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }

  Future<void> getAllUniqueVisitStartDates(List<VisitModel> visits) async
  {
    var seen = Set<String>();

    this.visitStartDates.clear();
    for(var v in visits)
    {
      this.visitStartDates.add(v.activityStartDate);
    }

    this.uniqueVisitStartDates = this.visitStartDates.where((element) => seen.add(element)).toList();

    print(this.uniqueVisitStartDates);
  }

  Future<void> getAllVisitsByTurbineId(String turbineId) async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);

    this.visitsByTurbineId = (await visitService.getAllVisitsByTurbineId(userModel!.access_token, turbineId))!;

    getAllUniqueVisitStartDates(visitsByTurbineId);

    if (this.visitsByTurbineId.isEmpty) {
      loadingStatus = LoadingStatus.Empty;
    }

    else {
      loadingStatus = LoadingStatus.Completed;
    }
  }

  Future<void> addVisit(String startDate, String endDate, String startTime, String endTime, turbine) async
  {
    loadingStatus = LoadingStatus.Searching;
    userModel = await _storage.getLoginDetails();

    // Refreshing token
    // String token = await AuthService().refreshToken(userModel!.access_token, userModel!.refresh_token);
    // userModel!.access_token = token;
    await _storage.setLoginDetails(userModel!);
    
    VisitModel visit = VisitModel(activityStartDate: startDate, activityEndDate: endDate, activityStartTime: startTime, activityEndTime: endTime, turbine: turbine);
    
    await visitService.addVisit(userModel!.access_token, visit);
  }


}