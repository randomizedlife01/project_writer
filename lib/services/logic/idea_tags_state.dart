import 'package:equatable/equatable.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/SearchTags.dart';

abstract class TagsCustomState extends Equatable {
  const TagsCustomState();

  @override
  List<Object> get props => [];
}

class TagsLoadingInProgress extends TagsCustomState {}

class TagsLoadSuccess extends TagsCustomState {
  final List<IdeaMemo> ideaMemo;
  final List<SearchTags> tags;

  const TagsLoadSuccess([this.ideaMemo = const [], this.tags = const []]);

  @override
  List<Object> get props => [ideaMemo, tags];

  @override
  String toString() => 'Idea Load Success { Idea: $ideaMemo }, Tags Load Success { Tags : $tags}';
}

class TagsError extends TagsCustomState {}
