part of 'sub_chapter_bloc.dart';

abstract class SubChapterState extends Equatable {
  const SubChapterState();

  @override
  List<Object> get props => [];
}

class SubChapterInitial extends SubChapterState {}

class SubChapterLoadingProgress extends SubChapterState {}

class SubChapterLoadedSuccess extends SubChapterState {
  final List<SubChapter> subchapters;

  const SubChapterLoadedSuccess(this.subchapters);
}

class SubChapterLoadedFailed extends SubChapterState {
  final String errortext;

  const SubChapterLoadedFailed(this.errortext);
}
