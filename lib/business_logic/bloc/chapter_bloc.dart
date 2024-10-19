import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chapter_event.dart';
part 'chapter_state.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  late AccordionRepository accordionRepository;
  ChapterBloc({required this.accordionRepository}) : super(ChapterInitial()) {
    on<ChapterLoadEvent>((event, emit) async {
      emit(ChapterLoadingProgress());
      try {
        var chapters = await accordionRepository.getChapters(event.sectionId);
        emit(ChapterLoadedSuccess(chapters));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
