val bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
val bluetoothAdapter: BluetoothAdapter? = bluetoothManager.getAdapter()
if (bluetoothAdapter == null) {
  // Device doesn't support Bluetooth
}
if (bluetoothAdapter?.isEnabled == false) {
  val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
  startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
}