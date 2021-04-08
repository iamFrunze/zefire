import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zefire/resources/displayType.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';

class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _displaySize =
        MediaQuery.of(context).size.width <= CustomStyles.smallDeviceWidthMax
            ? displayType.smallDisplay
            : displayType.largeDisplay;
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(top: 35.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/images/logo.svg",
                width: _displaySize == displayType.smallDisplay ? 29 : 43.32,
                height: _displaySize == displayType.smallDisplay ? 30 : 46.49,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _displaySize == displayType.smallDisplay ? 7 : 10.32),
                child: SvgPicture.asset(
                  "assets/images/logo_text.svg",
                  width: _displaySize == displayType.smallDisplay ? 85 : 127.36,
                  height: _displaySize == displayType.smallDisplay ? 20 : 31.34,
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  iconButton(context, "assets/images/bluetooth_icon.svg"),
                  true ? iconDone(context) : null,
                  // todo if devise is Connected
                ],
              ),
              SizedBox(
                  width: _displaySize == displayType.smallDisplay ? 11 : 16),
              iconButton(context, "assets/images/phone_icon.svg"),
            ],
          )
        ]),
      ),
    ]);
  }
}

Widget iconButton(context, imgSrc) {
  return Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      color: Theme.of(context).disabledColor,
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
            context, Strings.routeToDeviceSearchScreen);
      }, // todo handle tap
      child: Padding(
        padding: EdgeInsets.all(12),
        child: SvgPicture.asset(
          imgSrc,
        ),
      ),
    ),
  );
}

Widget iconDone(context) {
  return Positioned(
    top: -2.0, // todo position outside
    right: -2.0,
    child: GestureDetector(
        onTap: () {}, // todo handle tap
        child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: SvgPicture.asset(
                "assets/images/done_icon.svg",
              ),
            ))),
  );
}
