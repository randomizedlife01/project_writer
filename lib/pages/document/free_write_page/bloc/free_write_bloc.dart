// import 'package:amplify_flutter/amplify.dart';
// import 'package:flutter/material.dart';
// import 'package:project_writer_v04/models/ModelProvider.dart';
// import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../../../services/logic/bloc_base.dart';
//
// class FreeWriteModel {
//   List<IdeaMemo> ideaMemo;
//   List<SearchHistory> searchHistory;
//
//   FreeWriteModel(this.ideaMemo, this.searchHistory);
// }
//
// //TODO: 태그 검색 사용시 텍스트 목록을 클릭하면 안 나옴... 이 오류 수정할것.
//
// class FreeWriteBloc implements BlocBase {
//   final newCombineRepository = NewCombineRepository();
//   List<IdeaMemo> _ideaMemo;
//
//   List<IdeaMemo> get ideaMemo => _ideaMemo;
//
//   BehaviorSubject<List<IdeaMemo>> _ideaController = BehaviorSubject<List<IdeaMemo>>.seeded([]);
//
//   Stream<List<IdeaMemo>> get ideaStream => _ideaController.stream;
//
//   final historyLength = 4;
//
//   List<SearchHistory> _searchHistoryList = [];
//   List<SearchHistory> _filteredSearchHistory = [];
//
//   List<SearchHistory> get searchHistoryList => _searchHistoryList;
//   BehaviorSubject<List<SearchHistory>> _searchHistoryController = BehaviorSubject<List<SearchHistory>>.seeded([]);
//
//   Stream<List<SearchHistory>> get searchHistoryStream => _searchHistoryController.stream;
//
//   FreeWriteBloc() {
//     readIdeaAndTags();
//   }
//
//   Stream<FreeWriteModel> combineStream() {
//     return Rx.combineLatest2(ideaStream, searchHistoryStream, (List<IdeaMemo> ideas, List<SearchHistory> tags) {
//       //print('idea : $ideas, tag : $tags');
//       return FreeWriteModel(ideas, tags);
//     });
//   }
//
//   void readIdeaAndTags() async {
//     try {
//       _ideaMemo = await newCombineRepository.readIdeas();
//       _searchHistoryList = await newCombineRepository.readTags();
//
//       _ideaController.add(_ideaMemo);
//       _searchHistoryController.add(_searchHistoryList);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void filteredIdeaAndTags({@required String filter}) async {
//     try {
//       _ideaMemo = _ideaMemo.where((element) => element.tags.contains(filter)).toList();
//       _ideaController.add(_ideaMemo);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void createIdea({String id, String memo, String tag}) async {
//     try {
//       final data = await newCombineRepository.createIdea(id: id, memo: memo, tags: tag);
//       _ideaMemo.add(data);
//
//       _ideaController.add(_ideaMemo);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void updateIdea({String id, String memo, int index}) async {
//     try {
//       if (id.isNotEmpty) {
//         final lastId = _ideaMemo.last.id;
//         final number = lastId.split("_").last;
//         final _latIdNum = int.parse(number);
//       }
//
//       final data = await newCombineRepository.update(id: id, memo: memo);
//       _ideaMemo[index] = data;
//
//       _ideaController.add(_ideaMemo);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void deleteIdea({String id}) async {
//     try {
//       final data = await newCombineRepository.deleteIdea(id: id);
//       _ideaMemo.remove(data);
//
//       _ideaController.add(_ideaMemo);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void createTag({String tag}) async {
//     try {
//       _searchHistoryList = await Amplify.DataStore.query(SearchHistory.classType);
//       if (searchHistoryList.contains(tag)) {
//         putSearchTerms(term: tag);
//         return;
//       }
//
//       final tagData = tag.split(' ');
//
//       tagData.forEach((tag) async {
//         if (_searchHistoryList.length > historyLength) {
//           int firstIndex = _searchHistoryList.isNotEmpty ? int.parse(_searchHistoryList.first.id.split('_').last) : 0;
//           final firstHistory = await newCombineRepository.deleteTag(id: 'history_' + firstIndex.toString());
//           _searchHistoryList.remove(firstHistory);
//         }
//         int lastIndex = _searchHistoryList.isNotEmpty ? int.parse(_searchHistoryList.last.id.split('_').last) : 0;
//         final lastHistory = await newCombineRepository.createTag(id: 'history_' + lastIndex.toString(), tags: tag);
//         _searchHistoryList.add(lastHistory);
//       });
//
//       filteredSearchTerms(filter: null);
//
//       _searchHistoryController.add(_filteredSearchHistory);
//       _searchHistoryController.add(_searchHistoryList);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void updateTag({String id, int index, String tag}) async {
//     try {
//       final data = await newCombineRepository.updateTag(id: id, tag: tag);
//       _searchHistoryList[index] = data;
//
//       _searchHistoryController.add(_searchHistoryList);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   void deleteTag({String id}) async {
//     try {
//       final data = await newCombineRepository.deleteTag(id: id);
//       _searchHistoryList.remove(data);
//
//       _searchHistoryController.add(_searchHistoryList);
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   List<SearchHistory> filteredSearchTerms({@required String filter}) {
//     if (filter != null && filter.isNotEmpty) {
//       return _searchHistoryList.reversed.where((term) {
//         return term.id.startsWith(filter);
//       }).toList();
//     } else {
//       return _searchHistoryList.reversed.toList();
//     }
//   }
//
//   void deleteSearchTerms({String term}) {
//     _searchHistoryList.removeWhere((element) => element.id == term);
//     _filteredSearchHistory = filteredSearchTerms(filter: null);
//   }
//
//   void putSearchTerms({String term}) {
//     deleteSearchTerms(term: term);
//     createTag(tag: term);
//   }
//
//   @override
//   void dispose() {
//     _ideaController.close();
//     _searchHistoryController.close();
//   }
// }
