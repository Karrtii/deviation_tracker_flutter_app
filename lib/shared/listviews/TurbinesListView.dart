import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:flutter/material.dart';

class TurbinesListView extends StatefulWidget {
  const TurbinesListView({Key? key, required this.turbines}) : super(key: key);

  final List<TurbineModel> turbines;

  @override
  State<TurbinesListView> createState() => _TurbinesListViewState();
}

class _TurbinesListViewState extends State<TurbinesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.turbines.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 10, color: Colors.transparent,),
      itemBuilder: (context, index) {
        if (widget.turbines.length == 0) {
          return Container(
            child: Center(
              child: Text('Empty'),
            ),
          );
        }
        else {
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Text(widget.turbines[index].turbineId),
                  Text(widget.turbines[index].project!.projectId),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
