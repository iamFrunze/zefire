import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/helpers/protocol.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';
import 'package:zefire/resources/displayType.dart';

class FuelVolumeView extends StatefulWidget {
  @override
  _FuelVolumeViewState createState() => _FuelVolumeViewState();
}

class _FuelVolumeViewState extends State<FuelVolumeView> {
  double _fuelVolume = Protocol.fuelLvl.toDouble();
  double _fuelVolumeMax = 100; // in %

  double _emptyVolume() {
    return _fuelVolumeMax - _fuelVolume;
  }

  @override
  Widget build(BuildContext context) {
    final _displaySize =
        MediaQuery.of(context).size.width <= CustomStyles.smallDeviceWidthMax
            ? displayType.smallDisplay
            : displayType.largeDisplay;

    return BlocBuilder<ControlPanelBloc, ControlPanelState>(
        bloc: BlocProvider.of<ControlPanelBloc>(context),
        builder: (context, state) {
          if (state is ControlPanelConnected) {
            _fuelVolume = state.bioburner.fuelVolume.toDouble();
            return Expanded(
              child: Stack(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: _displaySize == displayType.smallDisplay
                            ? CustomStyles.spacingSmallSmallScreen
                            : CustomStyles.spacingSmall),
                    child: Text(Strings.controlPanelFuelVolumeTitle,
                        style: _displaySize == displayType.smallDisplay
                            ? CustomStyles.headline2SmallScreen(context)
                            : Theme.of(context).textTheme.headline2),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            CustomStyles.shadowDecorationDark,
                            CustomStyles.shadowDecorationLight
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: _emptyVolume().toInt(),
                                child: Container(
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  color: Theme.of(context).disabledColor,
                                ))),
                            Container(
                                color: Theme.of(context).primaryColor,
                                height: 2),
                            Expanded(
                              flex: _fuelVolume.toInt() * 5,
                              child: Container(
                                  decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.7),
                              )),
                            )
                          ],
                        )),
                  ),
                ]),
                Positioned(
                    right: 16.0,
                    top: 40, //dynamic for small screens
                    child: Text(
                      "${_fuelVolume * 5}%",
                      style: _displaySize == displayType.smallDisplay
                          ? CustomStyles.bodyText2SmallScreen(context)
                          : Theme.of(context).textTheme.bodyText2,
                    ))
              ]),
            );
          } else {
            return Expanded(
              child: Stack(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: _displaySize == displayType.smallDisplay
                            ? CustomStyles.spacingSmallSmallScreen
                            : CustomStyles.spacingSmall),
                    child: Text(Strings.controlPanelFuelVolumeTitle,
                        style: _displaySize == displayType.smallDisplay
                            ? CustomStyles.headline2SmallScreen(context)
                            : Theme.of(context).textTheme.headline2),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            CustomStyles.shadowDecorationDark,
                            CustomStyles.shadowDecorationLight
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: _emptyVolume().toInt(),
                                child: Container(
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  color: Theme.of(context).disabledColor,
                                ))),
                            Container(
                                color: Theme.of(context).primaryColor,
                                height: 2),
                            Expanded(
                              flex: 0,
                              child: Container(
                                  decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.7),
                              )),
                            )
                          ],
                        )),
                  ),
                ]),
                Positioned(
                    right: 16.0,
                    top: 40, //dynamic for small screens
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
              ]),
            );
          }
        });
  }
}
