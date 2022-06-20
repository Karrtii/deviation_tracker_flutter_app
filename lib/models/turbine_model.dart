import 'package:deviation_tracker_flutter_app/models/project_model.dart';

class TurbineModel {
  final String turbineId;
  final ProjectModel? project;

  TurbineModel({required this.turbineId, required this.project});

  static TurbineModel fromJson(json)
  {
    return TurbineModel(
        turbineId: json['turbineId'],
        project: ProjectModel.fromJson(json['project'])
    );
  }

  static Map<String, dynamic> toJson(TurbineModel turbine) {
    Map<String, dynamic> jsonMap = {
      "turbineId": turbine.turbineId
    };

    return jsonMap;
  }
}