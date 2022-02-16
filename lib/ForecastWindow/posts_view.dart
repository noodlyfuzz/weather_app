import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/ForecastWindow/posts_bloc.dart';
import 'package:weather_app/Theme/weather_conditions.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'weather_forecast_post.dart';

class PostsView extends StatelessWidget {
  WeatherConditions? wc = WeatherConditions();

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
              child: ListView.builder(
                  itemCount: state.posts!.length,
                  itemBuilder: (context, index) {
                    DateFormat df = DateFormat.Hm();
                    DateTime dt = state.posts![index].dtTxt;
                    return Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                  '${wc!.getWeatherCondition(int.parse('${state.posts![index].weather[0].id}'))}'),
                            ),
                            Text('${df.format(dt)}'
                                // '${dt.hour}:${dt.minute} \n'
                                ' ${state.posts![index].main.temp.toInt()}'
                                ' ${state.posts![index].weather[0].description}'),
                          ],
                        ),
                      ),
                    );
                  }),
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
