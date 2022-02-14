import 'dart:convert';
import 'package:http/http.dart' as http;
import 'today_weather_post.dart';
import 'package:xml2json/xml2json.dart';

class ForecastDataServiceB {
  Future<dynamic>? getPosts() async {
    try {
      final uri = Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&units=metric&mode=xml&appid=6814eeb0575cbbab88a93bf90c1238e6');
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
