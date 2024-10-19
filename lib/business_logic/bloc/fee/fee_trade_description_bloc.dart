import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fee_trade_description_event.dart';
part 'fee_trade_description_state.dart';

class FeeTradeDescriptionBloc
    extends Bloc<FeeTradeDescriptionEvent, FeeTradeDescriptionState> {
  late AccordionRepository accordionRepository;
  FeeTradeDescriptionBloc({required this.accordionRepository})
      : super(FeeTradeDescriptionInitial()) {
    on<FeeTradeDescriptionLoadEvent>((event, emit) async {
      emit(FeeTradeDescriptionLoadingProgress());
      try {
        var fees =
            await accordionRepository.getFeeTradeDescription(event.feeId);
        if (fees != null) {
          emit(FeeTradeDescriptionLoadedSuccess(fees));
        } else {
          emit(const FeeTradeDescriptionLoadedFailed("error"));
        }
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
