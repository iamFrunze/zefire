import 'package:flutter/material.dart';

Widget divider(context) {
  return Container(
      child: Divider(
        color: Theme.of(context).dividerColor,
        height: 0.5,
      ));
}