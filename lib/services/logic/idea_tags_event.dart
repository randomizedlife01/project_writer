//++++++++++++++++++태그 이벤트+++++++++++++++++++++//

import 'package:equatable/equatable.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/SearchTags.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class TagsLoaded extends TagsEvent {
  final List<IdeaMemo> ideas;

  const TagsLoaded(this.ideas);

  @override
  List<Object> get props => [ideas];

  @override
  String toString() => 'ideas { ideas: $ideas }';
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

class IdeasLoaded extends TagsEvent {
  final List<IdeaMemo> ideas;

  const IdeasLoaded(this.ideas);

  @override
  List<Object> get props => [ideas];

  @override
  String toString() => 'Update ideas { ideas: $ideas }';
}
