part of 'saved_post_bloc.dart';

class SavedPostState extends Equatable {
  const SavedPostState();

  @override
  List<Object> get props => [];
}

class SavedPostInitial extends SavedPostState {}

class SavedPostLoadingProgress extends SavedPostState {}

class SavedPostListLoadedSuccess extends SavedPostState {
  final List<SavedPost> savedPosts;

  const SavedPostListLoadedSuccess(this.savedPosts);
}

class SavedPostLoadedFailed extends SavedPostState {
  final String errortext;

  const SavedPostLoadedFailed(this.errortext);
}
