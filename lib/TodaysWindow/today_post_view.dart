import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/TodaysWindow/today_post_bloc.dart';
import 'dart:convert';

import 'today_weather_post.dart';

class PostsView extends StatelessWidget {
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
            return RefreshIndicator(
              onRefresh: () async =>
                  BlocProvider.of<PostsBloc>(context).add(PullToRefreshEvent()),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 70),
                      Container(
                        child: Text('${state.post!.current.city.name}'
                            ' ${state.post!.current.city.country.t}'
                            '\n'
                            ' ${state.post!.current.temperature.value} | '
                            ' ${state.post!.current.weather.value}'),
                      ),
                      SizedBox(height: 100),
                      Container(
                        child: Text('${state.post!.current.humidity.value} %  '
                            '  precipitation ? ${state.post!.current.precipitation.value} mm    '
                            ' ${state.post!.current.pressure.value} hPa'
                            '\n'
                            ' ${(double.parse(state.post!.current.wind.speed.value) * 3.6).round()} km/h     '
                            '  wind direction?  ${state.post!.current.wind.direction.code}'),
                      ),
                      SizedBox(height: 600),
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
