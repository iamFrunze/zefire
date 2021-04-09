import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:zefire/helpers/dialog_error.dart';
import 'package:zefire/main.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/screens/device_list/bloc/devices_list_bloc.dart';
import 'package:zefire/screens/device_list/views/devices_list_view.dart';
import 'package:zefire/screens/device_list/views/header_view.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen>  {
  DevicesListBloc _bloc;

  List<BluetoothDevice> arrayOfDevice = [];

  FlutterBlue flutterBlue = FlutterBlue.instance;
  @override
  void initState() {
    super.initState();
    _bloc = DevicesListBloc();
    _bloc.add(DevicesDiscoveryEvent());
    flutterBlue.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is DeviceListFailureState) {
            showError(context, state.titleErrorText, state.descErrorText,
                Strings.retry, null);
          }
          if (state is DeviceListEmptyState) {
            // _bloc.add(DevicesDiscoveryEvent());
          }
        },
        child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is DeviceListLoadingState) {
              } else if (state is DeviceListLoadedState) {
                return AnnotatedRegion(
                  value: SystemUiOverlayStyle(
                      systemNavigationBarColor:
                          Theme.of(context).backgroundColor),
                  child: Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    body: Column(
                      children: [
                        Header(context),
                        AvailableDevicesTitle(context),
                        DevicesList(state.arrayOfResult),
                      ],
                    ),
                  ),
                );
              }

              return AnnotatedRegion(
                value: SystemUiOverlayStyle(
                    systemNavigationBarColor:
                        Theme.of(context).backgroundColor),
                child: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Column(
                    children: [
                      Header(context),
                      AvailableDevicesTitle(context),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }


  @override
  void dispose() async {
    _bloc.close();
    flutterBlue.stopScan();
    super.dispose();
  }



}
