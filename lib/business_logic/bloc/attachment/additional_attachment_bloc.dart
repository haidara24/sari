// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'additional_attachment_event.dart';
part 'additional_attachment_state.dart';

class AdditionalAttachmentBloc
    extends Bloc<AdditionalAttachmentEvent, AdditionalAttachmentState> {
  late StateAgencyRepository stateAgencyRepository;
  AdditionalAttachmentBloc({required this.stateAgencyRepository})
      : super(AdditionalAttachmentInitial()) {
    on<SubmitAdditionalAttachmentEvent>(
      (event, emit) async {
        // AdditionalAttachmentLoadedSuccess currentState = state as AdditionalAttachmentLoadedSuccess;
        emit(AdditionalAttachmentLoadingProgress());
        try {
          var data =
              await stateAgencyRepository.updateOfferAditionalAttachments(
                  event.attachments, event.additionalList, event.offerId);
          if (data) {
            emit(BrokerAdditionalAttachmentLoadedSuccess());
          } else {
            emit(const AdditionalAttachmentLoadedFailed("خطأ"));
          }
        } catch (e) {
          emit(AdditionalAttachmentLoadedFailed(e.toString()));
        }
      },
    );
  }
}
