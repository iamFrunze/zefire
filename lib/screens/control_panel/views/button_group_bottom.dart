import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zefire/resources/displayType.dart';

class ButtonGroupBottom extends StatelessWidget {
  final _websiteUrl = 'https://zefire.ru/obratnaya-svyaz/';
  final _phoneUrl = 'tel:+7 (499) 229-15-14';

  void _openUrl(url, context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(Strings.controlPanelError),
      ));
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
          return Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(Strings.controlPanelOderFuelTitle,
                            style: _displaySize == displayType.smallDisplay
                                ? CustomStyles.headline2SmallScreen(context)
                                : Theme.of(context).textTheme.headline2)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buttonBottomItem(
                              context,
                              Strings.controlPanelMakeCallButton,
                              () => _openUrl(_phoneUrl, context),
                              _displaySize),
                          SizedBox(width: 20),
                          buttonBottomItem(
                              context,
                              Strings.controlPanelOpenWebsiteButton,
                              () => _openUrl(_websiteUrl, context),
                              _displaySize)
                        ]),
                  ])),
            ),
          );
        });
  }
}

Widget buttonBottomItem(context, buttonText, onPressedAction, displaySize) {
  return Expanded(
    child: Container(
      height: displaySize == displayType.smallDisplay ? 48 : 64,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).disabledColor,
          boxShadow: [
            CustomStyles.shadowDecorationDark,
            CustomStyles.shadowDecorationLight
          ]),
      child: FlatButton(
          onPressed: () {
            onPressedAction();
          },
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(buttonText,
                      textAlign: TextAlign.center,
                      style: displaySize == displayType.smallDisplay
                          ? CustomStyles.buttonSmallScreen(context)
                          : Theme.of(context).textTheme.button)))),
    ),
  );
}
