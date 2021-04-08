import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/helpers/bluetooth_manager.dart';
import 'package:zefire/helpers/dialog_error.dart';
import 'package:zefire/main.dart';
import 'package:zefire/resources/displayType.dart';
import 'package:zefire/resources/images.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';

import 'package:zefire/screens/control_panel/views/button_group_bottom.dart';
import 'package:zefire/screens/control_panel/views/divider.dart';
import 'package:zefire/screens/control_panel/views/flame_view.dart';
import 'package:zefire/screens/control_panel/views/fuel_volume_view.dart';
import 'package:zefire/screens/control_panel/views/header_view.dart';
import 'package:zefire/screens/control_panel/views/loader.dart';
import 'package:zefire/screens/control_panel/views/logo_mage_view.dart';
import 'package:zefire/screens/control_panel/views/power_view.dart';
import 'package:zefire/screens/control_panel/views/system_status_view.dart';
import 'package:zefire/screens/control_panel/views/text_button.dart';

class ControlPanelScreen extends StatefulWidget {
  @override
  _ControlPanelScreenState createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen>
    with RouteAware {
  ControlPanelBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final _displaySize =
        MediaQuery.of(context).size.width <= CustomStyles.smallDeviceWidthMax
            ? displayType.smallDisplay
            : displayType.largeDisplay;

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ControlPanelError)
            showError(context, Strings.errorTitle,
                "Соединение с устройством прервано", "Поиск устройств", () {
              Navigator.pushReplacementNamed(
                  context, Strings.routeToDeviceSearchScreen);
            });
        },
        child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is ControlPanelConnectionInProgress) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        systemNavigationBarColor:
                            Theme.of(context).backgroundColor),
                    child: Scaffold(
                      body: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.start_background),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            logoImageView,
                            loader(),
                          ],
                        ),
                      ),
                    ));
              } else {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        systemNavigationBarColor:
                            Theme.of(context).backgroundColor),
                    child: Scaffold(
                        backgroundColor: Theme.of(context).backgroundColor,
                        body: _displaySize == displayType.smallDisplay
                            ? controlPanelSmallScreen(context)
                            : controlPanelLargeScreen(context)));
              }
            }),
      ),
    );
  }

  @override
  void didPopNext() {
    _bloc = ControlPanelBloc();
    _bloc.add(ControlPanelConnectionRequested());
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
    _bloc = ControlPanelBloc();
    _bloc.add(ControlPanelConnectionRequested());
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

Widget controlPanelLargeScreen(context) {
  return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        HeaderView(),
        SizedBox(height: CustomStyles.spacingBig),
        divider(context),
        SizedBox(height: CustomStyles.spacingBig),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: SystemStatusView(),
          ),
          PowerView(),
        ]),
        SizedBox(height: CustomStyles.spacingBig),
        FlameView(),
        SizedBox(height: CustomStyles.spacingBig),
        FuelVolumeView(),
        SizedBox(height: CustomStyles.spacingBig),
        ButtonGroupBottom()
      ]));
}

Widget controlPanelSmallScreen(context) {
  return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        HeaderView(),
        SizedBox(height: CustomStyles.spacingBigSmallScreen),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: SystemStatusView(),
          ),
          PowerView(),
        ]),
        SizedBox(height: CustomStyles.spacingBigSmallScreen),
        FlameView(),
        SizedBox(height: CustomStyles.spacingBigSmallScreen),
        FuelVolumeView(),
        SizedBox(height: CustomStyles.spacingBigSmallScreen),
        ButtonGroupBottom()
      ]));
}
