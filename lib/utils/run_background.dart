import 'dart:isolate';

class RunBackground {
  final ReceivePort _port = ReceivePort();

  void startBackgroundTask() async {
    await Isolate.spawn(backgroundTask, _port.sendPort);
    _port.listen((message) {
      // Handle background task completion
      print('Background task completed: $message');
    });
  }

  static void backgroundTask(SendPort sendPort) {
    // Perform time-consuming operation here
    // ...

    // Send result back to the main UI isolate
    sendPort.send('Task completed successfully!');
  }


}