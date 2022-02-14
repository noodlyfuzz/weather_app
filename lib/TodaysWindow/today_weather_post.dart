import 'dart:convert';

class TodayWeatherPost {
  TodayWeatherPost({
    required this.current,
  });

  final Current? current;

  factory TodayWeatherPost.fromRawJson(String str) =>
      TodayWeatherPost.fromJson(json.decode(str));

  factory TodayWeatherPost.fromJson(Map<String, dynamic> json) =>
      TodayWeatherPost(
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
      );
}

class Current {
  Current({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.wind,
    required this.clouds,
    required this.visibility,
    required this.precipitation,
    required this.weather,
    required this.lastupdate,
  });

  final City? city;
  final Temperature? temperature;
  final FeelsLike? feelsLike;
  final FeelsLike? humidity;
  final FeelsLike? pressure;
  final Wind? wind;
  final Clouds? clouds;
  final Lastupdate? visibility;
  final Precipitation? precipitation;
  final Weather? weather;
  final Lastupdate? lastupdate;

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        temperature: json["temperature"] == null
            ? null
            : Temperature.fromJson(json["temperature"]),
        feelsLike: json["feels_like"] == null
            ? null
            : FeelsLike.fromJson(json["feels_like"]),
        humidity: json["humidity"] == null
            ? null
            : FeelsLike.fromJson(json["humidity"]),
        pressure: json["pressure"] == null
            ? null
            : FeelsLike.fromJson(json["pressure"]),
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        visibility: json["visibility"] == null
            ? null
            : Lastupdate.fromJson(json["visibility"]),
        precipitation: json["precipitation"] == null
            ? null
            : Precipitation.fromJson(json["precipitation"]),
        weather:
            json["weather"] == null ? null : Weather.fromJson(json["weather"]),
        lastupdate: json["lastupdate"] == null
            ? null
            : Lastupdate.fromJson(json["lastupdate"]),
      );
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.timezone,
    required this.sun,
  });

  final String? id;
  final String? name;
  final Coord? coord;
  final Country? country;
  final Country? timezone;
  final Sun? sun;

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        timezone: json["timezone"] == null
            ? null
            : Country.fromJson(json["timezone"]),
        sun: json["sun"] == null ? null : Sun.fromJson(json["sun"]),
      );
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  final String? lon;
  final String? lat;

  factory Coord.fromRawJson(String str) => Coord.fromJson(json.decode(str));

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"] == null ? null : json["lon"],
        lat: json["lat"] == null ? null : json["lat"],
      );
}

class Country {
  Country({
    required this.t,
  });

  final String t;

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        t: json["\u0024t"] == null ? null : json["\u0024t"],
      );
}

class Sun {
  Sun({
    required this.rise,
    required this.sunSet,
  });

  final DateTime? rise;
  final DateTime? sunSet;

  factory Sun.fromRawJson(String str) => Sun.fromJson(json.decode(str));

  factory Sun.fromJson(Map<String, dynamic> json) => Sun(
        rise: json["rise"] == null ? null : DateTime.parse(json["rise"]),
        sunSet: json["set"] == null ? null : DateTime.parse(json["set"]),
      );
}

class Clouds {
  Clouds({
    required this.value,
    required this.name,
  });

  final String? value;
  final String? name;

  factory Clouds.fromRawJson(String str) => Clouds.fromJson(json.decode(str));

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        value: json["value"] == null ? null : json["value"],
        name: json["name"] == null ? null : json["name"],
      );
}

class FeelsLike {
  FeelsLike({
    required this.value,
    required this.unit,
  });

  final String? value;
  final String? unit;

  factory FeelsLike.fromRawJson(String str) =>
      FeelsLike.fromJson(json.decode(str));

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        value: json["value"] == null ? null : json["value"],
        unit: json["unit"] == null ? null : json["unit"],
      );
}

class Lastupdate {
  Lastupdate({
    required this.value,
  });

  final String value;

  factory Lastupdate.fromRawJson(String str) =>
      Lastupdate.fromJson(json.decode(str));

  factory Lastupdate.fromJson(Map<String, dynamic> json) => Lastupdate(
        value: json["value"] == null ? null : json["value"],
      );
}

class Precipitation {
  Precipitation({
    required this.value,
    required this.mode,
  });
  final String? value;
  final String? mode;

  factory Precipitation.fromRawJson(String str) =>
      Precipitation.fromJson(json.decode(str));

  factory Precipitation.fromJson(Map<String, dynamic> json) => Precipitation(
        value: json["value"] ?? '0',
        mode: json["mode"] == null ? null : json["mode"],
      );
}

class Temperature {
  Temperature({
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
  });

  final String? value;
  final String? min;
  final String? max;
  final String? unit;

  factory Temperature.fromRawJson(String str) =>
      Temperature.fromJson(json.decode(str));

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        value: json["value"] == null ? null : json["value"],
        min: json["min"] == null ? null : json["min"],
        max: json["max"] == null ? null : json["max"],
        unit: json["unit"] == null ? null : json["unit"],
      );
}

class Weather {
  Weather({
    required this.number,
    required this.value,
    required this.icon,
  });

  final String? number;
  final String? value;
  final String? icon;

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        number: json["number"] == null ? null : json["number"],
        value: json["value"] == null ? null : json["value"],
        icon: json["icon"] == null ? null : json["icon"],
      );
}

class Wind {
  Wind({
    required this.speed,
    required this.gusts,
    required this.direction,
  });

  final Speed? speed;
  final Lastupdate? gusts;
  final Direction? direction;

  factory Wind.fromRawJson(String str) => Wind.fromJson(json.decode(str));

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"] == null ? null : Speed.fromJson(json["speed"]),
        gusts:
            json["gusts"] == null ? null : Lastupdate.fromJson(json["gusts"]),
        direction: json["direction"] == null
            ? null
            : Direction.fromJson(json["direction"]),
      );
}

class Direction {
  Direction({
    required this.value,
    required this.code,
    required this.name,
  });

  final String? value;
  final String? code;
  final String? name;

  factory Direction.fromRawJson(String str) =>
      Direction.fromJson(json.decode(str));

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        value: json["value"] == null ? null : json["value"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
      );
}

class Speed {
  Speed({
    required this.value,
    required this.unit,
    required this.name,
  });

  final String? value;
  final String? unit;
  final String? name;

  factory Speed.fromRawJson(String str) => Speed.fromJson(json.decode(str));

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
        value: json["value"] == null ? null : json["value"],
        unit: json["unit"] == null ? null : json["unit"],
        name: json["name"] == null ? null : json["name"],
      );
}
