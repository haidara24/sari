part of 'trader_additional_attachment_bloc.dart';

class TraderAdditionalAttachmentEvent extends Equatable {
  const TraderAdditionalAttachmentEvent();

  @override
  List<Object> get props => [];
}

class AddAdditionalAttachmentEvent extends TraderAdditionalAttachmentEvent {
  final AttachmentType type;
  final List<File> images;
  final List<File> files;
  final int offerId;
  final String offerState;
  final String otherAttachName;
  final List<int> attachments;
  final List<AttachmentType> additionalattachments;

  AddAdditionalAttachmentEvent(
      this.type,
      this.images,
      this.files,
      this.offerId,
      this.offerState,
      this.otherAttachName,
      this.attachments,
      this.additionalattachments);
}

class ClearAdditionalAttachmentEvent extends TraderAdditionalAttachmentEvent {}
