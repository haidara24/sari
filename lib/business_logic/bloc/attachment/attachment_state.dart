part of 'attachment_bloc.dart';

class AttachmentState extends Equatable {
  const AttachmentState();

  @override
  List<Object> get props => [];
}

class AttachmentInitial extends AttachmentState {}

class AttachmentLoadingProgress extends AttachmentState {}

class AttachmentLoadedSuccess extends AttachmentState {
  final Attachment attachment;

  const AttachmentLoadedSuccess(this.attachment);
}

class AttachmentLoadedFailed extends AttachmentState {
  final String errortext;

  const AttachmentLoadedFailed(this.errortext);
}
