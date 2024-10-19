part of 'attachment_type_bloc.dart';

class AttachmentTypeState extends Equatable {
  const AttachmentTypeState();

  @override
  List<Object> get props => [];
}

class AttachmentTypeInitial extends AttachmentTypeState {}

class AttachmentTypeLoadingProgress extends AttachmentTypeState {}

class AttachmentTypeLoadedSuccess extends AttachmentTypeState {
  final List<AttachmentType> attachmentTypes;

  const AttachmentTypeLoadedSuccess(this.attachmentTypes);
}

class AttachmentTypeLoadedFailed extends AttachmentTypeState {
  final String errortext;

  const AttachmentTypeLoadedFailed(this.errortext);
}
