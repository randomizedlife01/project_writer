import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class MyLifeRepository {
  Future<List<MyLifeStory>> readMyStory() async {
    try {
      final myLifeStory =
          await Amplify.DataStore.query(MyLifeStory.classType, sortBy: [MyLifeStory.YEAR.ascending(), MyLifeStory.SEASON.ascending()]);

      return myLifeStory;
    } catch (e) {
      throw e;
    }
  }

  Future<MyLifeStory> createMyStory({String lifeMemo, String year, String season, String month, String day, String id}) async {
    final myLifeStory = MyLifeStory(
      id: id,
      lifeMemo: lifeMemo,
      year: year,
      season: season,
      month: month,
      date: day,
    );

    try {
      //await Amplify.DataStore.save(myLifeStory);

      return myLifeStory;
    } catch (e) {
      return e;
    }
  }

  Future<MyLifeStory> readByIdMyStory({String id}) async {
    try {
      final myLifeStories = await Amplify.DataStore.query(
        MyLifeStory.classType,
        where: MyLifeStory.ID.eq(
          id,
        ),
      );

      if (myLifeStories.isEmpty) {
        print('No Data');
        return null;
      }

      final myLifeStory = myLifeStories.first;

      return myLifeStory;
    } catch (e) {
      throw (e);
    }
  }

  Future<MyLifeStory> updateMyStory({String id, String lifeMemo}) async {
    final myLifeStory = await readByIdMyStory(id: id);
    final updateMyStory = myLifeStory.copyWith(lifeMemo: lifeMemo);

    await Amplify.DataStore.save(updateMyStory);

    return updateMyStory;
  }

  Future<MyLifeStory> deleteMyStory({String id}) async {
    try {
      final myLifeStory = await readByIdMyStory(id: id);
      await Amplify.DataStore.delete(myLifeStory);

      return myLifeStory;
    } catch (e) {
      throw e;
    }
  }
}
