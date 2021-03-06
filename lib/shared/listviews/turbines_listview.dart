import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/visits_screen.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/turbine_viewmodel.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/visit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TurbinesListView extends StatefulWidget {
  const TurbinesListView({Key? key, required this.turbines, required this.viewmodel}) : super(key: key);

  final List<TurbineModel> turbines;
  final TurbineViewModel viewmodel;

  @override
  State<TurbinesListView> createState() => _TurbinesListViewState();
}

class _TurbinesListViewState extends State<TurbinesListView> {

  bool _isFavourited = false;
  int _favouriteCount = 0;

  void _toggleFavourite()
  {
    setState(() {
      if(_isFavourited)
        {
          _favouriteCount -= 1;
          _isFavourited = false;
        }
      else
        {
          _favouriteCount += 1;
          _isFavourited = true;
        }
    });
  }

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
            onTap: () async {
              print(widget.turbines[index].turbineId,);

              widget.viewmodel.addView(widget.turbines[index].turbineId);

              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    VisitsScreen(turbine: widget.turbines[index],),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset("assets/icons/turbinebrowse.svg"),
                      onPressed: () {  },
                    ),
                    Column(
                      children: [
                        Text(
                          widget.turbines[index].turbineId,
                          style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          AppLocalizations.of(context)!.browseTurbineId,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                      child: VerticalDivider(
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '12:00',
                          style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          AppLocalizations.of(context)!.browseTotalLeadTime,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                      child: VerticalDivider(
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '19:30',
                          style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          AppLocalizations.of(context)!.browseTotalDeviationTime,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    new Spacer(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
