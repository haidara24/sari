import 'package:custome_mobile/data/models/post_model.dart';
import 'package:custome_mobile/data/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'saved_post_event.dart';
part 'saved_post_state.dart';

class SavedPostBloc extends Bloc<SavedPostEvent, SavedPostState> {
  late PostRepository postRepository;
  SavedPostBloc({required this.postRepository}) : super(SavedPostInitial()) {
    on<SavedPostLoadEvent>((event, emit) async {
      emit(SavedPostLoadingProgress());
      try {
        var savedposts = await postRepository.getsavedPosts(event.groupId);
        emit(SavedPostListLoadedSuccess(savedposts));
      } catch (e) {
        emit(SavedPostLoadedFailed(e.toString()));
      }
    });
  }
}
