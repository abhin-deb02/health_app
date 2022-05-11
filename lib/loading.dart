import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent.withGreen(150).withBlue(150),
      child: const Center(
        child: SpinKitFadingCube(
          color: Colors.redAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
