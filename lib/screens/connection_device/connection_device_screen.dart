import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:zefire/screens/connection_device/bloc/connection_device_bloc.dart';
import 'package:zefire/screens/connection_device/views/failure_state.dart';
import 'package:zefire/screens/connection_device/views/success_state.dart';

import '../../main.dart';

class ConnectionDeviceScreen extends StatefulWidget {
  BluetoothDevice device;

  ConnectionDeviceScreen({@required this.device});

  @override
  State<StatefulWidget> createState() {
    return ConnectionDeviceScreenState();
  }
}

class ConnectionDeviceScreenState extends State<ConnectionDeviceScreen> {
  ConnectionDeviceBloc _bloc;

  BluetoothDevice _device;

  @override
  void initState() {
    super.initState();
    _bloc = ConnectionDeviceBloc();
    _device = widget.device;
    _bloc.add(GetConnectionEvent(device: _device));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case ConnectionSuccessState:
                {
                  return SuccessState(context);
                }
              case ConnectionFailureState:
                {
                  return FailureState(context);
                }
            }
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: Container(
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }),
    );
  }

  @override
  void dispose() async {
    _bloc.close();
    super.dispose();
  }
}
