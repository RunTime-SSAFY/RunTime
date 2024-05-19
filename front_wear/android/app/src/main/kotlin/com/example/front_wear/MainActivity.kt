package com.example.front_wear

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    // private val CHANNEL = "com.example.your_project/channel"

    //     private lateinit var bluetoothManager: BluetoothManager
    // private lateinit var bluetoothAdapter: BluetoothAdapter

    // override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    //     super.configureFlutterEngine(flutterEngine)

    //     bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
    //     bluetoothAdapter = bluetoothManager.adapter

    //     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
    //         call, result ->
    //         if (call.method == bluetoothManager) {
    //             val text = call.argument<String>("text")
    //             val modifiedText = yourMethod(text!!)
    //             result.success(modifiedText)
    //         } else {
    //             result.notImplemented()
    //         }
    //     }
    // }

    // fun yourMethod(text: String): String {

    //   if (!bluetoothAdapter.isEnabled) {
    //         return "Bluetooth is not enabled."
    //     }
        
    //     return "From Kotlin: $text with Bluetooth enabled"
    // }
}