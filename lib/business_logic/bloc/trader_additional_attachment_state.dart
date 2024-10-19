part of 'trader_additional_attachment_bloc.dart';

class TraderAdditionalAttachmentState extends Equatable {
  const TraderAdditionalAttachmentState();

  @override
  List<Object> get props => [];
}

class TraderAdditionalAttachmentInitial
    extends TraderAdditionalAttachmentState {}

class TraderAdditionalAttachmentLoadingProgress
    extends TraderAdditionalAttachmentState {}

class TraderAdditionalAttachmentLoadedSuccess
    extends TraderAdditionalAttachmentState {
  final Attachment attachment;
  final List<Attachment> attachments;
  final List<AttachmentType> attachmentTypes;

  const TraderAdditionalAttachmentLoadedSuccess(
      this.attachment, this.attachments, this.attachmentTypes);
}

class TraderAdditionalAttachmentLoadedFailed
    extends TraderAdditionalAttachmentState {
  final String errortext;

  const TraderAdditionalAttachmentLoadedFailed(this.errortext);
}
