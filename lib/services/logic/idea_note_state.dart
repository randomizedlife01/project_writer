part of 'idea_note_bloc.dart';

abstract class IdeaState extends Equatable {
  const IdeaState();

  @override
  List<Object> get props => [];
}

class IdeaLoadingInProgress extends IdeaState {}

class IdeasLoadSuccess extends IdeaState {
  final List<IdeaMemo> ideaMemo;
  final List<SearchTags> tags;

  const IdeasLoadSuccess({this.ideaMemo, this.tags});

  @override
  List<Object> get props => [ideaMemo, tags];

  @override
  String toString() => 'Idea Load Success { Idea: $ideaMemo }, Tag LoadSuccess { Tags : $tags }';
}

class IdeaError extends IdeaState {}
