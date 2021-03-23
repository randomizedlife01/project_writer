//++++++++++++++++++태그 이벤트+++++++++++++++++++++//

part of 'idea_tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class TagsLoadInProgress extends TagsEvent {}

class TagsLoaded extends TagsEvent {
  final List<SearchTags> tags;

  const TagsLoaded(this.tags);

  @override
  List<Object> get props => [tags];

  @override
  String toString() => 'tags { tags: $tags }';
}

class TagAdded extends TagsEvent {
  final SearchTags tag;

  const TagAdded(this.tag);

  @override
  List<Object> get props => [tag];

  @override
  String toString() => 'tag Added { tag: $tag }';
}

class TagUpdated extends TagsEvent {
  final SearchTags tag;

  const TagUpdated(this.tag);

  @override
  List<Object> get props => [tag];

  @override
  String toString() => 'tag Updated { tag: $tag }';
}

class TagDeleted extends TagsEvent {
  final SearchTags tag;

  const TagDeleted(this.tag);

  @override
  List<Object> get props => [tag];

  @override
  String toString() => 'tag Deleted { tag: $tag }';
}

class UpdateIdeaInTagsModel extends TagsEvent {
  final List<IdeaMemo> ideas;

  const UpdateIdeaInTagsModel(this.ideas);

  @override
  List<Object> get props => [ideas];

  @override
  String toString() => 'Update ideas { ideas: $ideas }';
}
