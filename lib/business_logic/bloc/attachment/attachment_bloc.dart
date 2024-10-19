// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attachment_event.dart';
part 'attachment_state.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  late StateAgencyRepository stateAgencyRepository;
  AttachmentBloc({required this.stateAgencyRepository})
      : super(AttachmentInitial()) {
    on<AddAttachmentEvent>((event, emit) async {
      emit(AttachmentLoadingProgress());
      try {
        var result = await stateAgencyRepository.postAttachment(
            event.images, event.files, event.type, event.other_attachment_name);

        emit(AttachmentLoadedSuccess(result!));
      } catch (e) {
        emit(AttachmentLoadedFailed(e.toString()));
      }
    });
  }
}
