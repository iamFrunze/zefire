import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zefire/resources/images.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';

Widget SuccessState(context) => Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Text(Strings.connectionEstablishedTitle,
                  textAlign: TextAlign.center,
                  style: CustomStyles.customTheme.textTheme.headline1),
            ),
            Container(
              height: 48,
              margin: const EdgeInsets.only(left: 16, right: 16),
              alignment: Alignment.topCenter,
              child: Text(Strings.connectionEstablishedDescription,
                  textAlign: TextAlign.center,
                  style: CustomStyles.customTheme.textTheme.subtitle2),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: SvgPicture.asset(
                Images.images_success,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 64,
                          width: 162,
                          decoration: BoxDecoration(
                            boxShadow: [
                              CustomStyles.shadowDecorationDark,
                              CustomStyles.shadowDecorationLight
                            ],
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: Text(Strings.canceling,
                                style: Theme.of(context).textTheme.button),
                            color: Theme.of(context).disabledColor,
                            textColor: Colors.white,
                          ),
                        ),
                        Container(
                          height: 64,
                          width: 162,
                          decoration: BoxDecoration(
                            boxShadow: [
                              CustomStyles.shadowDecorationDark,
                              CustomStyles.shadowDecorationLight
                            ],
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Strings.routeToControlPaneScreen,
                                  (Route<dynamic> route) => false);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: Text(Strings.next,
                                style: Theme.of(context).textTheme.button),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
