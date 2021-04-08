import 'package:flutter/material.dart';

import '../../../resources/strings.dart';

Widget Header(context) => Container(
      child: Column(
        children: [HeaderTitle(context), HeaderSubtitle(context)],
      ),
    );

Widget HeaderTitle(context) => Container(
    width: 343,
    height: 80,
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
    child: Text(Strings.deviceSearch,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2));

Widget HeaderSubtitle(context) => Container(
    alignment: Alignment.topCenter,
    height: 48,
    margin: const EdgeInsets.only(left: 16, right: 16),
    child: Text(Strings.chooseFireplace,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle2));
