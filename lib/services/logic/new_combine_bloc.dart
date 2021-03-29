import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/logic/idea_repository.dart';
import 'package:project_writer_v04/services/logic/search_history_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';

class NewCombineModel {
  List<IdeaMemo> ideamemo;
  List<SearchHistory> searchHistory;

  NewCombineModel(this.ideamemo, this.searchHistory);
}

class NewCombineBloc implements BlocBase {
  final ideaRepository = FreeWriteRepository();
  List<IdeaMemo> _ideaMemo;

  List<IdeaMemo> get ideaMemo => _ideaMemo;

  BehaviorSubject<List<IdeaMemo>> _ideaController = BehaviorSubject<List<IdeaMemo>>.seeded([]);

  Stream<List<IdeaMemo>> get ideaStream => _ideaController.stream;

  final tagRepository = SearchHistoryRepository();
  final historyLength = 4;

  List<SearchHistory> _searchHistoryList = [];

  List<SearchHistory> get searchHistoryList => _searchHistoryList;
  BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);

  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;

  Stream<NewCombineModel> combineStream() {
    readIdeaAndTags();
    return Rx.combineLatest2(ideaStream, searchHistoryStream, (List<IdeaMemo> ideas, List<SearchHistory> tags) {
      //print('idea : $ideas, tag : $tags');
      return NewCombineModel(ideas, tags);
    });
  }

  Future<List<IdeaMemo>> readIdeas() async {
    try {
      _ideaMemo = await Amplify.DataStore.query(IdeaMemo.classType);
      return _ideaMemo;
    } catch (e) {
      throw e;
    }
  }

  Future<List<SearchHistory>> readTags({String id}) async {
    try {
      _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);
      print(_searchHistoryList);
      return _searchHistoryList;
    } catch (e) {
      throw e;
    }
  }

  void readIdeaAndTags() async {
    try {
      _ideaMemo = await readIdeas();
      _searchHistoryList = await readTags();

      _ideaController.add(_ideaMemo);
      _searchHistoryController.add(_searchHistoryList);

      print('idea : $_ideaMemo, tags : $_searchHistoryList');
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _ideaController.close();
    _searchHistoryController.close();
  }
}
