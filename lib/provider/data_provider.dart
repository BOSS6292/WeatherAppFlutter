import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier{
  WeatherModel? weatherModel;
  bool get hasDataLoaded => weatherModel!=null;
  Map<String, dynamic> queryParams = {};
  final apiKey = 'a598ec140b084792c70e298737aca73a';
  final baseUrl = Uri.parse('https://api.openweathermap.org/data/2.5/weather');

  _setQueryParameters(){
    queryParams['lat'] = '18.8554625';
    queryParams['lon'] = '73.876472';
    queryParams['appid'] = apiKey;
  }

  init(){
    _setQueryParameters();
    getWeatherData();
  }

  Future<void>getWeatherData() async{
    final uri = Uri.https(baseUrl.authority,baseUrl.path,queryParams);
    try{
      final repsonse = await http.get(uri);
      if(repsonse.statusCode == 200){
        final json = jsonDecode(repsonse.body);
        weatherModel = WeatherModel.fromJson(json);
        print(weatherModel!.name!);
        notifyListeners();
      }
    }catch(error){
      print(error.toString());
    }
  }
}