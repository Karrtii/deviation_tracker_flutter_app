import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constants.dart';

class VisitsChartBackCard extends StatefulWidget {
  const VisitsChartBackCard({Key? key, required this.turbine}) : super(key: key);

  final TurbineModel turbine;

  @override
  State<VisitsChartBackCard> createState() => _VisitsChartBackCardState();
}

class _VisitsChartBackCardState extends State<VisitsChartBackCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 1500,
              radius: 150,
              lineWidth: 18,
              percent: 0.6,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.blue.shade100,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '60%',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    child: Column(
                      children: [
                        Text(
                          widget.turbine.turbineId,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          widget.turbine.project!.projectName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Lead time',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '12',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  'incl. SGRE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '15',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  'exl. SGRE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
