import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/helpers/protocol.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';
import 'package:zefire/resources/displayType.dart';

class FlameView extends StatefulWidget {
  @override
  _FlameViewState createState() => _FlameViewState();
}

class _FlameViewState extends State<FlameView> {
  double _flameSize = Protocol.flameHeight.toDouble();
  double _flameSizeMax = 6.0;
  bool _shouldIncreaseFlame = true;
  double _flameViewButtonsAndPaddingWidth = 200.0;
  double _flameViewButtonsAndPaddingWidthSmallScreen = 168.0;

  void _changeFlameSize(bool shouldIncrease) {
    if (!shouldIncrease && _flameSize > 0) {
      BlocProvider.of<ControlPanelBloc>(context).add(FlameSizeDecreaseEvent());
    } else if (shouldIncrease && _flameSize < _flameSizeMax) {
      BlocProvider.of<ControlPanelBloc>(context).add(FlameSizeIncreaseEvent());
    }
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
            _flameSize = state.bioburner.flameSize.toDouble();
            print("FLAME ${_flameSize}");
          }
          return Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(
                      bottom: _displaySize == displayType.smallDisplay
                          ? CustomStyles.spacingSmallSmallScreen
                          : CustomStyles.spacingSmall),
                  child: Text(Strings.controlPanelFlameSizeTitle,
                      style: _displaySize == displayType.smallDisplay
                          ? CustomStyles.headline2SmallScreen(context)
                          : Theme.of(context).textTheme.headline2)),
              Row(children: [
                controlButton(
                    context, "-", !_shouldIncreaseFlame, _displaySize),
                flameIndicatorGroup(_displaySize),
                controlButton(context, "+", _shouldIncreaseFlame, _displaySize),
              ]),
            ]),
          );
        });
  }

  Widget controlButton(context, buttonText, shouldIncrease, displaySize) {
    return Container(
        width: displaySize == displayType.smallDisplay ? 64 : 80.0,
        height: displaySize == displayType.smallDisplay ? 64 : 80.0,
        margin: EdgeInsets.only(right: shouldIncrease ? 0 : 8),
        // margin for decrease button
        // flame indicators have right margin 8
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Theme.of(context).disabledColor,
            boxShadow: [
              CustomStyles.shadowDecorationDark,
              CustomStyles.shadowDecorationLight
            ]),
        child: FlatButton(
          onPressed: () => _changeFlameSize(shouldIncrease),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ));
  }

  Widget flameIndicatorGroup(displaySize) {
    final _screenSize = MediaQuery.of(context).size.width;
    final _flameGroupWidth = displaySize == displayType.smallDisplay
        ? _screenSize - _flameViewButtonsAndPaddingWidthSmallScreen
        : _screenSize - _flameViewButtonsAndPaddingWidth;
    final _flameIndicatorPaddingRight = 8.0;
    final _flameIndicatorWidth =
        (_flameGroupWidth - _flameIndicatorPaddingRight * _flameSizeMax) /
            _flameSizeMax;
    final _widthToBorderRadiusRelation = 0.5; // in layout it is 10/20
    final _flameIndicatorRadius =
        _flameIndicatorWidth * _widthToBorderRadiusRelation;

    return Container(
        width: _flameGroupWidth,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (var i = 0; i < _flameSizeMax; i++)
            flameIndicator(i, _flameIndicatorRadius,
                _flameIndicatorPaddingRight, displaySize)
        ]));
  }

  Widget flameIndicator(int i, double borderRadius, paddingRight, displaySize) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: i < _flameSize
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
      ),
      margin: EdgeInsets.only(right: paddingRight),
      height: displaySize == displayType.smallDisplay ? 64 : 80.0,
    ));
  }
}
