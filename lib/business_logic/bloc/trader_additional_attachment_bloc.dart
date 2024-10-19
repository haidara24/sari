// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trader_additional_attachment_event.dart';
part 'trader_additional_attachment_state.dart';

class TraderAdditionalAttachmentBloc extends Bloc<
    TraderAdditionalAttachmentEvent, TraderAdditionalAttachmentState> {
  late StateAgencyRepository stateAgencyRepository;
  TraderAdditionalAttachmentBloc({required this.stateAgencyRepository})
      : super(TraderAdditionalAttachmentInitial()) {
    on<AddAdditionalAttachmentEvent>((event, emit) async {
      emit(TraderAdditionalAttachmentLoadingProgress());
      try {
        var result = await stateAgencyRepository.postAttachment(
            event.images, event.files, event.type, event.otherAttachName);
        List<Attachment> attachments = [];
        attachments = [];
        attachments.add(result!);
        List<int> newattachments = event.attachments;
        newattachments.add(result.id!);

        List<int> newaddattachments = [];
        for (var element in event.additionalattachments) {
          newaddattachments.add(element.id!);
        }
        newaddattachments.remove(event.type);

        // ignore: unused_local_variable
        var offer = await stateAgencyRepository.updateOfferAditionalAttachments(
            newattachments, newaddattachments, event.offerId);
        List<AttachmentType> newAdditional = event.additionalattachments;
        for (var element in newAdditional) {
          if (element.id! == event.type) {
            newAdditional.remove(element);
            break;
          }
        }
        emit(TraderAdditionalAttachmentLoadedSuccess(
            result, attachments, newAdditional));
      } catch (e) {
        emit(TraderAdditionalAttachmentLoadedFailed(e.toString()));
      }
    });
    on<ClearAdditionalAttachmentEvent>(
      (event, emit) {
        TraderAdditionalAttachmentLoadedSuccess currentState =
            state as TraderAdditionalAttachmentLoadedSuccess;

        emit(TraderAdditionalAttachmentLoadedSuccess(
            currentState.attachment, const [], currentState.attachmentTypes));
      },
    );
  }
}
