part of 'idea_note_bloc.dart';

abstract class IdeaState extends Equatable {
  const IdeaState();

  @override
  List<Object> get props => [];
}

class IdeaLoading extends IdeaState {}

class IdeaLoaded extends IdeaState {
  final List<IdeaMemo> ideaMemo;

  const IdeaLoaded([this.ideaMemo = const []]);

  @override
  List<Object> get props => [ideaMemo];

  @override
  String toString() => 'Idea Load Success { Idea: $ideaMemo }';
}

class IdeaError extends IdeaState {}
