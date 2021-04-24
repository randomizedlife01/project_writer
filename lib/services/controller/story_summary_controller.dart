import 'package:get/get.dart';
import 'package:project_writer_v04/services/controller/story_summary_repository.dart';

class StorySummaryController extends GetxController {
  final summaries = [].obs;
  final isVisible = false.obs;
  final selectTimes = '새벽'.obs;
  final spaceList = ''.obs;
  final selectWeathers = '맑음'.obs;
  final setDocumentId = ''.obs;
  final setDropDownVisible = true.obs;
  final getSummary = ''.obs;
  final summaryId = ''.obs;
  final storyDetails = ''.obs;

  final StorySummaryRepository storySummaryRepository = StorySummaryRepository();

  static StorySummaryController get to => Get.find<StorySummaryController>();

  @override
  void onInit() {
    super.onInit();
  }

  getSummaryId({String id}) {
    summaryId(id);
  }

  getSummaryData({String id, String summary, String storyDetail}) {
    summaryId(id);
    getSummary(summary);
    storyDetails(storyDetail);
  }

  selectDropDownVisible({bool isVisible}) {
    setDropDownVisible(isVisible);
  }

  selectDocumentId({String documentId}) {
    setDocumentId(documentId);
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
      summaries(await storySummaryRepository.readStorySummary(documentId: getDocumentId));
    } catch (e) {
      print(e);
    }
  }

  createSummary({String id, String documentId, String storySummary, String space, String time, String weather, String storyDetail}) async {
    try {
      final data = await storySummaryRepository.createStorySummary(
        id: id ?? '',
        documentId: documentId ?? '',
        storySummary: storySummary ?? '',
        space: space ?? '',
        time: time ?? '',
        weather: weather ?? '',
        storyDetail: storyDetail ?? '',
      );
      summaries.add(data);
    } catch (e) {
      print(e);
    }
  }

  updateSummary({String id, String storyDetail}) async {
    try {
      final updateData = await storySummaryRepository.updateStorySummary(storySummaryId: id, storyDetail: storyDetail);
      summaries[summaries.indexWhere((element) => element.id == updateData.id)] = updateData;
    } catch (e) {
      print(e);
    }
  }

  deleteSummary({String id}) async {
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
