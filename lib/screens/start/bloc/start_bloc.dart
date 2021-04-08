import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:meta/meta.dart';
import 'package:zefire/helpers/bluetooth_manager.dart';

import '../../../helpers/protocol.dart';

part 'start_event.dart';

part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc() : super(StartInitial());

  @override
  void onTransition(Transition<StartEvent, StartState> transition) {
    print("${transition.event}");
    super.onTransition(transition);
  }
  @override
  Stream<StartState> mapEventToState(
    StartEvent event,
  ) async* {
    switch (event.runtimeType) {
      case TestService:
        {
/*          print("SEND ${Protocol.sendMessage()}");
          BluetoothManager.onDataReceived(
              Uint8List.fromList("<444444#".codeUnits));
          print("SEND 2 ${Protocol.sendMessage()}");
          BluetoothManager.onDataReceived(
              Uint8List.fromList("<122000#".codeUnits));
          print("SEND 2 ${Protocol.sendMessage()}");
          print("STATUS ${Protocol.status} ${Protocol.getStatus()}");*/
          break;
        }
      case GetBondedDevices:
        {
          yield SearchForDevices();
          // final list = await FlutterBluetoothSerial.instance.getBondedDevices();
          // BluetoothDevice zefire = list.firstWhere(
          //     (element) => element.name.toLowerCase().trim().contains("zefire"),
          //     orElse: () => null);
          // if (zefire != null) {
          //   BluetoothManager.currentDevice = zefire;
          //   yield RouteToControlState();
          // } else
            yield RouteToSearchState();
          break;
        }
      default:
        {
          yield StartInitial();
          break;
        }
    }
  }
}
