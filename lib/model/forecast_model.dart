import 'dart:convert';

ForecastModel forecastModelFromJson(String str) => ForecastModel.fromJson(json.decode(str));

String forecastModelToJson(ForecastModel data) => json.encode(data.toJson());

class ForecastModelCityCoord {
  double? lat;
  double? lon;

  ForecastModelCityCoord({
    this.lat,
    this.lon,
  });
  ForecastModelCityCoord.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble();
    lon = json['lon']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

class ForecastModelCity {
  int? id;
  String? name;
  ForecastModelCityCoord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  ForecastModelCity({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });
  ForecastModelCity.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    coord = (json['coord'] != null) ? ForecastModelCityCoord.fromJson(json['coord']) : null;
    country = json['country']?.toString();
    population = json['population']?.toInt();
    timezone = json['timezone']?.toInt();
    sunrise = json['sunrise']?.toInt();
    sunset = json['sunset']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class ForecastModelListSys {
  String? pod;

  ForecastModelListSys({
    this.pod,
  });
  ForecastModelListSys.fromJson(Map<String, dynamic> json) {
    pod = json['pod']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pod'] = pod;
    return data;
  }
}

class ForecastModelListRain {
  double? the3h;

  ForecastModelListRain({
    this.the3h,
  });
  ForecastModelListRain.fromJson(Map<String, dynamic> json) {
    the3h = json['3h']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['3h'] = the3h;
    return data;
  }
}

class ForecastModelListWind {

  double? speed;
  int? deg;
  double? gust;

  ForecastModelListWind({
    this.speed,
    this.deg,
    this.gust,
  });
  ForecastModelListWind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg']?.toInt();
    gust = json['gust']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class ForecastModelListClouds {
  int? all;

  ForecastModelListClouds({
    this.all,
  });
  ForecastModelListClouds.fromJson(Map<String, dynamic> json) {
    all = json['all']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class ForecastModelListWeather {
  int? id;
  String? main;
  String? description;
  String? icon;

  ForecastModelListWeather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
  ForecastModelListWeather.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    main = json['main']?.toString();
    description = json['description']?.toString();
    icon = json['icon']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class ForecastModelListMain {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  ForecastModelListMain({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });
  ForecastModelListMain.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure']?.toInt();
    seaLevel = json['sea_level']?.toInt();
    grndLevel = json['grnd_level']?.toInt();
    humidity = json['humidity']?.toInt();
    tempKf = json['temp_kf']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    data['temp_kf'] = tempKf;
    return data;
  }
}

class ForecastModelList {
  int? dt;
  ForecastModelListMain? main;
  List<ForecastModelListWeather?>? weather;
  ForecastModelListClouds? clouds;
  ForecastModelListWind? wind;
  int? visibility;
  double? pop;
  ForecastModelListRain? rain;
  ForecastModelListSys? sys;
  String? dtTxt;

  ForecastModelList({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });
  ForecastModelList.fromJson(Map<String, dynamic> json) {
    dt = json['dt']?.toInt();
    main = (json['main'] != null) ? ForecastModelListMain.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      final v = json['weather'];
      final arr0 = <ForecastModelListWeather>[];
      v.forEach((v) {
        arr0.add(ForecastModelListWeather.fromJson(v));
      });
      weather = arr0;
    }
    clouds = (json['clouds'] != null) ? ForecastModelListClouds.fromJson(json['clouds']) : null;
    wind = (json['wind'] != null) ? ForecastModelListWind.fromJson(json['wind']) : null;
    visibility = json['visibility']?.toInt();
    pop = json['pop']?.toDouble();
    rain = (json['rain'] != null) ? ForecastModelListRain.fromJson(json['rain']) : null;
    sys = (json['sys'] != null) ? ForecastModelListSys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      final v = weather;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['weather'] = arr0;
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    data['visibility'] = visibility;
    data['pop'] = pop;
    if (rain != null) {
      data['rain'] = rain!.toJson();
    }
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['dt_txt'] = dtTxt;
    return data;
  }
}

class ForecastModel {
  String? cod;
  int? message;
  int? cnt;
  List<ForecastModelList?>? list;
  ForecastModelCity? city;

  ForecastModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });
  ForecastModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod']?.toString();
    message = json['message']?.toInt();
    cnt = json['cnt']?.toInt();
    if (json['list'] != null) {
      final v = json['list'];
      final arr0 = <ForecastModelList>[];
      v.forEach((v) {
        arr0.add(ForecastModelList.fromJson(v));
      });
      list = arr0;
    }
    city = (json['city'] != null) ? ForecastModelCity.fromJson(json['city']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      final v = list;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['list'] = arr0;
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}
class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    coord: json["coord"] != null ? Coord.fromJson(json["coord"]) : null,
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coord": coord?.toJson(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Coord {
  double? lat;
  double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}

class ListElement {
  int? dt;
  MainClass? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Rain? rain;
  Sys? sys;
  DateTime? dtTxt;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: json["main"] != null ? MainClass.fromJson(json["main"]) : null,
    weather: json["weather"] != null ? List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))) : null,
    clouds: json["clouds"] != null ? Clouds.fromJson(json["clouds"]) : null,
    wind: json["wind"] != null ? Wind.fromJson(json["wind"]) : null,
    visibility: json["visibility"],
    pop: json["pop"]?.toDouble(),
    rain: json["rain"] != null ? Rain.fromJson(json["rain"]) : null,
    sys: json["sys"] != null ? Sys.fromJson(json["sys"]) : null,
    dtTxt: json["dt_txt"] != null ? DateTime.parse(json["dt_txt"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main?.toJson(),
    "weather": weather != null ? List<dynamic>.from(weather!.map((x) => x.toJson())) : null,
    "clouds": clouds?.toJson(),
    "wind": wind?.toJson(),
    "visibility": visibility,
    "pop": pop,
    "rain": rain?.toJson(),
    "sys": sys?.toJson(),
    "dt_txt": dtTxt?.toIso8601String(),
  };
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class MainClass {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Rain {
  double? the3H;

  Rain({
    this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the3H: json["3h"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": the3H,
  };
}

class Sys {
  Pod? pod;

  Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: podValues.map[json["pod"]],
  );

  Map<String, dynamic> toJson() => {
    "pod": podValues.reverse[pod],
  };
}

enum Pod {
  D,
  N
}

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class Weather {
  int? id;
  MainEnum? main;
  Description? description;
  Icon? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: mainEnumValues.map[json["main"]],
    description: descriptionValues.map[json["description"]],
    icon: iconValues.map[json["icon"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": mainEnumValues.reverse[main],
    "description": descriptionValues.reverse[description],
    "icon": iconValues.reverse[icon],
  };
}

enum Description {
  BROKEN_CLOUDS,
  LIGHT_RAIN,
  OVERCAST_CLOUDS
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "light rain": Description.LIGHT_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS
});

enum Icon {
  THE_04_D,
  THE_04_N,
  THE_10_D,
  THE_10_N
}

final iconValues = EnumValues({
  "04d": Icon.THE_04_D,
  "04n": Icon.THE_04_N,
  "10d": Icon.THE_10_D,
  "10n": Icon.THE_10_N
});

enum MainEnum {
  CLOUDS,
  RAIN
}

final mainEnumValues = EnumValues({
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN
});

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
