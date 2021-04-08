import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/resources/displayType.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';

class SystemStatusView extends StatefulWidget {
  @override
  _SystemStatusViewState createState() => _SystemStatusViewState();
}

class _SystemStatusViewState extends State<SystemStatusView> {
  String _systemStatus = "Низкий уровень топлива";
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
          if (state is ControlPanelConnected)
            return Container(
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(boxShadow: [
                  CustomStyles.shadowDecorationDark,
                  CustomStyles.shadowDecorationLight
                ]),
                height: _boxSize + _dividerHeight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: _boxSize * _boxTopSectionRatio,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: Theme.of(context).disabledColor,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: _displaySize == displayType.smallDisplay
                                    ? 8
                                    : 16,
                                top: _displaySize == displayType.smallDisplay
                                    ? 8
                                    : 16,
                                bottom: _displaySize == displayType.smallDisplay
                                    ? 6
                                    : 14),
                            child: Text(Strings.controlPanelSystemStatusTitle,
                                style: _displaySize == displayType.smallDisplay
                                    ? CustomStyles.headline1SmallScreen(context)
                                    : Theme.of(context).textTheme.headline1),
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        height: _dividerHeight,
                      ),
                      Container(
                        height: _boxSize * _boxBottomSectionRatio(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Theme.of(context).disabledColor,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: _displaySize == displayType.smallDisplay
                                    ? 8
                                    : 16,
                                bottom: _displaySize == displayType.smallDisplay
                                    ? 4
                                    : 8),
                            child: Text(state.bioburner.statusText,
                                style: _displaySize == displayType.smallDisplay
                                    ? CustomStyles.bodyText1SmallScreen(context)
                                    : Theme.of(context).textTheme.bodyText1),
                          ),
                        ),
                      ),
                    ]));
        });
  }
}
