// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:simple_weather_app/enum/date_type.dart';
import 'package:simple_weather_app/models/forecast_model.dart';
import 'package:simple_weather_app/shared/const.dart';
import 'package:simple_weather_app/shared/helper.dart';
import 'package:simple_weather_app/shared/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple_weather_app/ui/pages/detil_weather_page.dart';

import 'shimmer_container.dart';

class WeatherTile extends StatelessWidget {
  WeatherTile({
    Key? key,
    required this.forecast,
  }) : super(key: key);
  ListDataForecast forecast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetilWeatherPage(
              forecast: forecast,
            ),
          ),
        );
      },
      child: Container(
        color: kTransparentColor,
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CachedNetworkImage(
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                  imageUrl:
                      Helper().getImageIcon(forecast.weather!.first.icon!),
                  placeholder: (context, url) => ShimmerContainer(
                    width: 50,
                    height: 50,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      Helper()
                          .convertStringToDate(
                            forecast.dtTxt!,
                            DateType.datetimeHome,
                          )
                          .toString(),
                      style: mainTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      forecast.weather!.first.main.toString(),
                      style: mainTextStyle.copyWith(
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      forecast.main!.temp.toString() + " ℃",
                      style: mainTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
