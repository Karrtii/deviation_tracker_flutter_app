import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/deviation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import 'deviations_screen.dart';

class AddDeviationScreen extends StatefulWidget {
  const AddDeviationScreen({Key? key, required this.visit}) : super(key: key);

  final VisitModel visit;

  @override
  State<AddDeviationScreen> createState() => _AddDeviationScreenState();
}

class _AddDeviationScreenState extends State<AddDeviationScreen> {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  String problem = "";
  String solution = "";

  bool approved = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviationViewModel>(
        builder: (context, viewmodel,  child)
    {
      return Scaffold(
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
            padding: const EdgeInsets.only(right: 40),
            child: Center(
              child: Text(
                'Add deviation',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 70,),
                    Text(
                      'Start date',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 45,),
                    Text(
                      'End date',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/calendericon.svg",
                        color: primaryColor,
                      ),
                      iconSize: 50,
                      onPressed: () {},
                    ),
                    GestureDetector(
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
                      child: Container(
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
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
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
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat("dd MMMM, yyyy").format(endDate),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    SizedBox(width: 70,),
                    Text(
                      'Start time',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 45,),
                    Text(
                      'End time',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/icontime.svg",
                        color: primaryColor,
                      ),
                      iconSize: 50,
                      onPressed: () {},
                    ),
                    GestureDetector(
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
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 68,),
                    GestureDetector(
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
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 100,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Problem",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (problemText) {
                      setState(() {
                        problem = problemText;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 100,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Solution",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (solutionText) {
                      setState(() {
                        solution = solutionText;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // print(startDate);
                        // print(startTime);
                        //
                        await viewmodel.addVisit("${startDate.year}-${startDate.month < 10 ? "0"+startDate.month.toString() : startDate.month}-${startDate.day< 10 ? "0"+startDate.day.toString() : startDate.day}",
                            "${endDate.year}-${endDate.month < 10 ? "0"+endDate.month.toString() : endDate.month}-${endDate.day< 10 ? "0"+endDate.day.toString() : endDate.day}",
                            "${startTime.hour < 10 ? "0"+startTime.hour.toString() : startTime.hour}:${startTime.minute < 10 ? "0"+startTime.minute.toString() : startTime.minute}:00",
                            "${endTime.hour < 10 ? "0"+endTime.hour.toString() : endTime.hour}:${endTime.minute < 10 ? "0"+endTime.minute.toString() : endTime.minute}:00",
                            problem,solution, approved,
                            widget.visit).then((value) =>
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  DeviationsScreen(visit: widget.visit,),
                            )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: Text(
                          'Finish',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
