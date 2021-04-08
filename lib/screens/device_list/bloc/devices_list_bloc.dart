import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as asd;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zefire/helpers/bluetooth_manager.dart';
import 'package:zefire/resources/strings.dart';

part 'devices_list_event.dart';

part 'devices_list_state.dart';

class DevicesListBloc extends Bloc<DevicesListEvent, DevicesListState> {
  DevicesListBloc() : super(DevicesListInitial());

  static List<BluetoothDevice> arrayOfResult = List();

  @override
  void onTransition(Transition<DevicesListEvent, DevicesListState> transition) {
    print("TRANS ${transition}");
    super.onTransition(transition);
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  Stream<DevicesListState> mapEventToState(event) async* {
    try {
      flutterBlue.startScan();

      if (event is DevicesDiscoveryEvent) {
        arrayOfResult.clear();
        arrayOfResult.addAll(await flutterBlue.connectedDevices);
        flutterBlue.scanResults.distinct().listen((event) {
          print("DEVICES ${event.toList()}");
          for (ScanResult r in event)
            add(UpdateDiscoveryListEvent(device: r.device));
        }).onDone(() {
          add(DevicesDiscoveryEvent());
        });
        // arrayOfResult
        //     .addAll(await FlutterBluetoothSerial.instance.getBondedDevices());
        // FlutterBluetoothSerial.instance
        //     .startDiscovery()
        //     .map((event) => event.device)
        //     .distinct()
        //     .listen((event) {
        //   add(UpdateDiscoveryListEvent(device: event));
        // }).onDone(() {
        //   add(DevicesDiscoveryEvent());
        // });
      }
      if (event is UpdateDiscoveryListEvent) {
        if (event.device.name != null) arrayOfResult.add(event.device);
        if (arrayOfResult.isNotEmpty)
          yield (DeviceListLoadedState(arrayOfResult: arrayOfResult));
        else
          yield (DeviceListEmptyState());
      }
    } catch (e) {
      yield (DeviceListFailureState(
          titleErrorText: Strings.errorTitle,
          descErrorText: Strings.unknownError));
    }

    @override
    Future<void> close() async {
      // await FlutterBluetoothSerial.instance.cancelDiscovery();
      return super.close();
    }
  }
}
