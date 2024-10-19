import 'package:custome_mobile/constants/enums.dart';
import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  late AccordionRepository accordionRepository;
  NoteBloc({required this.accordionRepository}) : super(NoteInitial()) {
    on<NoteLoadEvent>((event, emit) async {
      emit(NoteLoadingProgress());
      try {
        var notes = await accordionRepository.getNotes(event.id, event.type);
        emit(NoteLoadedSuccess(notes));
      } catch (e) {
        emit(NoteLoadedFailed(e.toString()));
      }
    });
  }
}
