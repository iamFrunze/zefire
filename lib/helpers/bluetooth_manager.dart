import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as asd;
import 'package:throttling/throttling.dart';
import 'package:zefire/helpers/protocol.dart';

class BluetoothManager {
  static BluetoothState bluetoothState = BluetoothState.off;

  static BluetoothDevice currentDevice = null;

  static List<String> arrayOfMessage = List<String>();
  static Throttling _thr = new Throttling(duration: Duration(milliseconds: 500));

  List<BluetoothDevice> arrayOfDiscoveryResult = List<BluetoothDevice>();

  static BluetoothDevice server = null;

  // Future<BluetoothState> setBluetoothState() =>
  //     FlutterBluetoothSerial.instance.state
  //         .then((state) => bluetoothState = state);
  //
  // Stream<BluetoothState> bluetoothStateChangeListener() =>
  //     FlutterBluetoothSerial.instance.onStateChanged();

  // Stream<List<BluetoothDevice>> getDevices() async* {
  //   var listOfDevices = List<BluetoothDevice>();
  //   final listOfBond = await FlutterBluetoothSerial.instance.getBondedDevices();
  //   listOfDevices.addAll(listOfBond);
  //   FlutterBluetoothSerial.instance
  //       .startDiscovery()
  //       .map((event) => event.device)
  //       .distinct()
  //       .listen((device) {
  //     listOfDevices.add(device);
  //   });
  //   yield listOfDevices;
  // }

  static void sendMessage(String text, connection) async {
    // _thr.throttle(()async{
    arrayOfMessage.add(text);
    text = text.trim();
    if (text.length > 0) {
      try {
        //send data
        connection.output.add(utf8.encode(text));
        await connection.output.allSent;
      } catch (e) {
        print("ERROR SEND ${e.toString()}");
        arrayOfMessage.add("Error send message is ${e.toString()}");
      }
    }
    // });
  }

  static String tempBufferString = "";

  static void onDataReceived(Uint8List data) {
    String result = utf8.decode(data);
    print("RESULT $result");
    tempBufferString = tempBufferString + result;

    if (result.contains("#")) {
      Protocol.mapByteToInt(tempBufferString);
      tempBufferString = "";
      arrayOfMessage.add(Protocol.checkDataReceived());
    }
  }
}
