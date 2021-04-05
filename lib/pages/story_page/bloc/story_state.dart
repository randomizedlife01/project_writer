part of 'story_bloc.dart';

@immutable
abstract class StorySummaryState extends Equatable {
  final List<StorySummary> storySummaries;
  final bool isVisible;

  const StorySummaryState({this.storySummaries, this.isVisible});

  @override
  List<Object> get props => [storySummaries, isVisible];
}

class StorySummaryLoading extends StorySummaryState {
  @override
  String toString() => 'StorySummary Loading';
}

class StorySummaryLoaded extends StorySummaryState {
  final List<StorySummary> storySummaries;
  final bool isVisible;

  StorySummaryLoaded({this.storySummaries = const [], this.isVisible = false})
      : super(storySummaries: storySummaries, isVisible: isVisible);

  @override
  String toString() => 'StorySummary Loaded { Document Loaded: $storySummaries}';
}

class StorySummaryNotLoaded extends StorySummaryState {
  @override
  String toString() => 'StorySummary NotLoaded';
}
