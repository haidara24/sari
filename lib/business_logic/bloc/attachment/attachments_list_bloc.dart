import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attachments_list_event.dart';
part 'attachments_list_state.dart';

class AttachmentsListBloc
    extends Bloc<AttachmentsListEvent, AttachmentsListState> {
  AttachmentsListBloc() : super(AttachmentsListInitial()) {
    on<AddAttachmentToListEvent>((event, emit) {
      if (state is AttachmentsListInitial) {
        emit(AttachmentsListLoadingProgress());
        List<Attachment> attachments = [];
        attachments.add(event.attachment);
        emit(AttachmentsListSucess(attachments));
      } else {
        AttachmentsListSucess currentState = state as AttachmentsListSucess;
        emit(AttachmentsListLoadingProgress());
        List<Attachment> attachments = currentState.attachments;
        attachments.add(event.attachment);
        emit(AttachmentsListSucess(attachments));
      }
    });
    on<ClearAttachmentToListEvent>((event, emit) {
      emit(AttachmentsListLoadingProgress());
      emit(const AttachmentsListSucess([]));
    });
  }
}
