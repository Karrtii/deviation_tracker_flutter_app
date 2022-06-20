import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:flutter/material.dart';

class VisitModel
{
  final int? visitId;
  final String activityStartDate;
  final String activityEndDate;
  final String activityStartTime;
  final String activityEndTime;
  final TurbineModel? turbine;

  VisitModel(
      {this.visitId,
        required this.activityStartDate,
        required this.activityEndDate,
        required this.activityStartTime,
        required this.activityEndTime,
        required this.turbine
     });

  static VisitModel fromJson(json)
  {
    return VisitModel(
        visitId: json['visitId'],
        activityStartDate: json['activityStartDate'],
        activityEndDate: json['activityEndDate'],
        activityStartTime: json['activityStartTime'],
        activityEndTime: json['activityEndTime'],
        turbine: TurbineModel.fromJson(json['turbine'])
    );
  }

  static Map<String, dynamic> toJson(VisitModel visit) {
    Map<String, dynamic> jsonMap = {
      "activityStartDate": visit.activityStartDate,
      "activityEndDate": visit.activityEndDate,
      "activityStartTime": visit.activityStartTime,
      "activityEndTime": visit.activityEndTime,
      "turbine": TurbineModel.toJson(visit.turbine!)
    };

    return jsonMap;
  }
}