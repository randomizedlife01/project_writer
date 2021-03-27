import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/SearchHistory.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/search_history_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchHistoryBloc implements BlocBase {
  final ideaAndTagRepository = SearchHistoryRepository();

  List<SearchHistory> _searchHistoryList;

  List<SearchHistory> get searchHistoryList => _searchHistoryList;

  BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;

  SearchHistoryBloc() {
    readSearchHistory();
  }

  void readSearchHistory() async {
    try {
      _searchHistoryList = await ideaAndTagRepository.histories();
      _searchHistoryController.add(_searchHistoryList);
    } catch (e) {
      return e;
    }
  }

  void addSearchHistory({int index}) async {
    final historyLength = 5;
    _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);

    if (_searchHistoryList.length > historyLength) {
      final data = await ideaAndTagRepository.readByIdHistory(id: 'history' + index.toString());
      await Amplify.DataStore.delete(data);
      _searchHistoryList.removeRange(0, _searchHistoryList.length - historyLength);
    }
  }

  @override
  void dispose() {
    _searchHistoryController.close();
  }
}
