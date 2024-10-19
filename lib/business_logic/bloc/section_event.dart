part of 'section_bloc.dart';

abstract class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object> get props => [];
}

class SectionLoadEvent extends SectionEvent {}

class SectionSelectedEvent extends SectionEvent {
  final Section section;
  final List<Chapter> chapters;
  const SectionSelectedEvent(this.section, this.chapters);
}
