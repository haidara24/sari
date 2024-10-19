part of 'additional_attachment_bloc.dart';

class AdditionalAttachmentEvent extends Equatable {
  const AdditionalAttachmentEvent();

  @override
  List<Object> get props => [];
}

class SubmitAdditionalAttachmentEvent extends AdditionalAttachmentEvent {
  final List<int> additionalList;
  final List<int> attachments;
  final int offerId;

  SubmitAdditionalAttachmentEvent(
      this.attachments, this.additionalList, this.offerId);
}
