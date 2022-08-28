// ignore_for_file: prefer_const_constructors, must_be_immutable, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_weather_app/enum/date_type.dart';
import 'package:simple_weather_app/models/forecast_model.dart';
import 'package:simple_weather_app/shared/helper.dart';
import 'package:simple_weather_app/shared/themes.dart';
import 'package:simple_weather_app/ui/widgets/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple_weather_app/ui/widgets/shimmer_container.dart';

class DetilWeatherPage extends StatelessWidget {
  DetilWeatherPage({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  ListDataForecast forecast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        'Weather Details',
        context,
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            Helper()
                .convertStringToDate(
                  forecast.dtTxt!,
                  DateType.withoutTime,
                )
                .toString(),
            style: mainTextStyle.copyWith(
              fontSize: 21,
              fontWeight: bold,
            ),
          ),
          Text(
            Helper()
                .convertStringToDate(
                  forecast.dtTxt!,
                  DateType.timeOnly,
                )
                .toString(),
            style: mainTextStyle.copyWith(
              fontSize: 18,
              fontWeight: regular,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                forecast.main!.temp.toString() + "℃",
                style: mainTextStyle.copyWith(
                  fontSize: 40,
                  fontWeight: regular,
                ),
              ),
              CachedNetworkImage(
                fit: BoxFit.contain,
                height: 120,
                width: 120,
                imageUrl: Helper().getImageIcon(forecast.weather!.first.icon!),
                placeholder: (context, url) => ShimmerContainer(
                  width: 50,
                  height: 50,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                forecast.weather!.first.main.toString(),
                style: mainTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 18,
                ),
              ),
              Text(
                " (${forecast.weather!.first.description.toString()}) ",
                style: mainTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Temp (min)",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${forecast.main!.tempMin}℃",
                      style: mainTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Temp (max)",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${forecast.main!.tempMax}℃",
                      style: mainTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
