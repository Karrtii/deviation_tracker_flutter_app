import 'package:deviation_tracker_flutter_app/constants.dart';
import 'package:deviation_tracker_flutter_app/models/project_model.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/browse_commisioning.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/browse_installation.dart';
import 'package:deviation_tracker_flutter_app/screens/deviations/browse_loadout.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviationBrowseScreen extends StatefulWidget {
  const DeviationBrowseScreen({Key? key}) : super(key: key);

  @override
  State<DeviationBrowseScreen> createState() => _DeviationBrowseScreenState();
}

class _DeviationBrowseScreenState extends State<DeviationBrowseScreen> with TickerProviderStateMixin {

  String _projectName = "";
  String selectedItem = "ALbatros";

  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 3, vsync: this);

    return Consumer<ProjectViewModel>(
      builder: (context, viewmodel, child) {
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
                        labelPadding: const EdgeInsets.only(
                            left: 20, right: 20),
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[800],
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: CircleTabIndicator(color: Colors.blueAccent,
                            radius: 4),
                        tabs: [
                          Tab(text: 'Loadout'),
                          Tab(text: 'Installation'),
                          Tab(text: 'Commissioning'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: FutureBuilder(
                        future: viewmodel.getAllProjects(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (viewmodel.projects.length == 0) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                                //Text('No bookings exist'),
                              ),
                            );
                          }
                          else{
                            //selectedItem = viewmodel.projectNames[0];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 58,
                                    width: 130,
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      style: TextStyle(fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Project',
                                        labelStyle: TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(width: 1, color: primaryColor),
                                        ),
                                      ),
                                      value: selectedItem,
                                      items: viewmodel.projectNames.map((item) => DropdownMenuItem<String>(
                                       value: item,
                                       child: Text(item),
                                      )).toList(),
                                      onChanged: (item) => setState(() => selectedItem = (item) as String),
                                      // items: viewmodel.projects.map((ProjectModel project) {
                                      //   print(viewmodel.projects.length);
                                      //   return DropdownMenuItem(
                                      //     value: project,
                                      //     child: Text(project.projectName),
                                      //   );
                                      // }).toList(),
                                    ),
                                  ),
                                  new Spacer(),
                                  IconButton(
                                    iconSize: 35,
                                    color: primaryColor,
                                    icon: Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            );
                          }
                        }
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
                        BrowseLoadoutScreen(),
                        BrowseInstallationScreen(projectName: selectedItem,),
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