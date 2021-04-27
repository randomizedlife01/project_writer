import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class MyLifeRepository {
  Future<List<MyLifeYear>> readMyYear() async {
    try {
      final myLifeYear = await Amplify.DataStore.query(MyLifeYear.classType, sortBy: [MyLifeYear.YEAR.ascending()]);
      return myLifeYear;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<MyLifeYear> createMyYear({String id, String year}) async {
    try {
      final myLifeYear = MyLifeYear(id: id, year: year);

      await Amplify.DataStore.save(myLifeYear);
      return myLifeYear;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<List<MyLifeSeason>> readMySeason({String yearId}) async {
    try {
      final myLifeSeason = await Amplify.DataStore.query(
        MyLifeSeason.classType,
        where: MyLifeSeason.MYLIFEYEARID.contains(
          yearId,
        ),
      );
      return myLifeSeason;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<MyLifeSeason> createMySeason({String id, String yearId, String season}) async {
    try {
      final myLifeSeason = MyLifeSeason(id: id, mylifeyearID: yearId, season: season);

      await Amplify.DataStore.save(myLifeSeason);
      return myLifeSeason;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<List<MyLifeDetail>> readMyDetail({String seasonId}) async {
    try {
      final myLifeDetail = await Amplify.DataStore.query(
        MyLifeDetail.classType,
        where: MyLifeDetail.MYLIFESEASONID.contains(
          seasonId,
        ),
      );
      return myLifeDetail;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<MyLifeDetail> createMyDetail({String id, String seasonId, String month, String date, String lifeMemo}) async {
    try {
      final myLifeDetail = MyLifeDetail(id: id, mylifeseasonID: seasonId, month: month ?? '', date: date ?? '', lifeMemo: lifeMemo ?? '');
      await Amplify.DataStore.save(myLifeDetail);
      return myLifeDetail;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  // Future<MyLifeStory> readByIdMyStory({String id}) async {
  //   try {
  //     final myLifeStories = await Amplify.DataStore.query(
  //       MyLifeStory.classType,
  //       where: MyLifeStory.ID.eq(
  //         id,
  //       ),
  //     );
  //
  //     if (myLifeStories.isEmpty) {
  //       print('No Data');
  //       return null;
  //     }
  //
  //     final myLifeStory = myLifeStories.first;
  //
  //     return myLifeStory;
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // Future<MyLifeStory> updateMyStory({String id, String lifeMemo}) async {
  //   final myLifeStory = await readByIdMyStory(id: id);
  //   final updateMyStory = myLifeStory.copyWith(lifeMemo: lifeMemo);
  //
  //   await Amplify.DataStore.save(updateMyStory);
  //
  //   return updateMyStory;
  // }
  //
  // Future<MyLifeStory> deleteMyStory({String id}) async {
  //   try {
  //     final myLifeStory = await readByIdMyStory(id: id);
  //     await Amplify.DataStore.delete(myLifeStory);
  //
  //     return myLifeStory;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
