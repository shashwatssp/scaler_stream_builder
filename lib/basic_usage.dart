import 'package:flutter/material.dart';

class BasicUsage extends StatefulWidget {
  final Stream<int> dataStream;

  const BasicUsage({required this.dataStream});

  @override
  _BasicUsageState createState() => _BasicUsageState();
}

class _BasicUsageState extends State<BasicUsage> {
  late Stream<int> _updatedDataStream;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _updatedDataStream = widget.dataStream.map((data) => data);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _updatedDataStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          // Render UI based on the state of the stream
          return Scaffold(
            appBar: AppBar(
              title: const Text('Stream Data'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${snapshot.data}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Perform an action based on the stream data
                      // For example, update the stream with new data
                      if (snapshot.data! < 0) {
                        // Show error message if data is negative
                        setState(() {
                          errorMessage = 'Data has gone negative!';
                        });
                      } else {
                        // Update the stream with new data
                        setState(() {
                          _updatedDataStream =
                              Stream<int>.value(snapshot.data! - 4);
                          errorMessage = ''; // Clear error message
                        });
                      }
                    },
                    child: const Text('Update Data'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error case
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        } else {
          // Show a loading or waiting state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
