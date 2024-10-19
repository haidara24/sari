part of 'search_section_bloc.dart';

class SearchSectionEvent extends Equatable {
  const SearchSectionEvent();

  @override
  List<Object> get props => [];
}

class SearchSectionLoadEvent extends SearchSectionEvent {
  final String query;

  SearchSectionLoadEvent(this.query);
}
