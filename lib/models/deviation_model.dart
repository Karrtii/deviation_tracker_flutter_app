import 'package:deviation_tracker_flutter_app/models/visit_model.dart';

class DeviationModel
{
  final int? deviationId;
  final String deviationStartDate;
  final String deviationEndDate;
  final String deviationStartTime;
  final String deviationEndTime;
  final String problem;
  final String solution;
  final bool approved;
  final VisitModel? visit;

  DeviationModel(
      {this.deviationId,
      required this.deviationStartDate,
        required this.deviationEndDate,
        required this.deviationStartTime,
        required this.deviationEndTime,
        required this.problem,
        required this.solution,
        required this.approved,
        required this.visit});
}