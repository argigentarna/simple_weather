// ignore_for_file: avoid_print, unrelated_type_equality_checks, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/forecast_model.dart';
import 'package:simple_weather_app/shared/const.dart';
import 'package:simple_weather_app/shared/helper.dart';

import '../enum/status_response.dart';
import '../models/response_model.dart';

class WeatherProvider with ChangeNotifier {
  List<ListDataForecast> _listForecast = [];
  List<ListDataForecast>? get listForecast => _listForecast;
  set listForecast(List<ListDataForecast>? listForecast) {
    _listForecast = listForecast!;
    notifyListeners();
  }

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;
  set isLoading(bool? val) {
    _isLoading = val;
    notifyListeners();
  }

  late StatusResponse _status = StatusResponse.noData;
  StatusResponse get status => _status;
  set status(StatusResponse status) {
    _status = status;
    notifyListeners();
  }

  int? _pagin = 1;
  int? get pagin => _pagin;
  set pagin(int? pagin) {
    _pagin = pagin;
    notifyListeners();
  }

  int countForecast() {
    return _listForecast != null ? _listForecast.length : 0;
  }

  Future<void> initWeather() async {
    status = StatusResponse.noData;
    pagin = 1;
    isLoading = true;
    await fetchWeather();
    isLoading = false;
  }

  Future<void> fetchWeather() async {
    Helper().getApi(
      apiBaseUrl,
      apiForecast(pagin!),
      (res) {
        ResponseModel resModel = ResponseModel.fromJson(res);
        print("RES MODEL");
        print(resModel.rc.toString());
        if (resModel.rc == 200) {
          ForecastModel resData = ForecastModel.fromJson(resModel.data);
          print("Check cod");
          print(resData.cod.toString());
          if (resData.cod.toString() == "200") {
            List<ListDataForecast>? _listTemp = [];
            print("Check xxx");
            print(resData.cnt.toString());
            if ((resData.cnt ?? 0) > 0) {
              print("Check List");
              print(resData.list.toString());
              if (resData.list.toString() != "[]") {
                List data = resData.list!;
                for (var item in data) {
                  print("CHECK ITEM");
                  print(item.toString());
                  _listTemp.add(item);
                  notifyListeners();
                }
                status = StatusResponse.isLoaded;
                _listForecast = _listTemp;
                notifyListeners();
              } else {
                status = StatusResponse.noData;
              }
            }
          }
        } else {
          if (resModel.rc.toString() == "900") {
            status = StatusResponse.noNetwork;
          }
        }
      },
    );
  }
}
