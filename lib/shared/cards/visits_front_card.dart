import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/deviations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants.dart';

class VisitsFrontCard extends StatefulWidget {
  const VisitsFrontCard({Key? key, required this.startDate, required this.endDate, required this.startTime, required this.endTime, required this.visit}) : super(key: key);

  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final VisitModel visit;

  @override
  State<VisitsFrontCard> createState() => _VisitsFrontCardState();
}

class _VisitsFrontCardState extends State<VisitsFrontCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/visit.svg",
                  color: Colors.black,
                ),
                onPressed: () {  },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 10, 5),
                child: Column(
                  children: [
                    Text(
                      widget.startDate == null ? "" : DateFormat("dd MMMM, yyyy").format(DateTime.parse(widget.startDate)),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      widget.startTime == null ? "" : TimeOfDay(hour:int.parse(widget.startTime.split(":")[0]),minute: int.parse(widget.startTime.split(":")[1])).format(context),
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      AppLocalizations.of(context)!.visitStart,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 5, 5),
                child: Column(
                  children: [
                    Text(
                      widget.endDate == null ? "" : DateFormat("dd MMMM, yyyy").format(DateTime.parse(widget.endDate)),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      widget.endTime == null ? "" : TimeOfDay(hour:int.parse(widget.endTime.split(":")[0]),minute: int.parse(widget.endTime.split(":")[1])).format(context),
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      AppLocalizations.of(context)!.visitEnd,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                child: Column(
                  children: [
                    Text(
                      widget.startDate == null ? "" : DateFormat("dd").format(DateTime.parse(widget.startDate)),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '18',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      AppLocalizations.of(context)!.visitDuration,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              new Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        DeviationsScreen(visit: widget.visit,),
                  ));
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
              //Text(widget.visits == 0 ? "" : DateFormat("dd MMMM, yyyy,").format(DateTime.parse(widget.visits[index].activityStartDate))),
            ],
          ),
        ),
      ),
    );
  }
}
