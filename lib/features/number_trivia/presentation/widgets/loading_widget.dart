import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double screenHeight;
  LoadingWidget({this.screenHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
