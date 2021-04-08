import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zefire/resources/images.dart';

Widget logoImageView = Container(
  margin: EdgeInsets.only(top: 150.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        Images.images_logo,
        width: 53.0,
        height: 57.0,
      ),
      Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: SvgPicture.asset(
          Images.images_logo_text,
          width: 31.0,
          height: 31.0,
        ),
      ),
    ],
  ),
);
