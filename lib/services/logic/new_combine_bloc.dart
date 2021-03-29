import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/logic/new_combine_repository.dart';
import 'package:project_writer_v04/services/logic/search_history_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';

class NewCombineModel {
  List<IdeaMemo> ideaMemo;
  List<SearchHistory> searchHistory;

  NewCombineModel(this.ideaMemo, this.searchHistory);
}

class NewCombineBloc implements BlocBase {
  final newCombineRepository = NewCombineRepository();
  List<IdeaMemo> _ideaMemo;

  List<IdeaMemo> get ideaMemo => _ideaMemo;

  BehaviorSubject<List<IdeaMemo>> _ideaController = BehaviorSubject<List<IdeaMemo>>.seeded([]);

  Stream<List<IdeaMemo>> get ideaStream => _ideaController.stream;

  final tagRepository = SearchHistoryRepository();
  final historyLength = 4;

  List<SearchHistory> _searchHistoryList = [];
  List<SearchHistory> _filteredSearchHistory = [];

  List<SearchHistory> get searchHistoryList => _searchHistoryList;
  BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;

  NewCombineBloc() {
    readIdeaAndTags();
  }

  Stream<NewCombineModel> combineStream() {
    return Rx.combineLatest2(ideaStream, searchHistoryStream, (List<IdeaMemo> ideas, List<SearchHistory> tags) {
      //print('idea : $ideas, tag : $tags');
      return NewCombineModel(ideas, tags);
    });
  }

  void readIdeaAndTags() async {
    try {
      _ideaMemo = await newCombineRepository.readIdeas();
      _searchHistoryList = await newCombineRepository.readTags();

      _ideaController.add(_ideaMemo);
      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      throw e;
    }
  }

  void createIdea({int index, String memo, String tag}) async {
    try {
      final data = await newCombineRepository.createIdea(index: index, memo: memo, tags: tag);
      _ideaMemo.add(data);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  void updateIdea({int index, String memo}) async {
    try {
      final data = await newCombineRepository.update(index: index, memo: memo);
      _ideaMemo[index] = data;

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  void deleteIdea({int index}) async {
    try {
      final data = await newCombineRepository.deleteIdea(index: index);
      _ideaMemo.remove(data);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  void createTag({int index, String tag}) async {
    try {
      final data = await newCombineRepository.createTag(index: index, tags: tag);
      _searchHistoryList.add(data);

      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      throw e;
    }
  }

  void updateTag({int index, String tag}) async {
    try {
      final data = await newCombineRepository.updateTag(index: index, tag: tag);
      _searchHistoryList[index] = data;

      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      throw e;
    }
  }

  void deleteTag({int index}) async {
    try {
      final data = await newCombineRepository.deleteTag(index: index);
      _searchHistoryList.remove(data);

      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      throw e;
    }
  }

  List<SearchHistory> filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistoryList.reversed.where((term) {
        return term.id.startsWith(filter);
      }).toList();
    } else {
      return _searchHistoryList.reversed.toList();
    }
  }

  void deleteSearchTerms({String term}) {
    _searchHistoryList.removeWhere((element) => element.id == term);
    _filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void putSearchTerms({String term}) {
    deleteSearchTerms(term: term);
    addSearchTerms(term: term);
  }

  void addSearchTerms({String term, int firstIndex, int lastIndex}) async {
    if (searchHistoryList.contains(term)) {
      putSearchTerms(term: term);
      return;
    }

    _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);

    if (_searchHistoryList.isNotEmpty) {
      if (_searchHistoryList.length > historyLength) {
        final firstHistory = await newCombineRepository.deleteTag(index: firstIndex);
        searchHistoryList.remove(firstHistory);
      }
      final newHistory = await newCombineRepository.createTag(index: lastIndex, tags: term);
      searchHistoryList.add(newHistory);
    } else {
      final newHistory = await newCombineRepository.createTag(index: lastIndex, tags: term);
      searchHistoryList.add(newHistory);
    }

    filteredSearchTerms(filter: null);

    _searchHistoryController.add(_filteredSearchHistory);
    _searchHistoryController.add(_searchHistoryList);
  }

  @override
  void dispose() {
    _ideaController.close();
    _searchHistoryController.close();
  }
}
