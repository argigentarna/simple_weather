// ignore_for_file: nullable_type_in_catch_clause, use_function_type_syntax_for_parameters, avoid_print, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/enum/date_type.dart';
import 'package:simple_weather_app/models/response_model.dart';
import 'package:simple_weather_app/shared/themes.dart';
import 'package:get/get.dart';
import 'const.dart';
import 'package:jiffy/jiffy.dart';

class Helper {
  Future<bool> getApi(
      String url,
      String a,
      callback(
    Map<String, dynamic> res,
  ),
      {String? token}) async {
    Map<String, dynamic> res;
    ResponseModel resModel;
    try {
      final http.Response response = await http.get(
        Uri.parse(apiBaseUrl + a),
      );

      res = await json.decode(response.body);

      if (response.statusCode == 200) {
        resModel = ResponseModel(
          rc: 200,
          data: res,
        );
        callback(resModel.toJson());
        return false;
      }
      resModel = ResponseModel(
        rc: 400,
        data: res.toString(),
      );
      callback(resModel.toJson());
    } on SocketException {
      resModel = ResponseModel(
        rc: 900,
        data: resNoConnection,
      );
      callback(resModel.toJson());
    } on HttpException {
      resModel = ResponseModel(
        rc: 901,
        data: resCouldntFindData,
      );
      callback(resModel.toJson());
    } on FormatException {
      resModel = ResponseModel(
        rc: 400,
        data: resBadResponse,
      );
      callback(resModel.toJson());
    }
    return false;
  }

  int convertToCount(int page) {
    return page * defaultCount;
  }

  successMessage(String data) {
    Helper().showSnackBar(
      data,
      null,
      EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 55,
      ),
      kBluePrimaryColor,
    );
  }

  errorMessage(String data) {
    Helper().showSnackBar(
      data,
      null,
      EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 55,
      ),
      null,
    );
  }

  showSnackBar(
    String? title,
    String? message,
    EdgeInsets? margin,
    Color? color,
  ) {
    return Get.snackbar(
      '',
      '',
      titleText: Container(
        margin: EdgeInsets.only(
          top: 3,
        ),
        child: title != null
            ? Text(
                title,
                style: mainTextStyle.copyWith(
                  color: kWhitePrimaryColor,
                ),
              )
            : Container(),
      ),
      messageText: message != null
          ? Text(
              message,
              style: mainTextStyle.copyWith(
                color: kWhitePrimaryColor,
              ),
            )
          : Container(),
      borderRadius: 12,
      margin: margin,
      forwardAnimationCurve: Curves.easeOutBack,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      onTap: (_) {},
      backgroundColor: color != null ? color : kRedAdditionalColor,
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 800),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String convertStringToDate(String date, DateType type) {
    var dateData = {
      'year': DateTime.parse(date).year,
      'month': DateTime.parse(date).month,
      'day': DateTime.parse(date).day,
      'hour': DateTime.parse(date).hour,
    };

    if (type == DateType.datetimeHome) {
      List dateHome = [];
      final _day = Jiffy(dateData).yMMMMEEEEd.split(",")[0];
      final _month = Jiffy(dateData).yMMMMEEEEd.split(",")[1];
      final _time = Jiffy(dateData).yMMMMEEEEd.split(",")[2];

      final _m1 = _month.trim().split(" ")[0].substring(0, 3);
      final _m2 = _month.trim().split(" ")[1];

      dateHome.add(_day.substring(0, 3));
      dateHome.add(_m1 + " " + _m2);
      dateHome.add(_time + " " + Jiffy(dateData).jm);

      return dateHome.join(", ");
    }

    if (type == DateType.withoutTime) {
      return Jiffy(dateData).yMMMMEEEEd;
    }

    if (type == DateType.timeOnly) {
      return Jiffy(dateData).jm;
    }

    return Jiffy(dateData).yMMMMEEEEdjm;
  }

  String getImageIcon(String icon) {
    return "http://openweathermap.org/img/wn/${icon}@2x.png";
  }
}
