import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FavouriteInstallations extends StatefulWidget {
  const FavouriteInstallations({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  State<FavouriteInstallations> createState() => _FavouriteInstallationsState();
}

class _FavouriteInstallationsState extends State<FavouriteInstallations> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        if (6 == 0) {
          return Container(
            child: Center(
              child: Text(
                'No favourites to show',
              ),
            ),
          );
        }
        else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.color,
                // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                //     .withOpacity(1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                    child: Center(
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        radius: 80,
                        lineWidth: 10,
                        percent: 0.4,
                        progressColor: Colors.white,
                        backgroundColor: Colors.purple.shade100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          '40%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A01',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3,),
                        Text(
                          'Beatrice',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
