import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/shared/listviews/favourite_installations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
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
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.favourites,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(
                      left: 20, right: 20),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CircleTabIndicator(color: Colors.blueAccent,
                      radius: 4),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.browseLoadouts),
                    Tab(text: AppLocalizations.of(context)!.browseInstallations),
                    Tab(text: AppLocalizations.of(context)!.browseCommissionings),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.6,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  FavouriteInstallations(color: Colors.blueAccent,),
                  FavouriteInstallations(color: Colors.pinkAccent,),
                  FavouriteInstallations(color: Colors.orangeAccent,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CircleTabIndicator extends Decoration
{
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter
{
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(configuration.size!.width/2 - radius/2, configuration.size!.height -10);
    canvas.drawCircle(offset+circleOffset, radius, _paint);
  }

}