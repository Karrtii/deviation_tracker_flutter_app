import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/data/advanced_tiles.dart';
import 'package:deviation_tracker_flutter_app/models/advanced_tile.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/date_listview.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/visits_listview.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/visit_viewmodel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../utils.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({Key? key, required this.turbine}) : super(key: key);

  final String turbine;

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
              title: Center(
                child: Text(
                  'Visits',
                  style: TextStyle(
                    color: Colors.black,
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
                Container(
                  width: double.infinity,
                  height: 75,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: DateListView(uniqueVisitStartDates: viewmodel.uniqueVisitStartDates),
                  ),
                ),
                FlipCard(
                  front: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                      child: Text("Front"),
                    ),
                  ),
                  back: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                      child: Text("Back"),
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: viewmodel.getAllVisitsByTurbineId(widget.turbine),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (viewmodel.visitsByTurbineId.length == 0) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                              //Text('No bookings exist'),
                            ),
                          );
                        }
                        else{
                          return VisitsListView(visits: viewmodel.visitsByTurbineId);
                        }
                      }
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: primaryColor,
              onPressed: () => addVisitDialog(context),
            ),
          );
        }
    );
  }

  void addVisitDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Add a visit'),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select a start date'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            DateFormat("dd MMMM, yyyy").format(startDate),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select an end date'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            DateFormat("dd MMMM, yyyy").format(endDate),
                          ),
                        ),
                      ),
                    ),
                  ],
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
