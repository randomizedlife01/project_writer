import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../services/logic/bloc_base.dart';

class FreeWriteModel {
  List<IdeaMemo> ideaMemo;
  List<SearchHistory> searchHistory;

  FreeWriteModel(this.ideaMemo, this.searchHistory);
}

class FreeWriteBloc implements BlocBase {
  final newCombineRepository = NewCombineRepository();
  List<IdeaMemo> _ideaMemo;

  List<IdeaMemo> get ideaMemo => _ideaMemo;

  BehaviorSubject<List<IdeaMemo>> _ideaController = BehaviorSubject<List<IdeaMemo>>.seeded([]);

  Stream<List<IdeaMemo>> get ideaStream => _ideaController.stream;

  final historyLength = 4;

  List<SearchHistory> _searchHistoryList = [];
  List<SearchHistory> _filteredSearchHistory = [];

  List<SearchHistory> get searchHistoryList => _searchHistoryList;
  BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;

  FreeWriteBloc() {
    readIdeaAndTags();
  }

  Stream<FreeWriteModel> combineStream() {
    return Rx.combineLatest2(ideaStream, searchHistoryStream, (List<IdeaMemo> ideas, List<SearchHistory> tags) {
      //print('idea : $ideas, tag : $tags');
      return FreeWriteModel(ideas, tags);
    });
  }

  void readIdeaAndTags() async {
    try {
      _ideaMemo = await newCombineRepository.readIdeas();
      _searchHistoryList = await newCombineRepository.readTags();

      print('search history : $_searchHistoryList');

      _ideaController.add(_ideaMemo);
      _searchHistoryController.add(_searchHistoryList);
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

  void createIdea({String id, String memo, String tag}) async {
    try {
      final data = await newCombineRepository.createIdea(id: id, memo: memo, tags: tag);
      _ideaMemo.add(data);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  void updateIdea({String id, String memo, int index}) async {
    try {
      if (id.isNotEmpty) {
        final lastId = _ideaMemo.last.id;
        final number = lastId.split("_").last;
        final _latIdNum = int.parse(number);
      }

      final data = await newCombineRepository.update(id: id, memo: memo);
      _ideaMemo[index] = data;

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  void deleteIdea({String id}) async {
    try {
      final data = await newCombineRepository.deleteIdea(id: id);
      _ideaMemo.remove(data);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  void createTag({String tag}) async {
    try {
      _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);

      final tagData = tag.split(' ');

      print('tag data : $tagData');

      int firstData = 0;

      tagData.forEach((history) async {
        if (tagData.isNotEmpty && _searchHistoryList.isNotEmpty) {
          final lastData = _searchHistoryList.last.id;
          print('last data : $lastData');
          final lastIndex = lastData.split('_').last;
          print('last index : $lastIndex');
          final lastId = int.parse(lastIndex) + 1;
          print('last id : $lastId');

          final newHistory = await newCombineRepository.createTag(id: 'history_' + lastId.toString());
          _searchHistoryList.add(newHistory);

          _searchHistoryController.add(_searchHistoryList);
        } else {
          final newHistory = await newCombineRepository.createTag(id: 'history_' + firstData.toString());
          _searchHistoryList.add(newHistory);
          firstData++;

          _searchHistoryController.add(_searchHistoryList);
        }
      });
    } catch (e) {
      throw e;
    }
  }

  void updateTag({String id, int index, String tag}) async {
    try {
      final data = await newCombineRepository.updateTag(id: id, tag: tag);
      _searchHistoryList[index] = data;

      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      throw e;
    }
  }

  void deleteTag({String id}) async {
    try {
      final data = await newCombineRepository.deleteTag(id: id);
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

  void addSearchTerms({String term, String firstId, String lastId}) async {
    if (searchHistoryList.contains(term)) {
      putSearchTerms(term: term);
      return;
    }

    _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);

    if (_searchHistoryList.isNotEmpty) {
      if (_searchHistoryList.length > historyLength) {
        final firstHistory = await newCombineRepository.deleteTag(id: firstId);
        searchHistoryList.remove(firstHistory);
      }
      final newHistory = await newCombineRepository.createTag(id: lastId, tags: term);
      searchHistoryList.add(newHistory);
    } else {
      final newHistory = await newCombineRepository.createTag(id: lastId, tags: term);
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
