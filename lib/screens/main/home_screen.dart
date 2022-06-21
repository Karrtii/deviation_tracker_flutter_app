import 'package:deviation_tracker_flutter_app/shared/listviews/recent_commissionings_listview.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/recent_installations_listview.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/recent_loadouts_listview.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/turbine_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TurbineViewModel>(
        builder: (context, viewmodel, child)
    {
      return Scaffold(
        backgroundColor: backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: backgroundColor,
        //   elevation: 0,
        //   title: Text(
        //     'Deviation Tracker',
        //     style: TextStyle(
        //       color: primaryColor,
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
        //       child: Container(
        //         margin: const EdgeInsets.only(right: 20),
        //         width: 50,
        //         height: 50,
        //         child: CircleAvatar(
        //           backgroundImage: AssetImage('assets/images/profile_pic.png'),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    new Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/profile_pic.png'),
                      ),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)!.homeRecentlyViewed,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  AppLocalizations.of(context)!.homeInstallations,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                FutureBuilder(
                  future: viewmodel.getAllRecentlyViewed(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (viewmodel.recentlyViewed.length == 0) {
                      return  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(
                                "assets/icons/iconempty.svg",
                                color: primaryColor,
                              ),
                              iconSize: 100,
                              onPressed: () {  },
                            ),
                            Text(
                              AppLocalizations.of(context)!.visitNothingAddedYet,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    else {
                      return SizedBox(
                        height: 225,
                        child: RecentInstallationsListView(
                            recentlyViewedModel: viewmodel.recentlyViewed,
                            viewmodel: viewmodel,
                        ),
                      );
                    }
                  }
                ),
                SizedBox(height: 30,),
                Text(
                  AppLocalizations.of(context)!.homeLoadouts,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 225,
                  child: RecentLoadoutsListView(),
                ),
                SizedBox(height: 30,),
                Text(
                  AppLocalizations.of(context)!.homeCommissionings,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 225,
                  child: RecentCommissioningsListView(),
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
