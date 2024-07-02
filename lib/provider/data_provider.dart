import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/forecast_model.dart';

import '../model/weather_model.dart'; // Adjust path as per your project structure

class DataProvider extends ChangeNotifier {
  WeatherModel? weatherModel;
  ForecastModel? forecastModel;
  double _latitude = 0.0, _longitude = 0.0;
  Map<String, dynamic> queryParamsWeather = {};
  Map<String, dynamic> queryParamsForecast = {};
  bool locationAccess = false;
  bool _isLoading = false;
  String _greeting = '';
  String _subtitle = '';
  String visibility = '';
  bool _isLoadingWeather = false;
  bool _isLoadingForecast = false;
  final apiKey = '823805ed368564fb588cd05260dae090';
  final baseUrl = Uri.parse('https://api.openweathermap.org/data/2.5/weather');
  final baseUrl2 = Uri.parse('https://api.openweathermap.org/data/2.5/forecast');

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get greeting => _greeting;
  String get subtitle => _subtitle;
  bool get isLoading => _isLoading;
  bool get hasDataLoaded => forecastModel!=null;

  DataProvider() {
    init();
  }

  void init() async {
    _setGreeting();
    await getLocation();

    _isLoadingWeather = true;
    _isLoadingForecast = true;
    notifyListeners();

    _setQueryParameters();
    _setQueryParametersForForecast();

    await Future.wait([
      getWeatherData(),
      getForecastData(),
    ]);
  }

  String getCurrentMonthAndTime() {
    return DateFormat('MMMM d').format(DateTime.now());
  }

  void meterToKm(String number) {
    double meters = double.parse(number);
    String ans = (meters / 1000).toString();
    visibility = ans;
  }

  void _setQueryParameters() {
    queryParamsWeather['lat'] = '$_latitude';
    queryParamsWeather['lon'] = '$_longitude';
    queryParamsWeather['appid'] = apiKey;
    queryParamsWeather['units'] = 'metric';
  }

  void _setQueryParametersForForecast() {
    queryParamsForecast['lat'] = '$_latitude';
    queryParamsForecast['lon'] = '$_longitude';
    queryParamsForecast['appid'] = apiKey;
    queryParamsForecast['units'] = 'metric';
  }

  Future<void> getWeatherData() async {
    _isLoadingWeather = true;
    notifyListeners();

    final uri = Uri.https(baseUrl.authority, baseUrl.path, queryParamsWeather);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        weatherModel = WeatherModel.fromJson(json);
        if (weatherModel != null) {
          print(weatherModel!.id);
        } else {
          print('Weather model is null');
        }
        notifyListeners(); // Notify listeners after updating data
      } else {
        print('Failed to load weather data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    } finally {
      _isLoadingWeather = false;
      if (weatherModel != null && weatherModel!.visibility != null) {
        meterToKm(weatherModel!.visibility.toString());
      }
      notifyListeners();
    }
  }

  Future<void> getForecastData() async {
    _isLoadingForecast = true;
    notifyListeners();

    final uri = Uri.https(baseUrl2.authority, baseUrl2.path, queryParamsForecast);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        forecastModel = ForecastModel.fromJson(json);
        print('Forecast data loaded successfully');
        notifyListeners();
      } else {
        print('Failed to load forecast data: ${response.statusCode}');
        // Handle error, e.g., show a message to the user
      }
    } on SocketException catch (e) {
      print('Network error fetching forecast data: $e');
      // Handle network error
    } catch (error) {
      print('Error fetching forecast data: $error');
      // Handle other errors
    } finally {
      _isLoadingForecast = false;
      notifyListeners();
    }
  }

  String? printForecastItems(String dtTxt) {
    /*if (forecastModel == null || forecastModel!.list!.isEmpty) {
      if (kDebugMode) {
        print('No forecast data available');
      }
      return 'Null';
    }*/
    DateTime now = DateTime.now();
    bool shouldPrint = false;
    String? ans;

      var forecastItemText = dtTxt;
      DateTime forecastDateTime = convertStringToDateTimeObj(forecastItemText);

      if (shouldPrint || forecastDateTime.isAfter(now)) {
        ans = DateFormat('hh:mm a').format(forecastDateTime);
        shouldPrint = true;
      }
      if (shouldPrint && forecastDateTime.day != now.day) {
        return null;
      }
    return ans;
  }


  DateTime convertStringToDateTimeObj(String? dt) {
    return DateTime.parse(dt!);
  }

  Future<void> getLocation() async {
    try {
      if (!locationAccess) {
        final position = await _determinePosition();
        _latitude = position.latitude;
        _longitude = position.longitude;
        locationAccess = true;
        notifyListeners();
      } else {
        print('Location access already granted.');
      }
    } on PlatformException catch (e) {
      print('PlatformException: $e');
    } catch (error) {
      print('Error getting location: $error');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _setGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _greeting = 'Good Morning';
      _subtitle = 'Rise and shine!';
    } else if (hour >= 12 && hour < 17) {
      _greeting = 'Good Afternoon!';
      _subtitle = 'Time for lunch?';
    } else if (hour >= 17 && hour < 21) {
      _greeting = 'Good Evening!';
      _subtitle = 'Enjoy the sunset!';
    } else {
      _greeting = 'Good Night!';
      _subtitle = 'Sweet dreams!';
    }
  }

  String getWeatherIcon(String? main) {
    switch (main!.toLowerCase()) {
      case 'clouds':
        return 'assets/Clouds.png';
      case 'clear':
        return 'assets/Day Sun.png';
      case 'rain':
        return 'assets/Rain.png';
      default:
        return 'assets/default.png';
    }
  }
}
