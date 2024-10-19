part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostLoadEvent extends PostEvent {}

class PostSaveEvent extends PostEvent {
  final int postId;
  final bool save;

  const PostSaveEvent(this.postId, this.save);
}
