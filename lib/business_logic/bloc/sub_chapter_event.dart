part of 'sub_chapter_bloc.dart';

abstract class SubChapterEvent extends Equatable {
  const SubChapterEvent();

  @override
  List<Object> get props => [];
}

class SubChapterLoadEvent extends SubChapterEvent {
  final String chapterId;

  const SubChapterLoadEvent(this.chapterId);
}
