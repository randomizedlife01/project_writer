part of 're_free_cubit.dart';

@immutable
abstract class FreeWriteState extends Equatable {
  final List<IdeaMemo> ideaMemo;

  const FreeWriteState({this.ideaMemo});

  @override
  List<Object> get props => [ideaMemo];
}

class StateOfIdeasLoading extends FreeWriteState {
  @override
  String toString() => 'TodosLoading';
}

class StateOfIdeasLoaded extends FreeWriteState {
  final List<IdeaMemo> ideaMemo;

  StateOfIdeasLoaded([this.ideaMemo = const []]) : super(ideaMemo: ideaMemo);

  @override
  String toString() => 'StateOfIdeasLoaded { StateOfIdeasLoaded: $ideaMemo }';
}

class StateOfIdeasNotLoaded extends FreeWriteState {
  @override
  String toString() => 'StateOfIdeasLoaded NotLoaded';
}
