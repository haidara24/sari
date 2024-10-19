// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_section_bloc.dart';

class SearchSectionState extends Equatable {
  const SearchSectionState();

  @override
  List<Object> get props => [];
}

class SearchSectionInitial extends SearchSectionState {}

class SearchSectionLoading extends SearchSectionState {}

class SearchSectionLoadedSuccess extends SearchSectionState {
  final List<Section?> sections;
  SearchSectionLoadedSuccess(this.sections);
}

class SearchSectionLoadedFailed extends SearchSectionState {
  final String error;
  SearchSectionLoadedFailed(this.error);
}
