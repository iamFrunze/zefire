import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/screens/connection_device/bloc/connection_device_bloc.dart';
import 'package:zefire/screens/connection_device/views/failure_state.dart';
import 'package:zefire/screens/connection_device/views/success_state.dart';

import '../../main.dart';

class ConnectionDeviceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConnectionDeviceScreenState();
  }
}

class ConnectionDeviceScreenState extends State<ConnectionDeviceScreen>
    with RouteAware {
  ConnectionDeviceBloc _bloc;

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
  void didPopNext() {
    _bloc = ConnectionDeviceBloc();

    _bloc.add(GetConnectionEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() async {
    _bloc.close();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _bloc = ConnectionDeviceBloc();

    _bloc.add(GetConnectionEvent());
  }

  @override
  void didPop() {
    _bloc.close();
  }

  @override
  void didPushNext() {
    _bloc.close();
  }
}
