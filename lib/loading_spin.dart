import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

const spinkit = SpinKitWave	(
  color: Colors.orangeAccent,
  size: 100.0,
);

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: spinkit);
  }
}



