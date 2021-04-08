import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zefire/helpers/protocol.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';
import 'package:zefire/resources/displayType.dart';

class PowerView extends StatefulWidget {
  @override
  _PowerViewState createState() => _PowerViewState();
}

class _PowerViewState extends State<PowerView> {
  bool _isPowerOn = true;
  double _dividerHeight = 0.5;
  double _boxTopSectionRatio = 0.44;

  double _boxBottomSectionRatio() {
    return 1.0 - _boxTopSectionRatio;
  }

  @override
  Widget build(BuildContext context) {
    final _displaySize =
        MediaQuery.of(context).size.width <= CustomStyles.smallDeviceWidthMax
            ? displayType.smallDisplay
            : displayType.largeDisplay;
    final double _boxSize = _displaySize == displayType.smallDisplay ? 80 : 120;

    return BlocBuilder<ControlPanelBloc, ControlPanelState>(
        bloc: BlocProvider.of<ControlPanelBloc>(context),
        builder: (context, state) {
          if (state is ControlPanelConnected) {
            _isPowerOn = state.bioburner.powerIsOn;
            return Container(
                width: _boxSize,
                height: _boxSize + _dividerHeight,
                decoration: BoxDecoration(boxShadow: [
                  CustomStyles.shadowDecorationDark,
                  CustomStyles.shadowDecorationLight
                ]),
                child: Column(children: [
                  Container(
                    width: _boxSize,
                    height: _boxSize * _boxTopSectionRatio,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Theme.of(context).disabledColor,
                    ),
                    child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: _displaySize == displayType.smallDisplay
                                  ? 8
                                  : 16,
                              bottom: _displaySize == displayType.smallDisplay
                                  ? 6
                                  : 14),
                          child: Text(Strings.controlPanelPowerTitle,
                              textAlign: TextAlign.center,
                              style: _displaySize == displayType.smallDisplay
                                  ? CustomStyles.headline1SmallScreen(context)
                                  : Theme.of(context).textTheme.headline1)),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                    height: _dividerHeight,
                  ),
                  Container(
                    width: _boxSize,
                    height: _boxSize * _boxBottomSectionRatio(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                      color: _isPowerOn
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                    ),
                    child: FlatButton(
                      onPressed: () {
                        BlocProvider.of<ControlPanelBloc>(context).add(PowerToggleEvent());
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/power_icon.svg",
                          width: _displaySize == displayType.smallDisplay
                              ? 18
                              : 24.36,
                          height: _displaySize == displayType.smallDisplay
                              ? 20
                              : 26.52,
                        ),
                      ),
                    ),
                  ),
                ]));
          } else
            return CircularProgressIndicator();
        });
  }
}
