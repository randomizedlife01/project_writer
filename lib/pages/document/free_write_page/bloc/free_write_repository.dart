import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class FreeWriteRepository {
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

  Future<List<SearchHistory>> readTags({List<SearchHistory> searchHistory}) async {
    try {
      searchHistory = await Amplify.DataStore.query(SearchHistory.classType);
      return searchHistory;
    } catch (e) {
      throw e;
    }
  }

  Future<IdeaMemo> createIdea({String memo, String tags, String id}) async {
    final ideaObject = IdeaMemo(
      id: id,
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

  Future<IdeaMemo> readByIdIdea({String id}) async {
    try {
      final ideaObjects = await Amplify.DataStore.query(
        IdeaMemo.classType,
        where: IdeaMemo.ID.eq(
          id,
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

  Future<IdeaMemo> update({String id, String memo}) async {
    final ideaObject = await readByIdIdea(id: id);
    final updateIdea = ideaObject.copyWith(memo: memo);

    await Amplify.DataStore.save(updateIdea);

    return updateIdea;
  }

  Future<IdeaMemo> deleteIdea({String id}) async {
    try {
      final ideaObject = await readByIdIdea(id: id);
      await Amplify.DataStore.delete(ideaObject);

      return ideaObject;
    } catch (e) {
      throw e;
    }
  }

  Future<SearchHistory> createTag({String tags, String id}) async {
    final tagObject = SearchHistory(
      id: id,
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

  Future<SearchHistory> readByIdSearchTag({String id}) async {
    try {
      final tagsObjects = await Amplify.DataStore.query(
        SearchHistory.classType,
        where: SearchHistory.ID.eq(
          id,
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

  Future<SearchHistory> updateTag({String id, String tag}) async {
    final tagObject = await readByIdSearchTag(id: id);
    final updateTag = tagObject.copyWith(searchHistory: tag);

    await Amplify.DataStore.save(updateTag);

    return updateTag;
  }

  Future<SearchHistory> deleteTag({String id}) async {
    try {
      final tagObject = await readByIdSearchTag(id: id);
      await Amplify.DataStore.delete(tagObject);

      return tagObject;
    } catch (e) {
      throw e;
    }
  }
}
