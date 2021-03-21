//++++++++++++++++++아이디어 노트 이벤트+++++++++++++++++++++//
part of 'idea_note_bloc.dart';

abstract class IdeaEvent extends Equatable {
  const IdeaEvent();

  @override
  List<Object> get props => [];
}

class IdeasLoaded extends IdeaEvent {}

class IdeaAdded extends IdeaEvent {
  final IdeaMemo ideaMemo;

  const IdeaAdded(this.ideaMemo);

  @override
  List<Object> get props => [ideaMemo];

  @override
  String toString() => 'Idea Added { idea: $ideaMemo }';
}

class IdeaUpdated extends IdeaEvent {
  final IdeaMemo ideas;

  const IdeaUpdated(this.ideas);

  @override
  List<Object> get props => [ideas];

  @override
  String toString() => 'Idea Updated { idea: $ideas }';
}

class IdeaDeleted extends IdeaEvent {
  final IdeaMemo ideaMemo;

  const IdeaDeleted(this.ideaMemo);

  @override
  List<Object> get props => [ideaMemo];

  @override
  String toString() => 'Idea Deleted { idea: $ideaMemo }';
}
