// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:simple_weather_app/enum/status_response.dart';
import 'package:simple_weather_app/providers/weather_provider.dart';
import 'package:simple_weather_app/shared/const.dart';
import 'package:simple_weather_app/ui/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:simple_weather_app/ui/widgets/unsuccess_view.dart';
import 'package:simple_weather_app/ui/widgets/weather_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherProvider weatherProvider = WeatherProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

    // NOTE : Initial data weather
    Future.delayed(
      const Duration(milliseconds: 100),
    ).then((value) async {
      await weatherProvider.initWeather();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    weatherProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        'Weather App',
        context,
      ),
      body: Consumer<WeatherProvider>(
        builder: (_, data, ch) {
          if (data.isLoading!) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data.status == StatusResponse.noNetwork) {
            return Center(
              child: UnsuccessView(
                type: lotNoConnection,
              ),
            );
          }
          return ListView.builder(
            itemCount: data.countForecast(),
            itemBuilder: (context, i) {
              return WeatherTile(
                forecast: data.listForecast![i],
              );
            },
          );
        },
      ),
    );
  }
}
