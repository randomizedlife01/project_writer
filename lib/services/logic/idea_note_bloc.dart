import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/services/logic/idea_note_repository.dart';

part 'idea_note_event.dart';
part 'idea_note_state.dart';

class IdeaBloc extends Bloc<IdeaEvent, IdeaState> {
  final IdeaRepository _ideaRepository;
  StreamSubscription _ideaSubscription;

  IdeaBloc({@required IdeaRepository ideaRepository})
      : assert(ideaRepository != null),
        _ideaRepository = ideaRepository,
        super(IdeaLoading());

  @override
  Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
    if (event is IdeaLoadSuccess) {
      yield* _mapLoadIdeasToState();
    } else if (event is IdeaAdded) {
      yield* _mapIdeaAddToState(event);
    } else if (event is IdeaUpdated) {
      yield* _mapReadIdeasToState(event);
    } else if (event is IdeaDeleted) {
      yield* _mapDeleteIdeasToState(event);
    }
  }

  Stream<IdeaState> _mapLoadIdeasToState() async* {
    _ideaSubscription?.cancel();
    _ideaSubscription = _ideaRepository.ideas().listen(
          (idea) => add(IdeaUpdated(idea)),
        );
  }

  //TODO: bloc 업데이트가 안되고 리스트가 추가가 아닌 덮어쓰기됨.
  Stream<IdeaState> _mapIdeaAddToState(IdeaAdded event) async* {
    print(event.props.length);
    _ideaRepository..createIdea(memo: event.ideaMemo.memo, tags: event.ideaMemo.tags, length: event.props.length);
  }

  Stream<IdeaState> _mapReadIdeasToState(IdeaUpdated event) async* {
    yield IdeaLoaded(event.ideas);
  }

  Stream<IdeaState> _mapDeleteIdeasToState(IdeaDeleted event) async* {
    _ideaRepository..delete(id: event.ideaMemo.id);
  }

  @override
  Future<void> close() {
    _ideaSubscription?.cancel();
    return super.close();
  }
}
