part of 'free_write_cubit.dart';

@immutable
abstract class FreeWriteState extends Equatable {
  final List<IdeaMemo> ideaMemo;
  final List<SearchHistory> searchHistory;

  const FreeWriteState({this.ideaMemo, this.searchHistory});

  @override
  List<Object> get props => [ideaMemo, searchHistory];
}

class StateOfIdeasLoading extends FreeWriteState {
  @override
  String toString() => 'Ideas Loading';
}

class StateOfIdeasLoaded extends FreeWriteState {
  final List<IdeaMemo> ideaMemo;
  final List<SearchHistory> searchHistory;

  StateOfIdeasLoaded({this.ideaMemo = const [], this.searchHistory = const []}) : super(ideaMemo: ideaMemo, searchHistory: searchHistory);

  @override
  String toString() => 'StateOfIdeasLoaded { StateOfIdeasLoaded: $ideaMemo , StateOfSearchHistoryLoaded : $searchHistory}';
}

class StateOfIdeasNotLoaded extends FreeWriteState {
  @override
  String toString() => 'StateOfIdeasLoaded NotLoaded';
}
