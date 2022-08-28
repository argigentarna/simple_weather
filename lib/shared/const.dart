import 'package:flutter/material.dart';
import 'package:simple_weather_app/shared/helper.dart';

// NOTE : Base URL weather api
const apiBaseUrl = "http://api.openweathermap.org/data/2.5/";

// NOTE : Api key from openweathermap, to fetch data
const apiKey = "e159ffb42f2ee8b0161bb8b016a544d2";

// NOTE : Latitude & Longitude dummy, Jakarta
const lat = -6.1753871;
const long = 106.8249641;

const defaultCount = 40;

// NOTE : Response
const resSuccessUploaded = "Upload successfully!";
const resFailedGetStatus = "Failed to get status!";
const resNoConnection = 'No Internet connection!';
const resCouldntFindData = "Couldn't find the data!";
const resBadResponse = "Bad response format!";
const resFailedGetTransaction = 'Failed to get transactions!';

// NOTE : Lottie
const String lotCloudyAfternoon = 'assets/lottie/cloud_afternoon.json';
const String lotCloudyDay = 'assets/lottie/cloud_day.json';
const String lotCloudyNight = 'assets/lottie/cloud_night.json';
const String lotRainyAfternoon = 'assets/lottie/rainy_afternoon.json';
const String lotRainyDay = 'assets/lottie/rainy_day.json';
const String lotRainyNight = 'assets/lottie/rainy_night.json';
const String lotNoConnection = 'assets/lottie/no_connection.json';

// NOTE : List Api
String apiForecast(int page) {
  return "forecast?lat=$lat&lon=$long&appid=$apiKey&cnt=${Helper().convertToCount(page)}&units=metric&unit=3";
}
