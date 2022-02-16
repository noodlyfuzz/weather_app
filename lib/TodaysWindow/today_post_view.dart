import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Theme/weather_conditions.dart';
import 'package:weather_app/TodaysWindow/today_post_bloc.dart';
import 'package:share_plus/share_plus.dart';

class PostsView extends StatelessWidget {
  String? country;
  String? city;
  String? currentTemperature;
  String? weather;
  String? humidity;
  String? precipitation;
  String? pressure;
  String? windSpeed;
  String? windDirection;
  String? weatherCondition;
  WeatherConditions? wc = WeatherConditions();
// FittedBox(child: Image.asset('assets/images/background/wallpaper1')),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPostsState) {
            city = '${state.post!.current.city.name}';
            country = '${state.post!.current.city.country.t}';
            currentTemperature =
                '${double.parse(state.post!.current.temperature.value).toStringAsFixed(1)} °C';
            weather = '${state.post!.current.weather.value}';
            humidity = '${state.post!.current.humidity.value} %';
            precipitation = '${state.post!.current.precipitation.value} mm';
            pressure = '${state.post!.current.pressure.value} hPa';
            windSpeed =
                '${(double.parse(state.post!.current.wind.speed.value) * 3.6).round()} km/h';
            windDirection = '${state.post!.current.wind.direction.code}';
            weatherCondition = '${state.post!.current.weather.number}';

            return RefreshIndicator(
              onRefresh: () async =>
                  BlocProvider.of<PostsBloc>(context).add(PullToRefreshEvent()),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 70),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                            '${wc!.getWeatherCondition(int.parse(weatherCondition!))}'),
                      ),
                      Container(
                        child: Text('${country}'
                            ' ${city}'
                            '\n'
                            ' ${currentTemperature}'
                            ' ${weather}'),
                      ),
                      SizedBox(height: 100),
                      Container(
                        child: Text('${humidity}'
                            '${precipitation}'
                            ' ${pressure}'
                            '\n'
                            '${windSpeed}'
                            '${windDirection}'),
                      ),
                      SizedBox(height: 300),
                      ElevatedButton(
                          onPressed: () async {
                            await Share.share('Location is ${city}, ${country} \n The weather for today is:' +
                                ' \n  Temperature: ${currentTemperature}, outside is ${weather}.' +
                                ' Humidity is ${humidity}, precipitation is ${precipitation} ' +
                                'and atmospheric pressure about  ${pressure}. ' +
                                'Wind speed is ${windSpeed} with ${windDirection} direction.');
                          },
                          child: Text('Share')),
                      SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is FailedToLoadPostsState) {
            return Center(
              child: Text('Error occured: ${state.error}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
