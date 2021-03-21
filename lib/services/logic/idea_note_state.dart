part of 'idea_note_bloc.dart';

abstract class IdeaState extends Equatable {
  const IdeaState();

  @override
  List<Object> get props => [];
}

class IdeaLoadingInProgress extends IdeaState {}

class IdeasLoadSuccess extends IdeaState {
  final List<IdeaMemo> ideaMemo;

  const IdeasLoadSuccess([this.ideaMemo = const []]);

  @override
  List<Object> get props => [ideaMemo];

  @override
  String toString() => 'Idea Load Success { Idea: $ideaMemo }';
}

class IdeaError extends IdeaState {}
