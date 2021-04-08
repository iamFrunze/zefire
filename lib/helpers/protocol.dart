import 'dart:convert';

import 'package:zefire/helpers/bluetooth_manager.dart';
import 'package:zefire/screens/control_panel/models/bioburner.dart';

class Protocol {
  static int onOff = 0;
  static int status = 0;
  static int flameHeight = 1;
  static int fuelLvl = 0;
  static int request = 1;

  static int res6 = 0;

  String textSend;

  @override
  String toString() {
    return "onOff = $onOff \n"
        "status = $status \n"
        "flameHeight = $flameHeight \n"
        "FuelVolume - $fuelLvl \n"
        "request = $request";
  }

  //TODO test method
  static String checkDataReceived() {
    return "onOff = $onOff \n"
        "status = $status \n"
        "flameHeight = $flameHeight \n"
        "FuelVolume - $fuelLvl \n"
        "request = $request";
  }

  static BioburnerStatus getStatus() {
    switch (status) {
      case 1:
        {
          return BioburnerStatus.ready;
        }
      case 2:
        {
          return BioburnerStatus.warming;
        }
      case 3:
        {
          return BioburnerStatus.ignition;
        }
      case 4:
        {
          return BioburnerStatus.work;
        }
      case 5:
        {
          return BioburnerStatus.cooling;
        }
      case 6:
        {
          return BioburnerStatus.lidNotClosed;
        }
      case 7:
        {
          return BioburnerStatus.fuelSpill;
        }
      case 8:
        {
          return BioburnerStatus.fuelOverflow;
        }
    }
  }

  static Bioburner getBioburner() => Bioburner(
        BluetoothManager.currentDevice.name,
        flameHeight,
        fuelLvl,
        getStatus(),
        Protocol.onOff == 1 ? true : false,
      );

  static String sendMessage() {
    return ">"
        "$onOff"
        "$status"
        "$flameHeight"
        "${mapFuelLvl()}"
        "$request"
        "#";
  }

  static String mapFuelLvl() {
    switch (fuelLvl.toString().length) {
      case 2:
        {
          return fuelLvl.toString();
        }
      case 1:
        {
          return "0$fuelLvl";
        }
      default:
        {
          return "00";
        }
    }
  }

  /***** HEX Converter ****************/
  // void _setupProtocol(List<String> arrayOfBytes) {
  //   onOff = int.parse(arrayOfBytes[0], radix: 16);
  //   status = int.parse(arrayOfBytes[1], radix: 16);
  //   flameHeight = int.parse(arrayOfBytes[2], radix: 16);
  //   fuelLvl = int.parse(arrayOfBytes[3], radix: 16);
  //   request = int.parse(arrayOfBytes[4], radix: 16);
  //   res6 = int.parse(arrayOfBytes[5], radix: 16);
  // }

  static void mapByteToInt(String bytes) {
    onOff = int.parse(bytes[1]);
    status = int.parse(bytes[2]);
    flameHeight = int.parse(bytes[3]);
    fuelLvl = int.parse("${bytes[4]}${bytes[5]}");
    request = int.parse(bytes[6]);
  }
}
