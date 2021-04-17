import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/controller/free_write_repository.dart';

class FreeWriteController extends GetxController {
  List<IdeaMemo> ideaMemo = [];
  List<SearchHistory> searchHistory = [];
  List<SearchHistory> _filteredSearchHistory = [];

  final FreeWriteRepository newCombineRepository = FreeWriteRepository();

  static FreeWriteController get to => Get.find<FreeWriteController>();

  @override
  void onInit() {
    super.onInit();
  }

  readIdeaAndTags() async {
    try {
      ideaMemo = await newCombineRepository.readIdeas();
      searchHistory = await newCombineRepository.readTags();

      update();
    } catch (e) {
      print(e);
    }
  }

  filteredIdeaAndTags({@required String filter}) async {
    try {
      ideaMemo = ideaMemo.where((element) => element.tags.contains(filter)).toList();
      update();
    } catch (e) {
      print(e);
    }
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

  updateIdea({String id, String memo, String tag}) async {
    try {} catch (e) {
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

  createTag({String tag}) async {
    try {
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
          update();
        }
        int lastIndex = searchHistory.isNotEmpty ? int.parse(searchHistory.last.id.split('_').last) : 0;
        final lastHistory = await newCombineRepository.createTag(id: 'history_' + lastIndex.toString(), tags: tag);
        searchHistory.add(lastHistory);
        update();
      });

      filteredSearchTerms(filter: null);
    } catch (e) {
      print(e);
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
    update();
  }

  void putSearchTerms({String term}) {
    deleteSearchTerms(term: term);
    createTag(tag: term);
  }
}
