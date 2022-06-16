import 'package:deviation_tracker_flutter_app/shared/listviews/TurbinesListView.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/project_viewmodel.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/turbine_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowseInstallationScreen extends StatefulWidget {
  const BrowseInstallationScreen({Key? key}) : super(key: key);

  @override
  State<BrowseInstallationScreen> createState() => _BrowseInstallationScreenState();
}

class _BrowseInstallationScreenState extends State<BrowseInstallationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TurbineViewModel>(
        builder: (context, viewmodel, child)
        {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
                child: FutureBuilder(
                    future: viewmodel.getAllTurbines(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (viewmodel.turbines.length == 0) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                            //Text('No bookings exist'),
                          ),
                        );
                      }
                      else{
                        return TurbinesListView(turbines: viewmodel.turbines);
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
