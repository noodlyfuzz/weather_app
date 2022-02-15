import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/ForecastWindow/forecast_data_service.dart';
import 'weather_forecast_post.dart';

abstract class ForecastPostsEvent {}

class LoadPostsEvent extends ForecastPostsEvent {}

class PullToRefreshEvent extends ForecastPostsEvent {}

abstract class PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  List<dynamic>? posts;
  LoadedPostsState({this.posts});
}

class FailedToLoadPostsState extends PostsState {
  Error? error;
  FailedToLoadPostsState({this.error});
}

class PostsBloc extends Bloc<ForecastPostsEvent, PostsState> {
  final _dataService = ForecastDataService();

  PostsBloc() : super(LoadingPostsState());

  @override
  Stream<PostsState> mapEventToState(ForecastPostsEvent event) async* {
    if (event is LoadPostsEvent || event is PullToRefreshEvent) {
      yield LoadingPostsState();

      try {
        final posts = await _dataService.getPosts();
        yield LoadedPostsState(posts: posts);
      } catch (e) {
        yield FailedToLoadPostsState(error: e as Error);
      }
    }
  }
}
