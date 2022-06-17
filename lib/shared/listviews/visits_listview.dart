import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitsListView extends StatefulWidget {
  const VisitsListView({Key? key, required this.visits}) : super(key: key);

  final List<VisitModel> visits;

  @override
  State<VisitsListView> createState() => _VisitsListViewState();
}

class _VisitsListViewState extends State<VisitsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.visits.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 10, color: Colors.transparent,),
      itemBuilder: (context, index) {
        if (widget.visits.length == 0) {
          return Container(
            child: Center(
              child: Text('Empty'),
            ),
          );
        }
        else {
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) =>
              //       VisitsScreen(),
              // ));
            },
            child: Container(
              child: Row(
                children: [
                  Text(widget.visits == 0 ? "" : DateFormat("dd MMMM, yyyy,").format(DateTime.parse(widget.visits[index].activityStartDate))),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
