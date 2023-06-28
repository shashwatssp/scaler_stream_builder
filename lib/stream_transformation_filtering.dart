import 'dart:async';
import 'package:flutter/material.dart';

class StreamTransformationFiltering extends StatelessWidget {
  final Stream<int> dataStream;
  final Stream<int> filteredStream;

  StreamTransformationFiltering(
      {required this.dataStream, required this.filteredStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Transformation and Filtering'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: dataStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Original Data: ${snapshot.data}',
                    style: TextStyle(fontSize: 20),
                  );
                } else {
                  return Text('No data');
                }
              },
            ),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: filteredStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Filtered Data: ${snapshot.data}',
                    style: TextStyle(fontSize: 20),
                  );
                } else {
                  return Text('No data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
