import 'package:amplify_flutter/amplify.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';

part 'free_write_state.dart';

class FreeWriteCubit extends Cubit<FreeWriteState> {
  List<IdeaMemo> ideaMemo;
  List<SearchHistory> searchHistory;
  List<SearchHistory> _filteredSearchHistory;

  final FreeWriteRepository newCombineRepository;

  FreeWriteCubit({this.newCombineRepository, this.ideaMemo, this.searchHistory}) : super(FreeWriteLoading());

  Future<void> readIdeaAndTags() async {
    try {
      emit(FreeWriteLoading());

      ideaMemo = await newCombineRepository.readIdeas();

      searchHistory = await newCombineRepository.readTags();
      emit(FreeWriteLoaded(ideaMemo: ideaMemo, searchHistory: searchHistory));
    } catch (e) {
      emit(FreeWriteNotLoaded());
    }
  }

  Future<void> filteredIdeaAndTags({@required String filter}) async {
    try {
      emit(FreeWriteLoading());

      ideaMemo = ideaMemo.where((element) => element.tags.contains(filter)).toList();
      emit(FreeWriteLoaded(ideaMemo: ideaMemo, searchHistory: searchHistory));
    } catch (e) {
      throw e;
    }
  }

  Future<void> createIdea({String id, String memo, String tag}) async {
    try {
      emit(FreeWriteLoading());

      final data = await newCombineRepository.createIdea(id: id, memo: memo, tags: tag);
      ideaMemo.add(data);

      print(ideaMemo);

      emit(FreeWriteLoaded(ideaMemo: ideaMemo, searchHistory: searchHistory));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateIdea({String id, String memo, String tag}) async {
    try {} catch (e) {
      throw e;
    }
  }

  Future<void> deleteIdea({String id}) async {
    try {
      emit(FreeWriteLoading());

      final data = await newCombineRepository.deleteIdea(id: id);
      ideaMemo.remove(data);

      emit(FreeWriteLoaded(ideaMemo: ideaMemo, searchHistory: searchHistory));
    } catch (e) {
      throw e;
    }
  }

  Future<void> createTag({String tag}) async {
    try {
      emit(FreeWriteLoading());

      searchHistory = await Amplify.DataStore.query(SearchHistory.classType);
      if (searchHistory.contains(tag)) {
        putSearchTerms(term: tag);
        return;
      }

      final tagData = tag.split(' ');

      tagData.forEach((tag) async {
        if (searchHistory.length > 4) {
          int firstIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.first.id.split('_').last) : 0;
          final firstHistory = await newCombineRepository.deleteTag(id: 'history_' + firstIndex.toString());
          searchHistory.remove(firstHistory);
        }
        int lastIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.last.id.split('_').last) : 0;
        final lastHistory = await newCombineRepository.createTag(id: 'history_' + lastIndex.toString(), tags: tag);
        searchHistory.add(lastHistory);
      });

      filteredSearchTerms(filter: null);

      emit(FreeWriteLoaded(ideaMemo: ideaMemo, searchHistory: searchHistory));
    } catch (e) {
      throw e;
    }
  }

  List<SearchHistory> filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return searchHistory.reversed.where((term) {
        return term.id.startsWith(filter);
      }).toList();
    } else {
      return searchHistory.reversed.toList();
    }
  }

  void deleteSearchTerms({String term}) {
    searchHistory.removeWhere((element) => element.id == term);
    _filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void putSearchTerms({String term}) {
    deleteSearchTerms(term: term);
    createTag(tag: term);
  }
}
