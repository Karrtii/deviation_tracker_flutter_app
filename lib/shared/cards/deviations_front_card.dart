import 'package:deviation_tracker_flutter_app/models/deviation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class DeviationsFrontCard extends StatefulWidget {
  const DeviationsFrontCard({Key? key, required this.deviation}) : super(key: key);

  final DeviationModel deviation;

  @override
  State<DeviationsFrontCard> createState() => _DeviationsFrontCardState();
}

class _DeviationsFrontCardState extends State<DeviationsFrontCard> {
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
                  "assets/icons/deviationicon.svg",
                  color: Colors.black,
                ),
                onPressed: () {  },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 10, 5),
                child: Column(
                  children: [
                    Text(
                      widget.deviation.deviationStartDate == null ? "" : DateFormat("dd MMMM, yyyy").format(DateTime.parse(widget.deviation.deviationStartDate)),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      widget.deviation.deviationStartTime == null ? "" : TimeOfDay(hour:int.parse(widget.deviation.deviationStartTime.split(":")[0]),minute: int.parse(widget.deviation.deviationStartTime.split(":")[1])).format(context),
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Start',
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
                      widget.deviation.deviationEndDate == null ? "" : DateFormat("dd MMMM, yyyy").format(DateTime.parse(widget.deviation.deviationEndDate)),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      widget.deviation.deviationEndTime == null ? "" : TimeOfDay(hour:int.parse(widget.deviation.deviationEndTime.split(":")[0]),minute: int.parse(widget.deviation.deviationEndTime.split(":")[1])).format(context),
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'End',
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
                      widget.deviation.deviationStartDate == null ? "" : DateFormat("dd").format(DateTime.parse(widget.deviation.deviationStartDate)),
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
                      'Duration',
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
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) =>
                  //       DeviationsScreen(visit: widget.visit,),
                  // ));
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
