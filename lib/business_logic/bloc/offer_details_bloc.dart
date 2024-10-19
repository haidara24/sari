import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';

part 'offer_details_event.dart';
part 'offer_details_state.dart';

class OfferDetailsBloc extends Bloc<OfferDetailsEvent, OfferDetailsState> {
  late NotificationRepository notificationRepository;
  OfferDetailsBloc({required this.notificationRepository})
      : super(OfferDetailsInitial()) {
    on<OfferDetailsLoadEvent>((event, emit) async {
      emit(OfferDetailsLoadingProgress());
      try {
        var data = await notificationRepository.getOfferInfo(event.id);
        emit(OfferDetailsLoadedSuccess(data!));
      } catch (e) {
        emit(OfferDetailsLoadedFailed(e.toString()));
      }
    });
  }
}
