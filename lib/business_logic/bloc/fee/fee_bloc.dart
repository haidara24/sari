import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fee_event.dart';
part 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  late AccordionRepository accordionRepository;
  FeeBloc({required this.accordionRepository}) : super(FeeInitial()) {
    on<FeeLoadEvent>((event, emit) async {
      emit(FeeLoadingProgress());
      try {
        var fees = await accordionRepository.getFees(event.subchapterId);
        emit(FeeLoadedSuccess(fees));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
