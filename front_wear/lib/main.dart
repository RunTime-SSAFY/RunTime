import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// void main() async {
//   runApp(const ProviderScope(child: MyApp()));
// }

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          //child: BluetoothCheckWidget(),
          child: GrantPermissionsButton(
            onPermissionGranted: () {
              Navigator.push(
                //네비게이션을 사용하여 화면 전환
                context,
                MaterialPageRoute(
                  builder: (context) => const BluetoothDevicesScreen(),
                ),
              );
              // 권한이 모두 허용되었을 때 실행할 로직
              //print("All permissions granted.");
              //BluetoothDeviceScreen(),
            },
          ),
        ),
      ),
    );
  }
}

class BluetoothDevicesScreen extends StatefulWidget {
  const BluetoothDevicesScreen({super.key});

  @override
  _BluetoothDevicesScreenState createState() => _BluetoothDevicesScreenState();
}

class _BluetoothDevicesScreenState extends State<BluetoothDevicesScreen> {
  final List<ScanResult> devicesList = [];

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    FlutterBluePlus.scanResults.listen((results) {
      print(results);
      for (ScanResult result in results) {
        if (!devicesList.any(
            (element) => element.device.remoteId == result.device.remoteId)) {
          setState(() {
            devicesList.add(result);
          });
        }
      }
    });

    FlutterBluePlus.isScanning.listen((isScanning) {
      if (!isScanning) {
        // 스캔이 완료되면 추가 로직 구현 가능
      }
    });
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devicesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(devicesList[index].device.advName ?? 'Unknown Device'),
          subtitle: Text(devicesList[index].device.remoteId.toString()),
          onTap: () {
            // 탭하면 할 행동 추가
          },
        );
      },
    );
  }
}

class GrantPermissionsButton extends StatelessWidget {
  final VoidCallback onPermissionGranted;

  const GrantPermissionsButton({super.key, required this.onPermissionGranted});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (newContext) => ElevatedButton(
        onPressed: () async {
          await requestPermissions();
          onPermissionGranted();
          Navigator.push(
            //'newContext'를 사용
            newContext,
            MaterialPageRoute(
                builder: (context) => const BluetoothDevicesScreen()),
          );
        },
        child: const Text("Grant Permissions"),
      ),
    );
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.location,
    ].request();

    // 모든 권한이 허용되었는지 확인
    final allGranted = statuses.values.every((status) => status.isGranted);
    if (allGranted) {
      onPermissionGranted();
    } else {
      // TODO: 권한 거부 처리 로직
      print("Permissions were denied.");
    }
  }
}

// class BluetoothCheckWidget extends StatelessWidget {
//   const BluetoothCheckWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: FlutterBluePlus.instance.isAvailable, // Bluetooth 가용성 확인
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator(); // 로딩 인디케이터
//         }
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         return Text(
//             'Bluetooth is ${snapshot.data! ? 'available' : 'not available'}');
//       },
//     );
//   }
// }
