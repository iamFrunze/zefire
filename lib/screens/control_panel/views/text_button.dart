import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefire/resources/styles.dart';
import 'package:zefire/screens/control_panel/bloc/control_panel_bloc.dart';

import '../../../resources/strings.dart';

Widget texButton(context, onAction) => BlocBuilder(
    bloc: BlocProvider.of<ControlPanelBloc>(context),
    builder: (context, state) {
      return Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 64.0,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                CustomStyles.shadowDecorationDark,
                CustomStyles.shadowDecorationLight
              ],
            ),
            margin: const EdgeInsets.only(bottom: 24, left: 26, right: 26),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              splashColor: Colors.deepOrange.shade900,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: onAction,
              child: Text(Strings.retry,
                  style: Theme.of(context).textTheme.button),
            ),
          ),
        ),
      );
    });
