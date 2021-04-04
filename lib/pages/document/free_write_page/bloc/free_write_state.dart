part of 'free_write_bloc.dart';

@immutable
abstract class FreeWriteState extends Equatable {
  final List<IdeaMemo> ideaMemo;
  final List<SearchHistory> searchHistory;

  const FreeWriteState({this.ideaMemo, this.searchHistory});

  @override
  List<Object> get props => [ideaMemo, searchHistory];
}

class FreeWriteLoading extends FreeWriteState {
  @override
  String toString() => 'Ideas Loading';
}

class FreeWriteLoaded extends FreeWriteState {
  final List<IdeaMemo> ideaMemo;
  final List<SearchHistory> searchHistory;

  FreeWriteLoaded({this.ideaMemo = const [], this.searchHistory = const []}) : super(ideaMemo: ideaMemo, searchHistory: searchHistory);

  @override
  String toString() => 'StateOfIdeasLoaded { StateOfIdeasLoaded: $ideaMemo , StateOfSearchHistoryLoaded : $searchHistory}';
}

class FreeWriteNotLoaded extends FreeWriteState {
  @override
  String toString() => 'StateOfIdeasLoaded NotLoaded';
}
