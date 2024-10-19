import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/models/package_model.dart' as package;
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  late StateAgencyRepository stateAgencyRepository;
  OfferBloc({required this.stateAgencyRepository}) : super(OfferInitial()) {
    on<OfferInit>(
      (event, emit) => emit(OfferInitial()),
    );
    on<AddOfferEvent>((event, emit) async {
      emit(OfferLoadingProgress());
      try {
        var data = await stateAgencyRepository.postOffer(
          event.offerType,
          event.broker,
          event.packageNum,
          event.tabalehNum,
          event.weight,
          event.price,
          event.taxes,
          event.rawmaterial,
          event.industrial,
          event.brands,
          event.tubes,
          event.colored,
          event.lycra,
          event.totalweight,
          event.totalprice,
          event.totaltaxes,
          event.expectedDate,
          event.notes,
          event.costumeAgency,
          event.costumeState,
          event.products,
          event.source,
          event.origin,
          event.packageType,
          event.attachments,
        );
        if (data != null) {
          emit(OfferLoadedSuccess(data));
        } else {
          emit(const OfferLoadedFailed("error"));
        }
      } catch (e) {
        emit(OfferLoadedFailed(e.toString()));
      }
    });

    on<OfferLoadEvent>(
      (event, emit) async {
        emit(OfferListLoadingProgress());
        try {
          var data = await stateAgencyRepository.getBrokerOffers();
          emit(OfferListLoadedSuccess(data));
        } catch (e) {
          emit(OfferLoadedFailed(e.toString()));
        }
      },
    );

    on<OfferStatusUpdateEvent>(
      (event, emit) async {
        OfferListLoadedSuccess currentState = state as OfferListLoadedSuccess;
        emit(OfferListLoadingProgress());
        try {
          var data = await stateAgencyRepository.updateOfferState(
              event.state, event.offerId);
          if (data) {
            emit(OfferListLoadedSuccess(currentState.offers));
          } else {
            emit(const OfferLoadedFailed("خطأ"));
          }
        } catch (e) {
          emit(OfferLoadedFailed(e.toString()));
        }
      },
    );

    // on<AddAdditionalAttachmentEvent>(
    //   (event, emit) async {
    //     OfferListLoadedSuccess currentState = state as OfferListLoadedSuccess;
    //     emit(OfferListLoadingProgress());
    //     try {
    //       var data =
    //           await stateAgencyRepository.updateOfferAditionalAttachments(
    //               event.attachments, event.additionalList, event.offerId);
    //       if (data) {
    //         emit(OfferListLoadedSuccess(currentState.offers));
    //       } else {
    //         emit(OfferLoadedFailed("خطأ"));
    //       }
    //     } catch (e) {
    //       print('error');
    //       emit(OfferLoadedFailed(e.toString()));
    //     }
    //   },
    // );
  }
}
