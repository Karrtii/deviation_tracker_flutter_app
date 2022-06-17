import 'package:deviation_tracker_flutter_app/data/advanced_tiles.dart';
import 'package:deviation_tracker_flutter_app/models/advanced_tile.dart';
import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/visits_listview.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/visit_viewmodel.dart';
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
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
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
            ),
          );
        }
    );
  }
}
