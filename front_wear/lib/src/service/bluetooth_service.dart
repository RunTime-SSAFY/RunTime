import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BluetoothService extends StatefulWidget {
  const BluetoothService({super.key});

  @override
  _BluetoothServiceState createState() => _BluetoothServiceState();
}

class _BluetoothServiceState extends State<BluetoothService> {
  static const platform = MethodChannel('com.example.your_project/channel');

  String _response = '';

  Future<void> callKotlinCode() async {
    try {
      final String result = await platform
          .invokeMethod('yourMethodName', {"text": "Hello from Flutter!"});
      setState(() {
        _response = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _response = "Failed to Invoke: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform Channel Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_response),
            TextButton(
              onPressed: callKotlinCode,
              child: const Text('Call Kotlin Code'),
            ),
          ],
        ),
      ),
    );
  }
}
