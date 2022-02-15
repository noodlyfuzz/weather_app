import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'today_weather_post.dart';
import 'package:xml2json/xml2json.dart';

class TodayDataService {
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

  Future<dynamic>? getPosts() async {
    try {
      Position position = await getGeoLocationPosition();
      lat = '${position.latitude.toStringAsFixed(5)}';
      long = '${position.longitude.toStringAsFixed(5)}';
      print(lat);
      print(long);

      final queryParameters = {
        'lat': lat,
        'lon': long,
        'units': 'metric',
        'mode': 'xml',
        'appid': '6814eeb0575cbbab88a93bf90c1238e6'
      };
      final uri = Uri.http(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);

      final response = await http.get(uri);
      final myTransformer = Xml2Json();
      myTransformer.parse(response.body);
      final jsons = myTransformer.toGData();
      final json = jsonDecode(jsons) as Map<String, dynamic>;
      final post = TodayWeatherPost.fromJson(json);
      return post;
    } catch (e) {
      throw e;
    }
  }
}
