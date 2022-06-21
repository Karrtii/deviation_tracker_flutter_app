import 'package:deviation_tracker_flutter_app/models/deviation_model.dart';
import 'package:deviation_tracker_flutter_app/shared/cards/deviation_back_card.dart';
import 'package:deviation_tracker_flutter_app/shared/cards/deviations_front_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class DeviationsListView extends StatefulWidget {
  const DeviationsListView({Key? key, required this.deviations}) : super(key: key);

  final List<DeviationModel> deviations;

  @override
  State<DeviationsListView> createState() => _DeviationsListViewState();
}

class _DeviationsListViewState extends State<DeviationsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.deviations.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 10, color: Colors.transparent,),
      itemBuilder: (context, index) {
        if (widget.deviations.length == 0) {
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
              child: FlipCard(
                direction: FlipDirection.VERTICAL,
                front: DeviationsFrontCard(
                    deviation: widget.deviations[index],
                ),
                back: DeviationsBackCard(deviation: widget.deviations[index],),
              )
          );
        }
      },
    );
  }
}
