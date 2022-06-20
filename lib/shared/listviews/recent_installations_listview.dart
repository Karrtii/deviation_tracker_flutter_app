import 'package:deviation_tracker_flutter_app/models/recently_viewed_model.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/visits_screen.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/turbine_viewmodel.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:percent_indicator/circular_percent_indicator.dart';

class RecentInstallationsListView extends StatefulWidget {
  const RecentInstallationsListView({Key? key, required this.recentlyViewedModel, required this.viewmodel}) : super(key: key);

  final List<RecentlyViewedModel> recentlyViewedModel;
  final TurbineViewModel viewmodel;

  @override
  State<RecentInstallationsListView> createState() => _RecentInstallationsListViewState();
}

class _RecentInstallationsListViewState extends State<RecentInstallationsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (5 == 0) {
            return Container(
              child: Center(
                child: Text('No trending services'),
              ),
            );
          }
          else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 20, 10),
              child: GestureDetector(
                onTap: () {
                  widget.viewmodel.getTurbineByTurbineId(widget.recentlyViewedModel[index].turbineId).then(
                          (value) => Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                VisitsScreen(turbine: widget.viewmodel.turbineModel,),
                          )),
                  );
                  print(widget.viewmodel.turbineModel);

                },
                child: Container(
                  width: 150,
                  height: 224,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                    // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    //     .withOpacity(1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                        child: Center(
                          child: CircularPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            radius: 80,
                            lineWidth: 10,
                            percent: 0.4,
                            progressColor: Colors.white,
                            backgroundColor: Colors.purple.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              '40%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.recentlyViewedModel[index].turbineId,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text(
                              'Beatrice',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}
