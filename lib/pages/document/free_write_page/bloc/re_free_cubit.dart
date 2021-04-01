import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';

part 're_free_state.dart';

class ReFreeCubit extends Cubit<FreeWriteState> {
  List<IdeaMemo> ideaMemo;
  final NewCombineRepository _newCombineRepository;

  ReFreeCubit(this._newCombineRepository, [this.ideaMemo = const []]) : super(StateOfIdeasLoading());

  Future<void> readIdeaAndTags() async {
    try {
      emit(StateOfIdeasLoading());

      ideaMemo = await _newCombineRepository.readIdeas();
      emit(StateOfIdeasLoaded(ideaMemo));
    } catch (e) {
      emit(StateOfIdeasNotLoaded());
    }
  }

  Future<void> createIdea({String id, String memo, String tag}) async {
    try {
      final data = await _newCombineRepository.createIdea(id: id, memo: memo, tags: tag);
      ideaMemo.add(data);

      emit(StateOfIdeasLoaded(ideaMemo));
    } catch (e) {
      throw e;
    }
  }
}
