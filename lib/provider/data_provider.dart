import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/air_quality_model.dart';
import 'package:weather_app/model/forecast_model.dart';

import '../model/weather_model.dart';

class DataProvider extends ChangeNotifier {
  WeatherModel? weatherModel;
  ForecastModel? forecastModel;
  AirQuality? airQualityModel;

  double _latitude = 0.0, _longitude = 0.0;
  Map<String, dynamic> queryParamsWeather = {};
  Map<String, dynamic> queryParamsForecast = {};
  Map<String, dynamic> queryParamsAirQuality = {};
  String airQuality = '';
  String isDayOrNight = '';
  bool locationAccess = false;
  bool _isLoading = false;
  List<Color> _gradientColors = [];
  String _greeting = '';
  String _subtitle = '';
  String visibility = '';
  bool _isLoadingWeather = false;
  bool _isLoadingForecast = false;
  bool _isLoadingAirQuality = false;
  final apiKey = '823805ed368564fb588cd05260dae090';
  final baseUrl = Uri.parse('https://api.openweathermap.org/data/2.5/weather');
  final baseUrl2 =
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast');
  final baseUrl3 =
      Uri.parse('https://api.openweathermap.org/data/2.5/air_pollution');

  double get latitude => _latitude;

  double get longitude => _longitude;

  String get greeting => _greeting;

  String get subtitle => _subtitle;

  bool get isLoading => _isLoading;

  bool get hasDataLoaded => forecastModel != null;

  List<Color> get gradientColors => _gradientColors;

  DataProvider() {
    init();
  }

