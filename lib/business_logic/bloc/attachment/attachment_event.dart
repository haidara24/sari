part of 'attachment_bloc.dart';

class AttachmentEvent extends Equatable {
  const AttachmentEvent();

  @override
  List<Object> get props => [];
}

class AddAttachmentEvent extends AttachmentEvent {
  final AttachmentType type;
  final String other_attachment_name;
  final List<File> images;
  final List<File> files;

  AddAttachmentEvent(
      this.type, this.other_attachment_name, this.images, this.files);
  // final File file;
}
