import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scaler_streambuilder/basic_usage.dart';
import 'package:scaler_streambuilder/stream_transformation_filtering.dart';
import 'package:scaler_streambuilder/handling_different_states.dart';
import 'package:scaler_streambuilder/error_handling.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool showError = false;
  Stream<int> altDataStream() {
    final StreamController<int> controller = StreamController<int>();

    int counter = 0;
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      counter++;
      controller.add(counter);

      if (counter == 5) {
        controller.close();
        timer.cancel();
        setState(() {
          showError = true;
        });
      }
    });

    return controller.stream;
  }

  Stream<int> createDataStream() {
    final StreamController<int> controller = StreamController<int>();

    int counter = 0;
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      counter++;
      controller.add(counter);
      if (counter == 5) {
        controller.close();
        timer.cancel();
      }
    });

    return controller.stream;
  }

  Stream<int> createFilteredStream() {
    final StreamController<int> controller = StreamController<int>();

    List<int> dataList = [1, 2, 3, 4, 5];
    for (int data in dataList) {
      if (data % 2 == 0) {
        controller.add(data);
      }
    }

    controller.close();
    return controller.stream;
  }

  Stream<String> createErrorStream() {
    final StreamController<String> controller = StreamController<String>();
    Timer(const Duration(seconds: 1), () {
      controller.addError('Oops! An error occurred.');
    });

    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Example App',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
        ),
      ),
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return BasicUsage(dataStream: createDataStream());
                    }),
                  );
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Basic Usage',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HandlingDifferentStates(
                        dataStream: altDataStream(),
                      );
                    }),
                  );
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Handling Different States',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return StreamTransformationFiltering(
                          dataStream: createDataStream(),
                          filteredStream: createFilteredStream());
                    }),
                  );
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Stream Transformation and Filtering',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ErrorHandling(errorStream: createErrorStream());
                    }),
                  );
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Error Handling',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
