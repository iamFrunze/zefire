import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as asd;
import 'package:meta/meta.dart';
import 'package:zefire/helpers/bluetooth_manager.dart';
import 'package:zefire/helpers/protocol.dart';

part 'connection_device_event.dart';

part 'connection_device_state.dart';

class ConnectionDeviceBloc
    extends Bloc<ConnectionDeviceEvent, ConnectionDeviceState> {
  ConnectionDeviceBloc() : super(ConnectionDeviceInitial());

  @override
  void onTransition(
      Transition<ConnectionDeviceEvent, ConnectionDeviceState> transition) {
    print("transition connection $transition");
    super.onTransition(transition);
  }

  @override
  Stream<ConnectionDeviceState> mapEventToState(
      ConnectionDeviceEvent event,) async* {
    if (event is GetConnectionEvent) {
      BluetoothDevice zefire = event.device;
      await zefire.connect();
      yield ConnectionDeviceInitial();
      try {
        zefire.state.listen((event) {
          print("STATE IS $event");
          if (event == BluetoothDeviceState.connected)
            emit(ConnectionSuccessState());
          else
            emit(ConnectionFailureState());
        });

      } catch (e) {
        print("error  ${e.toString()}");
        yield ConnectionFailureState();
      }
    }
  }
}
