import 'package:get/get.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_repository.dart';

class StorySummaryController extends GetxController {
  final summaries = [].obs;
  final isVisible = false.obs;
  final selectTimes = '없음'.obs;
  final spaceList = ''.obs;
  final selectWeathers = '없음'.obs;
  final setDocumentId = ''.obs;
  final setDropDownVisible = true.obs;
  final getSummary = ''.obs;
  final summaryId = ''.obs;
  final storyDetails = ''.obs;
  final summaryVisible = true.obs;

  final StorySummaryRepository storySummaryRepository = StorySummaryRepository();

  static StorySummaryController get to => Get.find<StorySummaryController>();

  @override
  void onInit() {
    super.onInit();
  }

  changeSummaryDetail({String value}) {
    storyDetails(value);
  }

  changeSummary({String value}) {
    getSummary(value);
  }

  changeSpace({String value}) {
    spaceList(value);
  }

  addCharacterName({CharactersController charactersController, int index}) {
    return storyDetails('${storyDetails.value}\n' + charactersController.myCharacters[index].name + ' : ');
  }

  getSummaryData({String id, String summary, String storyDetail, String time, String space, String weather}) {
    summaryId(id);
    getSummary(summary);
    storyDetails(storyDetail);
    selectTimes(time);
    spaceList(space);
    selectWeathers(weather);
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

  changeSummaryVisible({bool isVisible}) {
    summaryVisible(isVisible);
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

  updateSummary({String id, String storyDetail, String storySummary, String time, String space, String weather}) async {
    try {
      final updateData = await storySummaryRepository.updateStorySummary(
        storySummaryId: id,
        storyDetail: storyDetail,
        storySummary: storySummary,
        time: time,
        space: space,
        weather: weather,
      );
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
