import 'package:deviation_tracker_flutter_app/models/visit_model.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/add_deviation_screen.dart';
import 'package:deviation_tracker_flutter_app/shared/cards/deviations_chart_front_card.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/deviations_listview.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/deviation_viewmodel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants.dart';

class DeviationsScreen extends StatefulWidget {
  const DeviationsScreen({Key? key, required this.visit}) : super(key: key);

  final VisitModel visit;

  @override
  State<DeviationsScreen> createState() => _DeviationsScreenState();
}

class _DeviationsScreenState extends State<DeviationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DeviationViewModel>(
        builder: (context, viewmodel,  child)
    {
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
          title: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.deviations,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: viewmodel.getAllDeviationsByVisitId(widget.visit.visitId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (viewmodel.deviations.length == 0) {
                    return Container();
                  }
                  else {
                    return FlipCard(
                      front: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: DeviationsChartFrontCard(),
                      ),
                      back: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: DeviationsChartFrontCard(),
                      ),
                    );
                  }
                }
            ),
            Container(
              child: FutureBuilder(
                  future: viewmodel.getAllDeviationsByVisitId(widget.visit.visitId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {

                    // viewmodel.addView(widget.turbine.turbineId).then((value) => {});

                    if (viewmodel.deviations.length == 0) {
                      return Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height/ 1.4,
                        width: double.maxFinite,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/iconempty.svg",
                                  color: primaryColor,
                                ),
                                iconSize: 200,
                                onPressed: () {  },
                              ),
                              Text(
                                AppLocalizations.of(context)!.deviationsNoDeviationsHaveBeenAddedYet,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          //Text('No bookings exist'),
                        ),
                      );
                    }
                    else{
                      return Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: double.maxFinite,
                          child: DeviationsListView(deviations: viewmodel.deviations)
                      );
                    }
                  }
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  AddDeviationScreen(visit: widget.visit),
            ));
          },
        ),
      );
    }
    );
  }
}
