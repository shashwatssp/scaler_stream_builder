import 'dart:async';
import 'package:flutter/material.dart';

class ErrorHandling extends StatefulWidget {
  final Stream<String> errorStream;

  ErrorHandling({required this.errorStream});

  @override
  _ErrorHandlingState createState() => _ErrorHandlingState();
}

class _ErrorHandlingState extends State<ErrorHandling> {
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    widget.errorStream.listen(
      (String data) {},
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
        title: Text('Error Handling'),
      ),
      body: Center(
        child: Text(
          errorMessage.isNotEmpty ? 'Error: $errorMessage' : 'No errors',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
