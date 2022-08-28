// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_if_null_operators, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_weather_app/shared/themes.dart';

class ShimmerContainer extends StatelessWidget {
  ShimmerContainer({
    this.height,
    this.width,
    this.margin,
    this.noRadius,
    this.isEnabled,
    this.radius,
  });

  double? height;
  double? width;
  EdgeInsetsGeometry? margin = EdgeInsets.all(0);
  bool? noRadius;
  bool? isEnabled;
  BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: isEnabled != null ? isEnabled! : true,
      baseColor: Colors.black12,
      highlightColor: Colors.white10,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: noRadius != null && noRadius == true
              ? null
              : radius != null
                  ? radius
                  : BorderRadius.all(
                      Radius.circular(10),
                    ),
        ),
        height: height,
        width: width,
        child: Text(''),
      ),
    );
  }
}
