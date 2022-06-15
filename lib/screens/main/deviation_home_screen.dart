import 'package:flutter/material.dart';

class DeviationHomeScreen extends StatefulWidget {
  const DeviationHomeScreen({Key? key}) : super(key: key);

  @override
  State<DeviationHomeScreen> createState() => _DeviationHomeScreenState();
}

class _DeviationHomeScreenState extends State<DeviationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Text('Deviations')));
  }
}
