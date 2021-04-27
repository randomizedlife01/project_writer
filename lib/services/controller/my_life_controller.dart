import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/services/controller/my_life_repository.dart';

class MyLifeStoryController extends GetxController {
  final myLifeYear = [].obs;
  final myLifeSeason = [].obs;
  final myLifeDetail = [].obs;

  final MyLifeRepository myLifeRepository = MyLifeRepository();

  static MyLifeStoryController get to => Get.find<MyLifeStoryController>();

  @override
  void onInit() {
    super.onInit();
  }

  readMyYear() async {
    try {
      myLifeYear(await myLifeRepository.readMyYear());
    } catch (e) {
      print(e);
    }
  }

  createMyYear({String year}) async {
    try {
      int _lastYearIdNum = 0;

      if (myLifeYear.isNotEmpty) {
        final lastId = myLifeYear.last.id;
        final number = lastId.split("_").last;
        _lastYearIdNum = int.parse(number);
      }

      final data = await myLifeRepository.createMyYear(
        id: 'my_year_' + (_lastYearIdNum + 1).toString(),
        year: year,
      );

      myLifeYear.add(data);
    } catch (e) {
      print(e.toString());
    }
  }

  readMySeason({@required String yearId}) async {
    try {
      myLifeSeason(await myLifeRepository.readMySeason(yearId: yearId));
    } catch (e) {
      print(e);
    }
  }

  createMySeason({String yearId, String season}) async {
    try {
      int _lastSeasonIdNum = 0;

      if (myLifeSeason.isNotEmpty) {
        final lastId = myLifeSeason.last.id;
        final number = lastId.split("_").last;
        _lastSeasonIdNum = int.parse(number);
      }

      final data = await myLifeRepository.createMySeason(
        id: 'my_season_' + (_lastSeasonIdNum + 1).toString(),
        yearId: yearId,
        season: season,
      );

      myLifeSeason.add(data);
    } catch (e) {
      print(e.toString());
    }
  }

  readMyDetail({@required String seasonId}) async {
    try {
      myLifeDetail(await myLifeRepository.readMyDetail(seasonId: seasonId));
    } catch (e) {
      print(e);
    }
  }

  createMyDetail({String seasonId, String month, String date, String lifeMemo}) async {
    try {
      int _lastDetailIdNum = 0;

      if (myLifeDetail.isNotEmpty) {
        final lastId = myLifeDetail.last.id;
        final number = lastId.split("_").last;
        _lastDetailIdNum = int.parse(number);
      }

      final data = await myLifeRepository.createMyDetail(
        id: 'my_detail_' + (_lastDetailIdNum + 1).toString(),
        seasonId: seasonId,
        month: month,
        date: date,
        lifeMemo: lifeMemo,
      );

      myLifeDetail.add(data);
    } catch (e) {
      print(e.toString());
    }
  }

  // readMyStory() async {
  //   try {
  //     myLifeStory(await myLifeRepository.readMyStory());
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // createMyStory({String lifeMemo, String year, String season, String month, String day}) async {
  //   try {
  //     int _lastMyStoryIdNum = 0;
  //
  //     if (myLifeStory.isNotEmpty) {
  //       final lastId = myLifeStory.last.id;
  //       final number = lastId.split("_").last;
  //       _lastMyStoryIdNum = int.parse(number);
  //     }
  //
  //     final data = await myLifeRepository.createMyStory(
  //       id: 'my_life_' + (_lastMyStoryIdNum + 1).toString(),
  //       lifeMemo: lifeMemo,
  //       year: year,
  //       season: season,
  //       month: month,
  //       day: day,
  //     );
  //     myLifeStory.add(data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // updateMyStory({String id, String memo, String tag}) async {
  //   try {} catch (e) {
  //     print(e);
  //   }
  // }
  //
  // deleteMyStory({String id}) async {
  //   try {
  //     final data = await myLifeRepository.deleteMyStory(id: id);
  //     myLifeStory.remove(data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
