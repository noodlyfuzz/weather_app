import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_forecast_post.dart';

class ForecastDataServiceB {
  Future<List<dynamic>?> getPosts() async {
    try {
      final uri = Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&units=metric&appid=6814eeb0575cbbab88a93bf90c1238e6');
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
