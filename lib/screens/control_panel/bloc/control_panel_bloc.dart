import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as asdf;
import 'package:throttling/throttling.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zefire/helpers/bluetooth_manager.dart';
import 'package:zefire/helpers/protocol.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/screens/control_panel/models/bioburner.dart';

part 'control_panel_event.dart';

part 'control_panel_state.dart';

class ControlPanelBloc extends Bloc<ControlPanelEvent, ControlPanelState> {
  ControlPanelBloc() : super(ControlPanelLoadState());

  // BluetoothConnection connection;
  //
  BluetoothDevice zefire = BluetoothManager.currentDevice;

  Throttling _thr = Throttling(duration: Duration(seconds: 2));

  @override
  void onTransition(
      Transition<ControlPanelEvent, ControlPanelState> transition) {
    print("Trans ${transition}");
    super.onTransition(transition);
  }

  @override
  Stream<ControlPanelState> mapEventToState(ControlPanelEvent event) async* {
    if (event is UpdateDataEvent) {
      yield ControlPanelConnected(Protocol.getBioburner());
    }
    if (event is ControlPanelConnectionRequested) {
      yield ControlPanelConnectionInProgress();
      try {
        // connection = await BluetoothConnection.toAddress(zefire.address);
        // BluetoothManager.sendMessage(Protocol.sendMessage(), connection);
        // connection.input.listen((data) {
        //   BluetoothManager.onDataReceived(data);
        //   add(UpdateDataEvent());
        // });
      } catch (error) {
        BluetoothManager.arrayOfMessage
            .add("Error from connection is ${error.toString()}");
        print("ERROR ${error.toString()}");
        yield ControlPanelError(error.toString());
      }
    }
    if (event is FlameSizeIncreaseEvent) {
      yield* _mapFlameIncreaseToState();
    }
    if (event is FlameSizeDecreaseEvent) {
      yield* _mapFlameDecreaseToState();
    }

    if (event is OpenShopEvent) {
      _openShopUrl();
    }
    if (event is PowerToggleEvent) {
      yield* _mapPowerToState();
    }
    if (event is MakeCallEvent) {
      _makeCall();
    }
  }

  Stream<ControlPanelState> _openShopUrl() async* {
    const url = 'https://zefire.ru/obratnaya-svyaz/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      yield ControlPanelError("Ошибка при открытии сайта");
    }
  }

  Stream<ControlPanelState> _makeCall() async* {
    const url = 'tel:+7 (499) 229-15-14'; // select number based on region?

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      yield ControlPanelError("Ошибка при наборе номера");
    }
  }

  Stream<ControlPanelState> _mapFlameIncreaseToState() async* {
    // make bluetooth call
    if (state is ControlPanelConnected) {
      final updatedFireplace = Protocol.getBioburner();
      if (updatedFireplace.flameSize < updatedFireplace.maxFlameSize) {
        Protocol.flameHeight++;
        // BluetoothManager.sendMessage(Protocol.sendMessage(), connection);
        print("STATE ${Protocol.sendMessage()}");
        yield ControlPanelConnected(Protocol.getBioburner());
      }
    }
  }

  Stream<ControlPanelState> _mapFlameDecreaseToState() async* {
    // make bluetooth call
    if (state is ControlPanelConnected) {
      final updatedBioburner = Protocol.getBioburner();
      if (updatedBioburner.flameSize > 0) {
        Protocol.flameHeight--;
        // BluetoothManager.sendMessage(Protocol.sendMessage(), connection);
        yield ControlPanelConnected(Protocol.getBioburner());
      }
    }
  }

  Stream<ControlPanelState> _mapPowerToState() async* {
    // make bluetooth call
    if (state is ControlPanelConnected) {
      if (Protocol.onOff == 1) {
        Protocol.onOff = 0;
        // BluetoothManager.sendMessage(Protocol.sendMessage(), connection);
      } else {
        Protocol.onOff = 1;
        // BluetoothManager.sendMessage(Protocol.sendMessage(), connection);
      }
      print("STATE ${Protocol.sendMessage()}");

      yield ControlPanelConnected(Protocol.getBioburner());
    }
  }

  @override
  Future<void> close() {
    // connection.dispose();
    return super.close();
  }
}
