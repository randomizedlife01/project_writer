import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';

class IdeaRepository {
  Future<IdeaMemo> createIdea({String memo, String tags, int length}) async {
    final ideaObject = IdeaMemo(
      id: 'idea_Id' + length.toString(),
      memo: memo,
      tags: tags,
    );

    print(ideaObject);

    try {
      await Amplify.DataStore.save(ideaObject);

      return ideaObject;
    } catch (e) {
      return e;
    }
  }

  Stream<List<IdeaMemo>> ideas() {
    try {
      return Amplify.DataStore.query(IdeaMemo.classType).asStream();
    } catch (e) {
      return e;
    }
  }

  Future<IdeaMemo> readByIdIdea({String id}) async {
    try {
      final ideaObjects = await Amplify.DataStore.query(
        IdeaMemo.classType,
        where: IdeaMemo.ID.eq(
          'idea_id' + id,
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
