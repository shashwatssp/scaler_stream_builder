import 'dart:async';
import 'package:flutter/material.dart';

class HandlingDifferentStates extends StatefulWidget {
  final Stream<int> dataStream;

  HandlingDifferentStates({required this.dataStream});

  @override
  _HandlingDifferentStatesState createState() =>
      _HandlingDifferentStatesState();
}

class _HandlingDifferentStatesState extends State<HandlingDifferentStates> {
  int data = 0;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    widget.dataStream.listen(
      (int newData) {
        setState(() {
          data = newData;
          if (data == 5) {
            errorMessage = 'Data reached 5!';
          } else {
            errorMessage = '';
          }
        });
      },
      onError: (dynamic error) {
        setState(() {
          errorMessage = error.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Handling Different States'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorMessage.isNotEmpty)
              Text(
                'Error: $errorMessage',
                style: TextStyle(fontSize: 20),
              )
            else
              Text(
                'Data is available: $data',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
