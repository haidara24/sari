part of 'attachments_list_bloc.dart';

class AttachmentsListState extends Equatable {
  const AttachmentsListState();

  @override
  List<Object> get props => [];
}

class AttachmentsListInitial extends AttachmentsListState {}

class AttachmentsListLoadingProgress extends AttachmentsListState {}

class AttachmentsListSucess extends AttachmentsListState {
  final List<Attachment> attachments;

  const AttachmentsListSucess(this.attachments);
}
