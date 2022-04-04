import 'dart:convert';

import 'package:intl/intl.dart';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather {
  Weather({
    this.lat,
    this.lon,
    this.timezone,
    this.current,
    this.hourly,
    this.daily,
  });

  double? lat;
  double? lon;
  String? timezone;
  Current? current;
  List<Current>? hourly;
  List<Daily>? daily;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"] ?? "",
        current: Current.fromJson(json["current"]),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );
}

class Current {
  Current({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.windSpeed,
    this.weather,
  });

  int? dt;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  double? windSpeed;
  List<WeatherElement>? weather;

  get time {
    var convDate = DateTime.fromMillisecondsSinceEpoch(dt! * 1000);
    var formattedDate = DateFormat('kk:mm').format(convDate);
    return formattedDate;
  }

  get temperature {
    return (temp! - 273.15).toStringAsFixed(2);
  }

  String get lottieAsset {
    var condition = weather!.first.id!;

    if (condition < 300) {
      return 'lib/assets/lottie/thunder_lottie.json';
    } else if (condition < 400) {
      return 'lib/assets/lottie/drizzle_lottie.json';
    } else if (condition < 600) {
      return 'lib/assets/lottie/rainy_lottie.json';
    } else if (condition < 700) {
      return 'lib/assets/lottie/snow_lottie.json';
    } else if (condition < 800) {
      return 'lib/assets/lottie/thunder_lottie.json';
    } else if (condition == 800) {
      return 'lib/assets/lottie/sunny_lottie.json';
    } else if (condition <= 804) {
      return 'lib/assets/lottie/cloudy_lottie.json';
    } else {
      return 'lib/assets/lottie/sunny_lottie.json';
    }
  }

  String get image {
    var condition = weather!.first.id!;

    if (condition < 300) {
      return 'lib/assets/images/lightning.png';
    } else if (condition < 400) {
      return 'lib/assets/images/drizzle.png';
    } else if (condition < 600) {
      return 'lib/assets/images/rain.png';
    } else if (condition < 700) {
      return 'lib/assets/images/snow.png';
    } else if (condition < 800) {
      return 'lib/assets/images/lightning.png';
    } else if (condition == 800) {
      return 'lib/assets/images/sunny.png';
    } else if (condition <= 804) {
      return 'lib/assets/images/cloudy.png';
    } else {
      return 'lib/assets/images/sunny.png';
    }
  }

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        windSpeed: json["wind_speed"].toDouble(),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
      );
}

class WeatherElement {
  WeatherElement({
    this.id,
    this.description,
    this.icon,
    this.title,
  });

  int? id;
  String? description;
  String? icon;
  String? title;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        description: json["description"],
        icon: json["icon"],
        title: json["main"],
      );
}

class Daily {
  Daily({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.weather,
    this.uvi,
  });

  int? dt;
  Temp? temp;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  List<WeatherElement>? weather;
  double? uvi;

  get time {
    var convDate = DateTime.fromMillisecondsSinceEpoch(dt! * 1000);
    var formattedDate = DateFormat('EEEE').format(convDate);
    return formattedDate;
  }

  String get lottieAsset {
    var condition = weather!.first.id!;

    if (condition < 300) {
      return 'lib/assets/lottie/thunder_lottie.json';
    } else if (condition < 400) {
      return 'lib/assets/lottie/drizzle_lottie.json';
    } else if (condition < 600) {
      return 'lib/assets/lottie/rainy_lottie.json';
    } else if (condition < 700) {
      return 'lib/assets/lottie/snow_lottie.json';
    } else if (condition < 800) {
      return 'lib/assets/lottie/thunder_lottie.json';
    } else if (condition == 800) {
      return 'lib/assets/lottie/sunny_lottie.json';
    } else if (condition <= 804) {
      return 'lib/assets/lottie/cloudy_lottie.json';
    } else {
      return 'lib/assets/lottie/sunny_lottie.json';
    }
  }

  String get image {
    var condition = weather!.first.id!;

    if (condition < 300) {
      return 'lib/assets/images/lightning.png';
    } else if (condition < 400) {
      return 'lib/assets/images/drizzle.png';
    } else if (condition < 600) {
      return 'lib/assets/images/rain.png';
    } else if (condition < 700) {
      return 'lib/assets/images/snow.png';
    } else if (condition < 800) {
      return 'lib/assets/images/lightning.png';
    } else if (condition == 800) {
      return 'lib/assets/images/sunny.png';
    } else if (condition <= 804) {
      return 'lib/assets/images/cloudy.png';
    } else {
      return 'lib/assets/images/sunny.png';
    }
  }

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        temp: Temp.fromJson(json["temp"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        uvi: json["uvi"].toDouble(),
      );
}

class Temp {
  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );
}
