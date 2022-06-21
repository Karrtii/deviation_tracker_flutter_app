import 'package:deviation_tracker_flutter_app/models/deviation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class DeviationsBackCard extends StatefulWidget {
  const DeviationsBackCard({Key? key, required this.deviation}) : super(key: key);

  final DeviationModel deviation;

  @override
  State<DeviationsBackCard> createState() => _DeviationsBackCardState();
}

class _DeviationsBackCardState extends State<DeviationsBackCard> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Problem',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      widget.deviation.problem == null ? "N/A" : widget.deviation.problem,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 5, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solution',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      widget.deviation.solution == null ? "N/A" : widget.deviation.solution,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
