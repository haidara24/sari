part of 'additional_attachment_bloc.dart';

class AdditionalAttachmentState extends Equatable {
  const AdditionalAttachmentState();

  @override
  List<Object> get props => [];
}

class AdditionalAttachmentInitial extends AdditionalAttachmentState {}

class AdditionalAttachmentLoadingProgress extends AdditionalAttachmentState {}

class AdditionalAttachmentLoadedSuccess extends AdditionalAttachmentState {
  final Attachment attachment;
  final List<Attachment> attachments;
  final List<AttachmentType> attachmentTypes;

  const AdditionalAttachmentLoadedSuccess(
      this.attachment, this.attachments, this.attachmentTypes);
}

class AdditionalAttachmentLoadedFailed extends AdditionalAttachmentState {
  final String errortext;

  const AdditionalAttachmentLoadedFailed(this.errortext);
}

class BrokerAdditionalAttachmentLoadedSuccess
    extends AdditionalAttachmentState {
  // final Attachment attachment;
  // final List<Attachment> attachments;
  // final List<AttachmentType> attachmentTypes;
}
