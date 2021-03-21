import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/services/logic/idea_note_repository.dart';

part 'idea_note_state.dart';
part 'idea_note_event.dart';

class IdeaBloc extends Bloc<IdeaEvent, IdeaState> {
  final IdeaRepository _ideaRepository;
  StreamSubscription _ideaSubscription;

  IdeaBloc({@required IdeaRepository ideaRepository})
      : assert(ideaRepository != null),
        _ideaRepository = ideaRepository,
        super(IdeaLoadingInProgress());

  @override
  Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
    if (event is IdeasLoaded) {
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
    try {
      final ideas = this._ideaRepository.ideas();
      yield IdeasLoadSuccess(await ideas);
    } catch (_) {
      yield IdeaError();
    }
  }

  Stream<IdeaState> _mapIdeaAddToState(IdeaAdded event) async* {
    if (state is IdeasLoadSuccess) {
      final data = await this._ideaRepository.createIdea(memo: event.ideaMemo.memo, length: event.props.length);
      final List<IdeaMemo> updatedIdea = List.from((state as IdeasLoadSuccess).ideaMemo)..add(data);
      yield IdeasLoadSuccess(updatedIdea);
    }
  }

  Stream<IdeaState> _mapReadIdeasToState(IdeaUpdated event) async* {
    //yield IdeaLoaded(event.ideas);
  }

  Stream<IdeaState> _mapDeleteIdeasToState(IdeaDeleted event) async* {
    if (state is IdeasLoadSuccess) {
      final data = await this._ideaRepository.delete(index: event.props.length);
      final List<IdeaMemo> updatedIdea = List.from((state as IdeasLoadSuccess).ideaMemo)..remove(data);
      yield IdeasLoadSuccess(updatedIdea);
    }
  }

  @override
  Future<void> close() {
    _ideaSubscription?.cancel();
    return super.close();
  }
}
