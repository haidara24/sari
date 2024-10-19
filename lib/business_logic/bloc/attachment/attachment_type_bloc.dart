import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attachment_type_event.dart';
part 'attachment_type_state.dart';

class AttachmentTypeBloc
    extends Bloc<AttachmentTypeEvent, AttachmentTypeState> {
  late StateAgencyRepository stateAgencyRepository;
  AttachmentTypeBloc({required this.stateAgencyRepository})
      : super(AttachmentTypeInitial()) {
    on<AttachmentTypeLoadEvent>((event, emit) async {
      emit(AttachmentTypeLoadingProgress());
      try {
        var attachmentTypes = await stateAgencyRepository.getAttachmentTypes();
        emit(AttachmentTypeLoadedSuccess(attachmentTypes));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
