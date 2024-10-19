part of 'group_bloc.dart';

class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GroupLoadEvent extends GroupEvent {}

class GroupAddEvent extends GroupEvent {
  final String name;

  const GroupAddEvent(this.name);
}

class SavePostEvent extends GroupEvent {
  final int postId;
  final int groupId;

  const SavePostEvent(this.postId, this.groupId);
}

class UnSavePostEvent extends GroupEvent {
  final int postId;

  const UnSavePostEvent(this.postId);
}
