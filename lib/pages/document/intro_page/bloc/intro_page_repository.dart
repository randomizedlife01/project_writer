import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class IntroDocumentRepository {
  Future<List<Document>> readDocument({List<Document> docObject}) async {
    try {
      docObject = await Amplify.DataStore.query(Document.classType);
      return docObject;
    } catch (e) {
      throw e;
    }
  }

  Future<Document> createDocument({String docName, String docDesc, String id}) async {
    final docObject = Document(
      id: id,
      docName: docName,
      docDesc: docDesc,
    );

    try {
      await Amplify.DataStore.save(docObject);

      return docObject;
    } catch (e) {
      return e;
    }
  }

  Future<Document> readByIdDocument({String id}) async {
    try {
      final docObjects = await Amplify.DataStore.query(
        Document.classType,
        where: Document.ID.eq(
          id,
        ),
      );

      if (docObjects.isEmpty) {
        print('No Data');
        return null;
      }

      final docObject = docObjects.first;

      return docObject;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<Document> update({String id, String docName, String docDesc}) async {
    final docObject = await readByIdDocument(id: id);
    final updateDoc = docObject.copyWith(docName: docName, docDesc: docDesc);

    await Amplify.DataStore.save(updateDoc);

    return updateDoc;
  }

  Future<Document> deleteIdea({String id}) async {
    try {
      final docObject = await readByIdDocument(id: id);
      await Amplify.DataStore.delete(docObject);

      return docObject;
    } catch (e) {
      throw e;
    }
  }
}
