import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/controller/free_write_repository.dart';

class FreeWriteController extends GetxController {
  List<IdeaMemo> ideaMemo = [];
  List<SearchHistory> searchHistory = [];
  List<SearchHistory> filteredSearchHistory = [];

  static const historyLength = 5;

  String selectedTerm = '';

  final FreeWriteRepository newCombineRepository = FreeWriteRepository();

  static FreeWriteController get to => Get.find<FreeWriteController>();

  @override
  void onInit() {
    super.onInit();
    readIdeaAndTags();
  }

  readIdeaAndTags() async {
    ideaMemo = await newCombineRepository.readIdeas();
    searchHistory = await newCombineRepository.readTags();
    update();
  }

  createIdea({String id, String memo, String tag}) async {
    try {
      final data = await newCombineRepository.createIdea(id: id, memo: memo, tags: tag);
      ideaMemo.add(data);
      update();
    } catch (e) {
      print(e);
    }
  }

  deleteIdea({String id}) async {
    try {
      final data = await newCombineRepository.deleteIdea(id: id);
      ideaMemo.remove(data);
      update();
    } catch (e) {
      print(e);
    }
  }

  filterSearchTerms({String query}) {
    if (query != null && query.isNotEmpty) {
      filteredSearchHistory = searchHistory.reversed.where((term) => term.searchHistory.startsWith(query)).toList();
      update();
    } else {
      filteredSearchHistory = searchHistory.reversed.toList();
      update();
    }
  }

  createTag({String query}) async {
    try {
      if (searchHistory.contains(query)) {
        putSearchTerms(term: query);
        return;
      }

      if (searchHistory.length > historyLength) {
        int firstIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.first.id.split('_').last) : 0;
        print('first : $firstIndex');
        final firstHistory = await newCombineRepository.deleteTag(id: 'history_' + firstIndex.toString());
        searchHistory.remove(firstHistory);
        update();
      }

      int lastIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.last.id.split('_').last) + 1 : 0;
      print('last : $lastIndex');
      final lastHistory = await newCombineRepository.createTag(id: 'history_' + lastIndex.toString(), tags: query);
      searchHistory.add(lastHistory);

      update();
    } catch (e) {
      print(e);
    }
  }

  deleteTag({String id}) {
    newCombineRepository.deleteTag(id: id);
    searchHistory.removeWhere((element) => element.id == id);
    //filteredSearchHistory = filterSearchTerms(query: null);
    update();
  }

  filteredIdeaAndTags({@required String filter}) async {
    try {
      ideaMemo = ideaMemo.where((element) => element.tags.contains(filter)).toList();
      update();
    } catch (e) {
      print(e);
    }
  }

  putSearchTerms({String term}) {
    deleteTag(id: term);
    createTag(query: term);
  }
}
