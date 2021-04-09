import 'package:flutter/material.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/connection_device/connection_device_screen.dart';
import 'package:zefire/screens/control_panel/control_panel.dart';
import 'package:zefire/screens/device_list/devices_list_screen.dart';
import 'package:zefire/screens/start/start.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Strings.routeToDeviceSearchScreen,
        navigatorObservers: [routeObserver],
        routes: {
          Strings.routeToStartScreen: (BuildContext context) => StartScreen(),
          Strings.routeToDeviceSearchScreen: (BuildContext context) =>
              DeviceListScreen(),
          Strings.routeToControlPaneScreen: (context) => ControlPanelScreen(),
          Strings.routeToConnectionStateScreen: (context) =>
              ConnectionDeviceScreen()
        },
        title: 'Zefire App',
        theme: CustomStyles.customTheme);
  }
}
