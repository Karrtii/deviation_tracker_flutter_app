import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateListView extends StatefulWidget {
  const DateListView({Key? key, required this.uniqueVisitStartDates}) : super(key: key);

  final List<String> uniqueVisitStartDates;

  @override
  State<DateListView> createState() => _DateListViewState();
}

class _DateListViewState extends State<DateListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.uniqueVisitStartDates.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Column(
                  children: [
                    Text(widget.uniqueVisitStartDates == 0 ? "" : DateFormat("E").format(DateTime.parse(widget.uniqueVisitStartDates[index]))),
                    Card(
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            widget.uniqueVisitStartDates == 0 ? "" : DateFormat("dd").format(DateTime.parse(widget.uniqueVisitStartDates[index]))
                        ),
                      ),
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
