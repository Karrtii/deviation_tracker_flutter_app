import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:flutter/material.dart';

class TurbinesListView extends StatefulWidget {
  const TurbinesListView({Key? key, required this.projects}) : super(key: key);

  final List<ProjectModel> projects;

  @override
  State<TurbinesListView> createState() => _TurbinesListViewState();
}

class _TurbinesListViewState extends State<TurbinesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.projects.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 10, color: Colors.transparent,),
      itemBuilder: (context, index) {
        if (widget.projects.length == 0) {
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
                  Text(widget.projects[index].projectId),
                  Text(widget.projects[index].projectName),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
