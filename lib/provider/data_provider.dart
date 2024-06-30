import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  WeatherModel? weatherModel;
  double _latitude = 0.0, _longitude = 0.0;
  bool get hasDataLoaded => weatherModel != null;
  Map<String, dynamic> queryParams = {};
  bool locationAccess = false;
  bool _isLoading = false;
  String _greeting = '';
  String _subtitle = '';
  String visibility = '';
  final apiKey = '823805ed368564fb588cd05260dae090';
  final baseUrl = Uri.parse('https://api.openweathermap.org/data/2.5/weather');

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get greeting => _greeting;
  String get subtitle => _subtitle;
  bool get isLoading => _isLoading;

  DataProvider() {
    init();
  }

  void init() async {
    _setGreeting();
    await getLocation();
    _setQueryParameters();
    getWeatherData();
  }

  void meterToKm(String number) {
    double meters = double.parse(number);
    String ans = (meters / 1000).toString();
    visibility = ans;
  }

  void _setQueryParameters() {
    queryParams['lat'] = '$_latitude';
    queryParams['lon'] = '$_longitude';
    queryParams['appid'] = apiKey;
    queryParams['units'] = 'metric';
  }

  Future<void> getWeatherData() async {
    _isLoading = true;
    notifyListeners();

    final uri = Uri.https(baseUrl.authority, baseUrl.path, queryParams);
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
      _isLoading = false;
      if (weatherModel != null && weatherModel!.visibility != null) {
        meterToKm(weatherModel!.visibility.toString());
      }
      notifyListeners();
    }
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
