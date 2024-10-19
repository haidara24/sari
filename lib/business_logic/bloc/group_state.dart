part of 'group_bloc.dart';

class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoadingProgress extends GroupState {}

class GroupListLoadedSuccess extends GroupState {
  final List<Group> groups;

  const GroupListLoadedSuccess(this.groups);
}

class GroupLoadedFailed extends GroupState {
  final String errortext;

  const GroupLoadedFailed(this.errortext);
}

class PostUnsavedSuccessfully extends GroupState {}
