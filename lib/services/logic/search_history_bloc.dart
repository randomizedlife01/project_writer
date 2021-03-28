import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/SearchHistory.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/search_history_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchModel {
  List<SearchHistory> searchHistoryList;
  List<SearchHistory> filteredSearchHistoryList;

  SearchModel(this.searchHistoryList, this.filteredSearchHistoryList);
}

class SearchHistoryBloc implements BlocBase {
  final ideaAndTagRepository = SearchHistoryRepository();
  final historyLength = 5;

  List<SearchHistory> _searchHistoryList = [];
  List<SearchHistory> _filteredSearchHistory = [];

  List<SearchHistory> get searchHistoryList => _searchHistoryList;
  BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;

  List<SearchHistory> get filteredSearchHistoryList => _filteredSearchHistory;
  BehaviorSubject<List<SearchHistory>> _filteredSearchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get filteredSearchHistoryStream => _filteredSearchHistoryController.stream;

  SearchHistoryBloc() {
    readSearchHistory();
    _filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  Stream<SearchModel> searchCombineStream() {
    //readIdeaAndTags();
    return Rx.combineLatest2(searchHistoryStream, filteredSearchHistoryStream,
        (List<SearchHistory> searchHistoryList, List<SearchHistory> filteredSearchHistoryList) {
      return SearchModel(searchHistoryList, filteredSearchHistoryList);
    });
  }

  void readSearchHistory() async {
    try {
      _searchHistoryList = await ideaAndTagRepository.histories();
      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      return e;
    }
  }

  List<SearchHistory> filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _filteredSearchHistory.reversed.where((term) => term.id.startsWith(filter)).toList();
    } else {
      return _filteredSearchHistory.reversed.toList();
    }
  }

  void deleteSearchTerms(String term) {
    _searchHistoryList.removeWhere((element) => element.id == term);
    _filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void putSearchTerms(String term) {
    deleteSearchTerms(term);
    addSearchTerms(term: term);
  }

  void addSearchTerms({String term, String firstId, String lastId}) async {
    if (_searchHistoryList.contains(term)) {
      putSearchTerms(term);
      return;
    }

    _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);

    if (_searchHistoryList.length > historyLength) {
      final firstHistory = await ideaAndTagRepository.readByIdHistory(id: firstId);
      await Amplify.DataStore.delete(firstHistory);
      _searchHistoryList.removeRange(0, _searchHistoryList.length - historyLength);
    }

    final newHistory = await ideaAndTagRepository.createSearch(id: lastId, searchText: term);
    _searchHistoryList.add(newHistory);

    _filteredSearchHistory = filteredSearchTerms(filter: null);

    _searchHistoryController.add(_searchHistoryList);
  }

  @override
  void dispose() {
    _filteredSearchHistoryController.close();
    _searchHistoryController.close();
  }
}
