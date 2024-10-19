part of 'saved_post_bloc.dart';

class SavedPostEvent extends Equatable {
  const SavedPostEvent();

  @override
  List<Object> get props => [];
}

class SavedPostLoadEvent extends SavedPostEvent {
  final int groupId;

  const SavedPostLoadEvent(this.groupId);
}
