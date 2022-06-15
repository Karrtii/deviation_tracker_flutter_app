import 'package:deviation_tracker_flutter_app/screens/deviations/browse_commisioning.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/browse_installation.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/browse_loadout.dart';
import 'package:flutter/material.dart';

class DeviationBrowseScreen extends StatefulWidget {
  const DeviationBrowseScreen({Key? key}) : super(key: key);

  @override
  State<DeviationBrowseScreen> createState() => _DeviationBrowseScreenState();
}

class _DeviationBrowseScreenState extends State<DeviationBrowseScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 3, vsync: this);

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/sgrebg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Browse',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey[800],
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: CircleTabIndicator(color: Colors.blueAccent, radius: 4),
                    tabs: [
                      Tab(text: 'Loadout'),
                      Tab(text: 'Installation'),
                      Tab(text: 'Commissioning'),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                height: MediaQuery.of(context).size.height/1.4,
                width: double.maxFinite,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BrowseLoadoutScreen(),
                    BrowseInstallationScreen(),
                    BrowseCommisioningScreen(),
                  ],
                ),
              ),
            ],
          ),
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