  void init() async {
    _updateGradientColors();
    await getLocation();

    _isLoadingWeather = true;
    _isLoadingForecast = true;
    notifyListeners();

    _setQueryParameters();
    _setQueryParametersForForecast();
    _setQueryParameteresForAirQuality();

    await Future.wait(
        [getWeatherData(), getForecastData(), getAirQualityData()]);
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

  void _setQueryParameteresForAirQuality() {
    queryParamsAirQuality['lat'] = '$_latitude';
    queryParamsAirQuality['lon'] = '$_longitude';
    queryParamsAirQuality['appid'] = apiKey;
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

    final uri =
        Uri.https(baseUrl2.authority, baseUrl2.path, queryParamsForecast);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        forecastModel = ForecastModel.fromJson(json);
        print('Forecast data loaded successfully');
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Failed to load forecast data: ${response.statusCode}');
        }
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Network error fetching forecast data: $e');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching forecast data: $error');
      }
    } finally {
      _isLoadingForecast = false;
      notifyListeners();
    }
  }

  Future<void> getAirQualityData() async {
    _isLoadingAirQuality = true;
    notifyListeners();

    final uri =
        Uri.https(baseUrl3.authority, baseUrl3.path, queryParamsAirQuality);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        airQualityModel = AirQuality.fromJson(json);
        if (kDebugMode) {
          print('Air Quality data loaded successfully');
        }
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Failed to load Air Quality: ${response.statusCode}');
        }
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Network error fetching Air Quality: $e');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Air Quality: $error');
      }
    } finally {
      _isLoadingAirQuality = false;
      notifyListeners();
    }
  }

  String? printForecastItems(String dtTxt) {
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

  List<T> getTodaysData<T>() {
    if (forecastModel?.list == null) {
      return [];
    }
    final today = DateTime.now();
    final todaysData = forecastModel!.list!.where((item) {
      final forecastDate = DateTime.parse(item!.dtTxt!);
      return forecastDate.year == today.year &&
          forecastDate.month == today.month &&
          forecastDate.day == today.day &&
          forecastDate.isAfter(today);
    }).toList() as List<T>;
    return todaysData;
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
        if (kDebugMode) {
          print('Location access already granted.');
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('PlatformException: $e');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting location: $error');
      }
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

  String getWeatherImage(String? weatherCondition, String? dayOrNight, String? desc) {
    if (weatherCondition == null || dayOrNight == null) {
      return 'assets/default.png';
    }

    String lowerWeatherCondition = weatherCondition.toLowerCase();
    String lowerDayOrNight = dayOrNight.toLowerCase();

    switch (lowerWeatherCondition) {
      case 'clouds':
        if (lowerDayOrNight.contains('d')) {
          if (desc == 'overcast clouds') {
            return 'assets/weatherConditions/day_cloudy.png';
          } else if (desc == 'few clouds') {
            return 'assets/weatherConditions/day_sunny.png';
          } else if (desc == 'scattered clouds' || desc == 'broken clouds') {
            return 'assets/weatherConditions/day_sunny_cloud.png';
          }
        } else {
          if (desc == 'overcast clouds') {
            return 'assets/weatherConditions/night_cloudy.png';
          } else if (desc == 'few clouds' || desc == 'scattered clouds') {
            return 'assets/weatherConditions/night_cloudy.png';
          } else if (desc == 'broken clouds') {
            return 'assets/weatherConditions/night.png';
          }
        }
        break;
      case 'clear':
        if (lowerDayOrNight.contains('d')) {
          return 'assets/weatherConditions/day_clear_sunny.png';
        } else {
          return 'assets/weatherConditions/night_clear.png';
        }
      case 'rain':
        if (lowerDayOrNight.contains('d')) {
          return 'assets/weatherConditions/day_rain.png';
        } else {
          return 'assets/weatherConditions/night_rain.png';
        }
      case 'drizzle':
        if (lowerDayOrNight.contains('d')) {
          return 'assets/weatherConditions/day_cloudy_rainy.png';
        } else {
          return 'assets/weatherConditions/night_rain.png';
        }
      case 'thunderstorm':
        return 'assets/weatherConditions/day_night_heavyRainAndStrom.png';
      default:
        return 'assets/default.png';
    }
    return 'assets/default.png';
  }

  AirQualityInfo getAirQualityInfo(String airQuality) {
    int aqi = int.tryParse(airQuality) ?? 0;

    if (aqi >= 0 && aqi <= 50) {
      return AirQualityInfo(
        message: 'Good air quality',
        recommendation: 'Enjoy outdoor activities!',
      );
    } else if (aqi >= 51 && aqi <= 100) {
      return AirQualityInfo(
        message: 'Moderate air quality',
        recommendation: 'It\'s okay to go for a walk.',
      );
    } else if (aqi >= 101 && aqi <= 150) {
      return AirQualityInfo(
        message: 'Unhealthy for sensitive groups',
        recommendation: 'Limit prolonged outdoor exertion.',
      );
    } else if (aqi >= 151 && aqi <= 200) {
      return AirQualityInfo(
        message: 'Unhealthy air quality',
        recommendation: 'Avoid prolonged outdoor activities.',
      );
    } else if (aqi >= 201 && aqi <= 300) {
      return AirQualityInfo(
        message: 'Very unhealthy air quality',
        recommendation: 'Stay indoors and avoid outdoor activities.',
      );
    } else if (aqi > 300) {
      return AirQualityInfo(
        message: 'Hazardous air quality',
        recommendation:
            'Remain indoors and keep outdoor activities to a minimum.',
      );
    } else {
      return AirQualityInfo(
        message: 'Unknown air quality',
        recommendation: 'Check air quality information.',
      );
    }
  }

  void _updateGradientColors() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (6 <= currentHour && currentHour < 11) {
      _gradientColors = [Colors.yellow[200]!, Colors.orange[700]!, Colors.yellow[200]!];
    } else if (11 <= currentHour && currentHour < 17) {
      _gradientColors = [Colors.lightBlue[200]!, Colors.blue[700]!, Colors.lightBlue[200]!];
    } else if (17 <= currentHour && currentHour < 19) {
      _gradientColors = [Colors.indigo[400]!, Colors.blue[900]!, Colors.indigo[400]!];
    } else {
      _gradientColors = [Colors.black, Colors.grey[900]!, Colors.black];
    }
    notifyListeners();
  }
}
