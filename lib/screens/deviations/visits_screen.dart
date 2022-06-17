import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/data/advanced_tiles.dart';
import 'package:deviation_tracker_flutter_app/models/advanced_tile.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/date_listview.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/visits_listview.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/visit_viewmodel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({Key? key}) : super(key: key);

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
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
                      future: viewmodel.getAllVisits(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (viewmodel.visits.length == 0) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                              //Text('No bookings exist'),
                            ),
                          );
                        }
                        else{
                          return VisitsListView(visits: viewmodel.visits);
                        }
                      }
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
