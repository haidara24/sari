import 'package:custome_mobile/data/models/post_model.dart';
import 'package:custome_mobile/data/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  late PostRepository postRepository;
  GroupBloc({required this.postRepository}) : super(GroupInitial()) {
    on<GroupLoadEvent>((event, emit) async {
      emit(GroupLoadingProgress());
      try {
        var groups = await postRepository.getgroups();
        emit(GroupListLoadedSuccess(groups));
      } catch (e) {
        emit(GroupLoadedFailed(e.toString()));
      }
    });

    on<GroupAddEvent>(
      (event, emit) async {
        GroupListLoadedSuccess currentstate = state as GroupListLoadedSuccess;
        emit(GroupLoadingProgress());
        try {
          var group = await postRepository.addGroup(event.name);
          if (group != null) {
            var groups = currentstate.groups;
            groups.add(group);
            emit(GroupListLoadedSuccess(groups));
          } else {
            emit(const GroupLoadedFailed("errortext"));
          }
        } catch (e) {
          emit(GroupLoadedFailed(e.toString()));
        }
      },
    );

    on<SavePostEvent>(
      (event, emit) async {
        GroupListLoadedSuccess currentstate = state as GroupListLoadedSuccess;
        emit(GroupLoadingProgress());
        try {
          var savedpost =
              await postRepository.addSavedPost(event.postId, event.groupId);
          if (savedpost != null) {
            var groups = currentstate.groups;
            emit(GroupListLoadedSuccess(groups));
          } else {
            emit(const GroupLoadedFailed("errortext"));
          }
        } catch (e) {
          emit(GroupLoadedFailed(e.toString()));
        }
      },
    );

    on<UnSavePostEvent>(
      (event, emit) async {
        GroupListLoadedSuccess currentstate = state as GroupListLoadedSuccess;
        emit(GroupLoadingProgress());
        try {
          var savedpost = await postRepository.unSavePost(event.postId);
          if (savedpost) {
            emit(PostUnsavedSuccessfully());
            var groups = currentstate.groups;
            emit(GroupListLoadedSuccess(groups));
          } else {
            emit(const GroupLoadedFailed("errortext"));
          }
        } catch (e) {
          emit(GroupLoadedFailed(e.toString()));
        }
      },
    );
  }
}
