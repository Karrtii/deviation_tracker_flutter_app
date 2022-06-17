import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/models/turbine_model.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/visits_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TurbinesListView extends StatefulWidget {
  const TurbinesListView({Key? key, required this.turbines}) : super(key: key);

  final List<TurbineModel> turbines;

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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    VisitsScreen(),
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
                          'Turbine ID',
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
                          'Total lead time',
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
                          'Total deviation time',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    new Spacer(),
                    IconButton(
                      icon: (_isFavourited ? Icon(Icons.star) : Icon(Icons.star_border)),
                      color: Colors.yellow,
                      onPressed: _toggleFavourite,
                    ),
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
