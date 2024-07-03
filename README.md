# 🌤️ Weather App

A Flutter application for checking weather forecasts and air quality index (AQI) using the OpenWeatherMap API.

![App Demo](demo.gif)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Libraries Used](#libraries-used)
- [APIs Used](#apis-used)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Weather App is a mobile application developed in Flutter that allows users to retrieve current weather conditions, view weather forecasts, and check air quality index (AQI) for any location around the globe. It leverages the OpenWeatherMap API to fetch weather data and geolocation services for obtaining user coordinates.

## Features

- **Current Weather:** Display current temperature, weather conditions, humidity, wind speed, and more for a specified location.
- **Weather Forecast:** Show weather forecasts for the next few days, including temperature highs/lows and weather icons.
- **Air Quality Index (AQI):** Retrieve and display AQI data based on geographical coordinates.
## Libraries Used

- **shimmer_animation:** Provides shimmering effect animations while data is loading. 🌟
- **intl:** Internationalization and localization support for multi-language app versions. 🌍
- **provider:** State management for efficient data flow within the app. 🔄
- **http:** HTTP requests for seamless communication with the OpenWeatherMap API. 📡
- **geolocator:** Fetches device location coordinates for accurate weather data retrieval. 📍
- **geocoding:** Converts between geographical coordinates and place names for user-friendly location search. 🔍
- **flutter_easyloading:** Displays loading indicators during data fetching processes. ⏳
- **google_fonts:** Integrates custom fonts for enhanced visual appeal and readability. 🎨
- **shimmer:** Implements shimmer effects for smooth loading placeholders. ✨
- **carousel_slider:** Provides a carousel widget for interactive weather forecast display. 🎠
- **flutter_screenutil:** Offers adaptive screen size management for consistent UI across devices. 📱

## APIs Used

- **OpenWeatherMap API:**
  - **Current Weather:** Retrieves real-time weather data such as temperature, humidity, wind speed, and weather conditions. 🌡️💧💨
  - **Weather Forecast:** Fetches weather forecast data for upcoming days, including temperature highs/lows and weather icons. 🌤️🌧️❄️
  - **Air Quality Index (AQI):** Gets AQI data based on latitude and longitude coordinates. 🌍🌱

## Setup Instructions

1. **Clone the repository:**
git clone https://github.com/your/repository.git
cd repository_name
2. **Add your API key:**
- Obtain an API key from [OpenWeatherMap](https://openweathermap.org/api).
- Create a file named `api.dart` in `lib/utils/` directory.
- Add your API key in `api.dart`:
  ```dart
  const String apiKey = 'YOUR_API_KEY';
  ```

3. **Install dependencies:**
4. **Run the app:**
   
## Usage
- Upon launching the app, the location permission dialog opens up.
- By giving access to location permission, the current weather for your current location will be displayed.
- Swipe through forecast cards to view AQI Details and Guidlines.

## Screenshots
![SS_Loading](https://github.com/BOSS6292/WeatherAppFlutter/assets/97422476/1c35735a-c7fa-499a-a3b3-b16a7db5828b)
*Loading Screen*
![SS_Loaded](https://github.com/BOSS6292/WeatherAppFlutter/assets/97422476/134709bb-9f4b-4563-aa61-b66afc86ce0f)
*Weather Data Loaded*
![SS_AQI](https://github.com/BOSS6292/WeatherAppFlutter/assets/97422476/67f37c56-6f99-42c0-a0f3-f41a815dc97b)
*Weather AQI

## Design Attribution

The app design and icons are inspired by a Figma design file created by [Pasindu](https://www.figma.com/@pasindujdj) ([Weather App (Community)](https://www.figma.com/design/qFsqseA23C35CivKZFDOSV/Weather-App-(Community)?node-id=1-7&t=jEawIarPq2RQrQaI-1)). We thank them for their creative contribution.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please submit an issue or a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
