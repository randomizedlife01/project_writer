import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class FreeWriteRepository {
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

  Future<IdeaMemo> update({String id}) async {
    final ideaObject = await readByIdIdea(id: id);
    final updateIdea = ideaObject.copyWith(memo: 'new DocName');

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

  //TODO: 태그 검색시 태그 id로 검색하고 일치하면 리스트 띄우기
  Future<List<SearchTags>> getTags({String documentId}) async {
    try {
      final data = await Amplify.DataStore.query(
        SearchTags.classType,
        where: SearchTags.IDEAMEMOID.contains(
          documentId,
        ),
      );

      return data;
    } catch (e) {
      throw e;
    }
  }
}
