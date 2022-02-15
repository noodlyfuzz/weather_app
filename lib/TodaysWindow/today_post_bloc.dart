import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/TodaysWindow/today_data_service.dart';
import 'today_weather_post.dart';

abstract class TodayPostsEvent {}

class LoadPostsEvent extends TodayPostsEvent {}

class PullToRefreshEvent extends TodayPostsEvent {}

abstract class PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  dynamic post;
  LoadedPostsState({this.post});
}

class FailedToLoadPostsState extends PostsState {
  Error? error;
  FailedToLoadPostsState({this.error});
}

class PostsBloc extends Bloc<TodayPostsEvent, PostsState> {
  final _dataService = TodayDataService();

  PostsBloc() : super(LoadingPostsState());

  @override
  Stream<PostsState> mapEventToState(TodayPostsEvent event) async* {
    if (event is LoadPostsEvent || event is PullToRefreshEvent) {
      yield LoadingPostsState();

      try {
        final post = await _dataService.getPosts();
        yield LoadedPostsState(post: post);
      } catch (e) {
        yield FailedToLoadPostsState(error: e as Error);
      }
    }
  }
}
