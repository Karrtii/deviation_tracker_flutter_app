import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RecentLoadoutsListView extends StatefulWidget {
  const RecentLoadoutsListView({Key? key}) : super(key: key);

  @override
  State<RecentLoadoutsListView> createState() => _RecentLoadoutsListViewState();
}

class _RecentLoadoutsListViewState extends State<RecentLoadoutsListView> {
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
                child: Text('No recently viewed loadouts'),
              ),
            );
          }
          else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 20, 10),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 224,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,
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
                              '1',
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
