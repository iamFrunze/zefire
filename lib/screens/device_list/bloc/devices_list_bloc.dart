import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as asd;
import 'package:meta/meta.dart';
import 'package:zefire/helpers/bluetooth_manager.dart';
import 'package:zefire/resources/strings.dart';
import 'package:rxdart/rxdart.dart';

part 'devices_list_event.dart';

part 'devices_list_state.dart';

class DevicesListBloc extends Bloc<DevicesListEvent, DevicesListState> {
  DevicesListBloc() : super(DevicesListInitial());

  static List<ScanResult> arrayOfResult = [];
  StreamSubscription sub;

  @override
  void onTransition(Transition<DevicesListEvent, DevicesListState> transition) {
    super.onTransition(transition);
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  Stream<DevicesListState> mapEventToState(event) async* {
    try {
      if (event is DevicesDiscoveryEvent) {
        try {
          arrayOfResult.clear();
          sub = flutterBlue.scanResults.asBroadcastStream().listen((event) {
            add(UpdateDiscoveryListEvent(device: event));
          });
        } catch (e) {
          print("Error $e");
        }
      }
      if (event is UpdateDiscoveryListEvent) {
        yield* dist(event.device);
      }
    } catch (e) {
      yield (DeviceListFailureState(
          titleErrorText: Strings.errorTitle,
          descErrorText: Strings.unknownError));
    }
  }

  Stream<DevicesListState> dist(List<ScanResult> scan) async* {
    arrayOfResult.clear();
    arrayOfResult.addAll(scan);
    if (arrayOfResult.isNotEmpty)
      yield (DeviceListLoadedState(arrayOfResult: arrayOfResult));
    else
      yield (DeviceListEmptyState());
  }

  @override
  Future<void> close() async {
    await sub.cancel();
    return super.close();
  }
}
