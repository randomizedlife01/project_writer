part of 're_search_cubit.dart';

@immutable
abstract class SearchState extends Equatable {
  final List<> searchHistory;

  const SearchState({this.searchHistory});

  @override
  List<Object> get props => [searchHistory];
}

class StateOfSearchLoading extends SearchState {
  @override
  String toString() => 'SearchHistory Loading';
}

class StateOfSearchLoaded extends SearchState {
  final List<SearchHistory> searchHistory;

  StateOfSearchLoaded([this.searchHistory = const []]) : super(searchHistory: searchHistory);

  @override
  String toString() => 'SearchHistory { SearchHistory: $searchHistory }';
}

class StateOfSearchNotLoaded extends SearchState {
  @override
  String toString() => 'SearchHistory NotLoaded';
}
