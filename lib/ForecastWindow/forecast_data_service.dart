import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_forecast_post.dart';
import 'package:geolocator/geolocator.dart';

class ForecastDataService {
  Position? position;
  String? lat;
  String? long;

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<dynamic>?> getPosts() async {
    try {
      Position position = await getGeoLocationPosition();
      lat = '${position.latitude.toInt()}';
      long = '${position.longitude.toInt()}';
      print(lat);
      print(long);

      final queryParameters = {
        'lat': lat,
        'lon': long,
        'units': 'metric',
        'appid': '6814eeb0575cbbab88a93bf90c1238e6'
      };
      final uri = Uri.http(
          'api.openweathermap.org', '/data/2.5/forecast', queryParameters);

      final response = await http.get(uri);
      print(response);
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      final posts = WeatherForecastPost.fromJson(json).list;
      return posts;
    } catch (e) {
      throw e;
    }
  }
}
