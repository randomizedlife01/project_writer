import 'package:get/get.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/controller/my_life_repository.dart';

class MyLifeStoryController extends GetxController {
  List<MyLifeStory> myLifeStory = [];
  List<String> years = [];
  List<String> seasons = [];

  final MyLifeRepository myLifeRepository = MyLifeRepository();

  static MyLifeStoryController get to => Get.find<MyLifeStoryController>();

  @override
  void onInit() {
    super.onInit();
  }

  changeSeasonToInt() async {}

  readMyStory() async {
    try {
      myLifeStory = await myLifeRepository.readMyStory();

      myLifeStory.forEach((element) {
        if (!years.contains(element.year)) {
          years.add(element.year);

          update();
        }
      });

      myLifeStory.forEach((element) {
        if (!seasons.contains(element.season)) {
          seasons.add(element.season);

          update();
        }
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  createMyStory({String lifeMemo, String year, String season, String month, String day}) async {
    try {
      int _lastMyStoryIdNum = 0;

      if (myLifeStory.isNotEmpty) {
        final lastId = myLifeStory.last.id;
        final number = lastId.split("_").last;
        _lastMyStoryIdNum = int.parse(number);
      }

      final data = await myLifeRepository.createMyStory(
        id: 'my_life_' + (_lastMyStoryIdNum + 1).toString(),
        lifeMemo: lifeMemo,
        year: year,
        season: season,
        month: month,
        day: day,
      );
      myLifeStory.add(data);
      update();
    } catch (e) {
      print(e);
    }
  }

  updateMyStory({String id, String memo, String tag}) async {
    try {} catch (e) {
      print(e);
    }
  }

  deleteMyStory({String id}) async {
    try {
      final data = await myLifeRepository.deleteMyStory(id: id);
      myLifeStory.remove(data);
      update();
    } catch (e) {
      print(e);
    }
  }
}
