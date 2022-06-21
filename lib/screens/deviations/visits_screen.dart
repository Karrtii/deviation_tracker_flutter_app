import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/data/advanced_tiles.dart';
import 'package:deviation_tracker_flutter_app/models/advanced_tile.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/shared/cards/visits_chart_back_card.dart';
import 'package:deviation_tracker_flutter_app/shared/cards/visits_chart_front_card.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/date_listview.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/visits_listview.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/visit_viewmodel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({Key? key, required this.turbine}) : super(key: key);

  final TurbineModel turbine;

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitViewModel>(
        builder: (context, viewmodel,  child) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.grey[400],
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 22),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.visits,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
            FutureBuilder(
            future: viewmodel.getAllVisitsByTurbineId(widget.turbine.turbineId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (viewmodel.visitsByTurbineId.length == 0) {
                  return Container();
                }
                else {
                  return Container(
                    width: double.infinity,
                    height: 75,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: DateListView(uniqueVisitStartDates: viewmodel
                          .uniqueVisitStartDates),
                    ),
                  );
              }
              }
            ),
                FutureBuilder(
                  future: viewmodel.getAllVisitsByTurbineId(widget.turbine.turbineId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (viewmodel.visitsByTurbineId.length == 0) {
                      return Container();
                    }
                    else {
                      return FlipCard(
                        front: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: VisitsChartFrontCard(turbine: widget.turbine),
                        ),
                        back: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: VisitsChartBackCard(turbine: widget.turbine),
                        ),
                      );
                    }
                  }
                    ),
                Container(
                  child: FutureBuilder(
                      future: viewmodel.getAllVisitsByTurbineId(widget.turbine.turbineId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {

                        // viewmodel.addView(widget.turbine.turbineId).then((value) => {});

                        if (viewmodel.visitsByTurbineId.length == 0) {
                          return Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height/ 1.4,
                            width: double.maxFinite,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/iconempty.svg",
                                      color: primaryColor,
                                    ),
                                    iconSize: 200,
                                    onPressed: () {  },
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.visitNothingAddedYet,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                              //Text('No bookings exist'),
                            ),
                          );
                        }
                        else{
                          return Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 3,
                              width: double.maxFinite,
                            child: VisitsListView(visits: viewmodel.visitsByTurbineId)
                          );
                        }
                      }
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: primaryColor,
              onPressed: () => addVisitDialog(context, viewmodel),
            ),
          );
        }
    );
  }





  void addVisitDialog(BuildContext context, viewmodel) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(AppLocalizations.of(context)!.addVisit),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10 , 5, 10, 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.addVisitSelectAStartDate,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? newStartDate = await showDatePicker(
                                context: context,
                                initialDate: startDate,
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2023),
                              );

                              if(newStartDate == null) return;

                              setState(() {
                                startDate = newStartDate;

                              });
                              print(startDate);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat(
                                        "dd MMMM, yyyy").format(startDate),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/calendericon.svg",
                                    color: primaryColor,
                                  ),
                                  onPressed: () async {
                                    DateTime? newStartDate = await showDatePicker(
                                      context: context,
                                      initialDate: startDate,
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2023),
                                    );

                                    if(newStartDate == null) return;

                                    setState(() {
                                      startDate = newStartDate;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          AppLocalizations.of(context)!.addVisitSelectAStartTime,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? newStartTime = await showTimePicker(
                                context: context,
                                initialTime: startTime,
                              );

                              if(newStartTime == null) return;

                              setState(() {
                                startTime = newStartTime;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/icontime.svg",
                                    color: primaryColor,
                                  ),
                                  onPressed: () async {
                                    TimeOfDay? newStartTime = await showTimePicker(
                                      context: context,
                                      initialTime: startTime,
                                    );

                                    if(newStartTime == null) return;

                                    setState(() {
                                      startTime = newStartTime;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.addVisitSelectAnEndDate,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 15),
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? newEndDate = await showDatePicker(
                                context: context,
                                initialDate: endDate,
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2023),
                              );

                              if(newEndDate == null) return;

                              setState(() {
                                endDate = newEndDate;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat("dd MMMM, yyyy").format(endDate),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   icon: SvgPicture.asset(
                                //     "assets/icons/calendericon.svg",
                                //     color: primaryColor,
                                //   ),
                                //   onPressed: () async {
                                //     DateTime? newEndDate = await showDatePicker(
                                //       context: context,
                                //       initialDate: endDate,
                                //       firstDate: DateTime(2021),
                                //       lastDate: DateTime(2023),
                                //     );
                                //
                                //     if(newEndDate == null) return;
                                //
                                //     setState(() {
                                //       endDate = newEndDate;
                                //       print(endDate);
                                //     });
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          AppLocalizations.of(context)!.addVisitSelectAnEndTime,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? newEndTime = await showTimePicker(
                                context: context,
                                initialTime: endTime,
                              );

                              if(newEndTime == null) return;

                              setState(() {
                                endTime = newEndTime;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   icon: SvgPicture.asset(
                                //     "assets/icons/icontime.svg",
                                //     color: primaryColor,
                                //   ),
                                //   onPressed: () async {
                                //     TimeOfDay? newEndTime = await showTimePicker(
                                //       context: context,
                                //       initialTime: endTime,
                                //     );
                                //
                                //     if(newEndTime == null) return;
                                //
                                //     setState(() {
                                //       endTime = newEndTime;
                                //       print(endTime);
                                //     });
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: () async {
                          print(startDate);
                          print(startTime);

                          await viewmodel.addVisit("${startDate.year}-${startDate.month < 10 ? "0"+startDate.month.toString() : startDate.month}-${startDate.day< 10 ? "0"+startDate.day.toString() : startDate.day}",
                              "${endDate.year}-${endDate.month < 10 ? "0"+endDate.month.toString() : endDate.month}-${endDate.day< 10 ? "0"+endDate.day.toString() : endDate.day}",
                              "${startTime.hour < 10 ? "0"+startTime.hour.toString() : startTime.hour}:${startTime.minute < 10 ? "0"+startTime.minute.toString() : startTime.minute}:00",
                              "${endTime.hour < 10 ? "0"+endTime.hour.toString() : endTime.hour}:${endTime.minute < 10 ? "0"+endTime.minute.toString() : endTime.minute}:00",
                              widget.turbine);

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                VisitsScreen(turbine: widget.turbine),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        child: Text(
                            'Add'
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         Text('Select a start date'),
          //         Text('Select an end date'),
          //       ],
          //     ),
          //     SizedBox(height: 8,),
          //     Row(
          //       children: [
          //         GestureDetector(
          //           onTap: () async {
          //             DateTime? newStartDate = await showDatePicker(
          //               context: context,
          //               initialDate: startDate,
          //               firstDate: DateTime(2021),
          //               lastDate: DateTime(2023),
          //             );
          //
          //             if(newStartDate == null) return;
          //
          //             setState(() {
          //               startDate = newStartDate;
          //             });
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.black),
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: Text(
          //             DateFormat("dd MMMM, yyyy").format(startDate),
          //             ),
          //           ),
          //         ),
          //         GestureDetector(
          //           onTap: () async {
          //             DateTime? newEndDate = await showDatePicker(
          //               context: context,
          //               initialDate: endDate,
          //               firstDate: DateTime(2021),
          //               lastDate: DateTime(2023),
          //             );
          //
          //             if(newEndDate == null) return;
          //
          //             setState(() {
          //               endDate = newEndDate;
          //             });
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.black),
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: Text(
          //               DateFormat("dd MMMM, yyyy").format(endDate),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      );
    }
  );
}
