import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class IdeaRepository {
  Future<IdeaMemo> createIdea({String memo, String tags, String id}) async {
    final ideaObject = IdeaMemo(
      id: id,
      memo: memo,
      tags: tags,
    );

    //TODO: 태그 저장용 만들고 분할 태그 만들고... 그리고 CRUD 및 검색하기 추가
    print(ideaObject);

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

  Future<IdeaMemo> delete({String id}) async {
    try {
      final ideaObject = await readByIdIdea(id: id);
      await Amplify.DataStore.delete(ideaObject);

      // List<StorySummary> listData = await Amplify.DataStore.query(
      //   StorySummary.classType,
      //   where: StorySummary.DOCUMENTID.eq(
      //     documentId,
      //   ),
      // );
      //
      // listData.forEach(
      //   (element) {
      //     Amplify.DataStore.delete(element);
      //   },
      // );

      return ideaObject;
    } catch (e) {
      throw e;
    }
  }
}
