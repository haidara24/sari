part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoadingProgress extends PostState {}

class PostLoadedSuccess extends PostState {
  final List<Post> posts;

  const PostLoadedSuccess(this.posts);
}

class PostLoadedFailed extends PostState {}
