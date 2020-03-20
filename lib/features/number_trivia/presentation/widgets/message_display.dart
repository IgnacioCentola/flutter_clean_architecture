import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final double screenHeight;
  const MessageDisplay({
    Key key,
    @required this.screenHeight,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
