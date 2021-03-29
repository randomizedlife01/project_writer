import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class NewCombineRepository {
  final ideaIdFirst = 'idea_';
  final tagIdFirst = 'history_';
  final historyLength = 4;

  Future<List<IdeaMemo>> readIdeas({List<IdeaMemo> ideaMemo}) async {
    try {
      ideaMemo = await Amplify.DataStore.query(IdeaMemo.classType);
      return ideaMemo;
    } catch (e) {
      throw e;
    }
  }

  Future<List<SearchHistory>> readTags({String id, List<SearchHistory> searchHistory}) async {
    try {
      searchHistory = await Amplify.DataStore.query(SearchHistory.classType);
      print(searchHistory);
      return searchHistory;
    } catch (e) {
      throw e;
    }
  }

  Future<IdeaMemo> createIdea({String memo, String tags, int index}) async {
    final ideaObject = IdeaMemo(
      id: ideaIdFirst + index.toString(),
      memo: memo,
      tags: tags,
    );

    try {
      await Amplify.DataStore.save(ideaObject);

      return ideaObject;
    } catch (e) {
      return e;
    }
  }

  Future<List<IdeaMemo>> ideas() async {
    try {
      return await Amplify.DataStore.query(IdeaMemo.classType);
    } catch (e) {
      return e;
    }
  }

  Future<IdeaMemo> readByIdIdea({int index}) async {
    try {
      final ideaObjects = await Amplify.DataStore.query(
        IdeaMemo.classType,
        where: IdeaMemo.ID.eq(
          ideaIdFirst + index.toString(),
        ),
      );

      if (ideaObjects.isEmpty) {
        print('No Data');
        return null;
      }

      final docObject = ideaObjects.first;

      return docObject;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<IdeaMemo> update({int index, String memo}) async {
    final ideaObject = await readByIdIdea(index: index);
    final updateIdea = ideaObject.copyWith(memo: memo);

    await Amplify.DataStore.save(updateIdea);

    return updateIdea;
  }

  Future<IdeaMemo> deleteIdea({int index}) async {
    try {
      final ideaObject = await readByIdIdea(index: index);
      await Amplify.DataStore.delete(ideaObject);

      return ideaObject;
    } catch (e) {
      throw e;
    }
  }

  Future<SearchHistory> createTag({String tags, int index}) async {
    final tagObject = SearchHistory(
      id: tagIdFirst + index.toString(),
      searchHistory: tags,
    );

    try {
      await Amplify.DataStore.save(tagObject);

      return tagObject;
    } catch (e) {
      return e;
    }
  }

  Future<List<SearchHistory>> searchTags() async {
    try {
      return await Amplify.DataStore.query(SearchHistory.classType);
    } catch (e) {
      return e;
    }
  }

  Future<SearchHistory> readByIdSearchTag({int index}) async {
    try {
      final tagsObjects = await Amplify.DataStore.query(
        SearchHistory.classType,
        where: SearchHistory.ID.eq(
          tagIdFirst + index.toString(),
        ),
      );

      if (tagsObjects.isEmpty) {
        print('No Data');
        return null;
      }

      final tagObject = tagsObjects.first;

      return tagObject;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<SearchHistory> updateTag({int index, String tag}) async {
    final tagObject = await readByIdSearchTag(index: index);
    final updateTag = tagObject.copyWith(searchHistory: tag);

    await Amplify.DataStore.save(updateTag);

    return updateTag;
  }

  Future<SearchHistory> deleteTag({int index}) async {
    try {
      final tagObject = await readByIdSearchTag(index: index);
      await Amplify.DataStore.delete(tagObject);

      return tagObject;
    } catch (e) {
      throw e;
    }
  }
}
