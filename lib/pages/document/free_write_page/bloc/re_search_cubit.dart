import 'package:amplify_flutter/amplify.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';

part 're_search_state.dart';

class ReFreeCubit extends Cubit<SearchState> {
  List<SearchHistory> searchHistory;
  final NewCombineRepository _newCombineRepository;

  final historyLength = 4;

  ReFreeCubit(this._newCombineRepository, [this.searchHistory = const []]) : super(StateOfIdeasLoading());

  Future<void> readIdeaAndTags() async {
    try {
      emit(StateOfSearchLoading());

      searchHistory = await _newCombineRepository.readTags();
      emit(StateOfSearchLoaded(searchHistory));
    } catch (e) {
      emit(StateOfSearchNotLoaded());
    }
  }

  Future<void> createTag({String tag}) async {
    try {
      searchHistory = await Amplify.DataStore.query(SearchHistory.classType);
      if (searchHistory.contains(tag)) {
        putSearchTerms(term: tag);
        return;
      }

      final tagData = tag.split(' ');

      tagData.forEach((tag) async {
        if (searchHistory.length > historyLength) {
          int firstIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.first.id.split('_').last) : 0;
          final firstHistory = await _newCombineRepository.deleteTag(id: 'history_' + firstIndex.toString());
          searchHistory.remove(firstHistory);
        }
        int lastIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.last.id.split('_').last) : 0;
        final lastHistory = await _newCombineRepository.createTag(id: 'history_' + lastIndex.toString(), tags: tag);
        searchHistory.add(lastHistory);
      });

      filteredSearchTerms(filter: null);

      emit(StateOfSearchLoaded(searchHistory));
    } catch (e) {
      throw e;
    }
  }

  void filteredIdeaAndTags({@required String filter}) async {
    try {
      _ideaMemo = _ideaMemo.where((element) => element.tags.contains(filter)).toList();
      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }
}
