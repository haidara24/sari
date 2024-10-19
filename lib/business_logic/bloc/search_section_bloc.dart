import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_section_event.dart';
part 'search_section_state.dart';

class SearchSectionBloc extends Bloc<SearchSectionEvent, SearchSectionState> {
  late AccordionRepository accordionRepository;
  SearchSectionBloc({required this.accordionRepository})
      : super(SearchSectionInitial()) {
    on<SearchSectionLoadEvent>((event, emit) async {
      emit(SearchSectionLoading());
      try {
        var sections = await accordionRepository.searchForItem(event.query);
        emit(SearchSectionLoadedSuccess(sections));
        // ignore: empty_catches
      } catch (e) {
        emit(SearchSectionLoadedFailed(e.toString()));
      }
    });
  }
}
