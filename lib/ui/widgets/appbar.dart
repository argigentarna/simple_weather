import 'package:flutter/material.dart';
import 'package:simple_weather_app/shared/themes.dart';

PreferredSizeWidget customAppbar(
  String title,
  context,
) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: kBluePrimaryColor,
    centerTitle: true,
    title: Text(
      title,
      style: mainTextStyle.copyWith(
        fontSize: 18,
        fontWeight: semiBold,
        color: kWhitePrimaryColor,
        letterSpacing: 0.8,
      ),
    ),
  );
}
