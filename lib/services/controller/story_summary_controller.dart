import 'package:get/get.dart';
import 'package:project_writer_v04/models/StorySummary.dart';
import 'package:project_writer_v04/services/controller/story_summary_repository.dart';

class StorySummaryController extends GetxController {
  final documentId = ''.obs;
  final summaries = [].obs;
  final isVisible = false.obs;
  final selectTimes = '새벽'.obs;
  final spaceList = ''.obs;
  final selectWeathers = '맑음'.obs;

  final StorySummaryRepository storySummaryRepository = StorySummaryRepository();

  static StorySummaryController get to => Get.find<StorySummaryController>();

  @override
  void onInit() {
    super.onInit();
  }

  selectTime({String timeValue}) {
    selectTimes(timeValue);
  }

  selectSpace({String spaceValue}) {
    spaceList(spaceValue);
  }

  selectWeather({String weatherValue}) {
    selectWeathers(weatherValue);
  }

  getDocumentName() async {
    try {} catch (e) {
      print(e);
    }
  }

  readStorySummaries({String getDocumentId}) async {
    try {
      summaries(await storySummaryRepository.readStorySummary(documentId: documentId(getDocumentId)));
    } catch (e) {
      print(e);
    }
  }

  createSummary({String id, String setDocumentId, String storySummary, String space, String time, String weather}) async {
    try {
      final data = await storySummaryRepository.createStorySummary(
        id: id,
        documentId: documentId(setDocumentId),
        storySummary: storySummary,
        space: space,
        time: time,
        weather: weather,
      );
      summaries.add(data);
      print(summaries);
    } catch (e) {
      print(e);
    }
  }

  updateDoc({String id, String storySummary}) async {
    try {
      await storySummaryRepository.updateStorySummary(storySummaryId: id, storySummary: storySummary);
      readStorySummaries();
    } catch (e) {
      print(e);
    }
  }

  deleteDoc({String id}) async {
    try {
      final data = await storySummaryRepository.deleteStorySummary(storySummaryId: id);
      summaries.remove(data);
    } catch (e) {
      print(e);
    }
  }

  selectVisible({bool getVisible}) async {
    try {
      isVisible(getVisible);
    } catch (e) {
      print(e);
    }
  }
}
