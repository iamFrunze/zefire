import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/resources/strings.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/connection_device/bloc/connection_device_bloc.dart';

Widget FailureState(context) => Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Text(Strings.connectionNotEstablishedTitle,
                  textAlign: TextAlign.center,
                  style: CustomStyles.customTheme.textTheme.headline1),
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
                              Navigator.pushReplacementNamed(
                                  context, Strings.routeToDeviceSearchScreen);
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
                              BlocProvider.of<ConnectionDeviceBloc>(context)
                                  .add(GetConnectionEvent());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: Text(Strings.retry,
                                style: Theme.of(context).textTheme.button),
                            color: Theme.of(context).disabledColor,
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
