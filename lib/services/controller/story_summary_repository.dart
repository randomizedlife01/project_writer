import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class StorySummaryRepository {
  Future<List<StorySummary>> readStorySummary({String documentId}) async {
    try {
      final summaries = await Amplify.DataStore.query(
        StorySummary.classType,
        where: StorySummary.DOCUMENTID.contains(
          documentId,
        ),
      );
      return summaries;
    } catch (e) {
      throw e;
    }
  }

  Future<StorySummary> createStorySummary(
      {String id, String documentId, String storySummary, String space, String time, String weather}) async {
    try {
      final summaryObject = StorySummary(
        documentID: documentId,
        id: id,
        storySummary: storySummary,
        space: space,
        time: time,
        weather: weather,
      );
      await Amplify.DataStore.save(summaryObject);
      return summaryObject;
    } catch (e) {
      throw e;
    }
  }

  Future<StorySummary> readByIdStorySummary({String storySummaryId}) async {
    try {
      final summaryObjects = await Amplify.DataStore.query(
        StorySummary.classType,
        where: Document.ID.eq(
          storySummaryId,
        ),
      );

      if (summaryObjects.isEmpty) {
        print('No Data');
        return null;
      }

      final summaryObject = summaryObjects.first;

      return summaryObject;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<StorySummary> updateStorySummary({String storySummaryId, String storySummary}) async {
    final summaryObject = await readByIdStorySummary(storySummaryId: storySummaryId);
    final updateSummary = summaryObject.copyWith(storySummary: storySummary);

    await Amplify.DataStore.save(updateSummary);

    return updateSummary;
  }

  Future<StorySummary> deleteStorySummary({String storySummaryId}) async {
    try {
      final summaryObject = await readByIdStorySummary(storySummaryId: storySummaryId);
      await Amplify.DataStore.delete(summaryObject);

      return summaryObject;
    } catch (e) {
      throw e;
    }
  }
}
