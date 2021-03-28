import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/SearchHistory.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/search_history_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchHistoryBloc implements BlocBase {
  final ideaAndTagRepository = SearchHistoryRepository();
  final historyLength = 4;

  List<SearchHistory> _searchHistoryList = [];

  List<SearchHistory> get searchHistoryList => _searchHistoryList;
  BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;

  SearchHistoryBloc() {
    readSearchHistory();
    filteredSearchTerms(filter: null);
  }

  void readSearchHistory() async {
    try {
      _searchHistoryList = await ideaAndTagRepository.histories();
      print('1 : $_searchHistoryList');
      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      return e;
    }
  }

  void filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      _searchHistoryList.reversed.where((term) {
        return term.id.startsWith(filter);
      }).toList();
    } else {
      _searchHistoryList.reversed.toList();
    }
    _searchHistoryController.add(_searchHistoryList);
  }

  void deleteSearchTerms(String term) {
    _searchHistoryList.removeWhere((element) => element.id == term);
  }

  void putSearchTerms(String term) {
    deleteSearchTerms(term);
    addSearchTerms(term: term);
  }

  void addSearchTerms({String term}) async {
    if (_searchHistoryList.contains(term)) {
      putSearchTerms(term);
      return;
    }

    _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);
    final firstIdIndex = int.parse((_searchHistoryList.first.id).split('_').last);
    final lastIdIndex = int.parse((_searchHistoryList.last.id).split('_').last);

    if (_searchHistoryList.isNotEmpty) {
      if (_searchHistoryList.length > historyLength) {
        final firstHistory = await ideaAndTagRepository.readByIdHistory(id: 'history_' + firstIdIndex.toString());
        await Amplify.DataStore.delete(firstHistory);
        _searchHistoryList.removeRange(0, _searchHistoryList.length - historyLength);
      }
      final newHistory = await ideaAndTagRepository.createSearch(id: 'history_' + (lastIdIndex + 1).toString(), searchText: term);
      _searchHistoryList.add(newHistory);
    } else {
      final newHistory = await ideaAndTagRepository.createSearch(id: 'history_0', searchText: term);
      _searchHistoryList.add(newHistory);
    }

    //filteredSearchTerms(filter: null);

    _searchHistoryController.add(_searchHistoryList);
  }

  @override
  void dispose() {
    _searchHistoryController.close();
  }
}
