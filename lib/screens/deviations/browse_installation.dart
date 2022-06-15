import 'package:deviation_tracker_flutter_app/shared/listviews/TurbinesListView.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/project_viewmodel.dart';
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
    return Consumer<ProjectViewModel>(
        builder: (context, viewmodel, child)
        {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
                child: FutureBuilder(
                    future: viewmodel.getAllBookings(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (viewmodel.projects.length == 0) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                            //Text('No bookings exist'),
                          ),
                        );
                      }
                      else{
                        return TurbinesListView(projects: viewmodel.projects);
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
