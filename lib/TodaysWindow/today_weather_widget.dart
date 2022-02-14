import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/TodaysWindow/today_post_bloc.dart';
import 'package:weather_app/TodaysWindow/today_post_view.dart';

class TodayWeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodayWeatherWidgetState();
}

class _TodayWeatherWidgetState extends State<TodayWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<PostsBloc>(
            create: (context) => PostsBloc()..add(LoadPostsEvent()),
            child: PostsView()));
  }
}
