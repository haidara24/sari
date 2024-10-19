part of 'attachments_list_bloc.dart';

class AttachmentsListEvent extends Equatable {
  const AttachmentsListEvent();

  @override
  List<Object> get props => [];
}

class AddAttachmentToListEvent extends AttachmentsListEvent {
  final Attachment attachment;

  const AddAttachmentToListEvent(this.attachment);
}

class ClearAttachmentToListEvent extends AttachmentsListEvent {}
