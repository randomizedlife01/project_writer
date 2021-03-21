import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/services/logic/idea_note_bloc.dart';
import 'package:project_writer_v04/services/logic/idea_note_state.dart';
import 'package:project_writer_v04/services/logic/idea_tags_event.dart';
import 'package:project_writer_v04/services/logic/idea_tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsCustomState> {
  final IdeaBloc _ideasBloc;
  StreamSubscription _ideaSubscription;

  TagsBloc({@required IdeaBloc ideaBloc})
      : assert(ideaBloc != null),
        _ideasBloc = ideaBloc,
        super(ideaBloc.state is IdeasLoadSuccess
            ? TagsLoadSuccess(
                (ideaBloc.state as IdeasLoadSuccess).ideaMemo,
              )
            : TagsLoadingInProgress()) {
    _ideaSubscription = ideaBloc.listen((state) {
      if (state is IdeasLoadSuccess) {
        add(TagsLoaded((ideaBloc.state as IdeasLoadSuccess).ideaMemo));
      }
    });
  }

  @override
  Stream<TagsCustomState> mapEventToState(TagsEvent event) async* {
    if (event is TagsLoaded) {
      yield* _mapUpdateTagsToState(event);
    } else if (event is IdeasLoaded) {
      yield* _mapIdeaUpdatedToState(event);
    }
  }

  //TODO: 태그와 메모 결합중... 참고해서 할 것.
  Stream<TagsCustomState> _mapUpdateTagsToState(TagsLoaded event) async* {}

  Stream<TagsCustomState> _mapIdeaUpdatedToState(IdeasLoaded event) async* {
    yield TagsLoadSuccess();
  }

  @override
  Future<void> close() {
    _ideaSubscription?.cancel();
    return super.close();
  }
}
