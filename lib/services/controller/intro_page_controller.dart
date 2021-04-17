import 'package:get/get.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/controller/intro_page_repository.dart';

class IntroDocumentController extends GetxController {
  List<Document> document = [];

  final IntroDocumentRepository introDocumentRepository = IntroDocumentRepository();

  static IntroDocumentController get to => Get.find<IntroDocumentController>();

  @override
  void onInit() {
    super.onInit();
  }

  readDocument() async {
    try {
      document = await introDocumentRepository.readDocument();
      update();
    } catch (e) {
      print(e);
    }
  }

  createDoc({String id, String docName, String docDesc}) async {
    try {
      final data = await introDocumentRepository.createDocument(
        id: id,
        docName: docName,
        docDesc: docDesc,
      );
      document.add(data);
      update();
    } catch (e) {
      print(e);
    }
  }

  updateDoc({String id, String docName, String docDesc}) async {
    try {
      final data = await introDocumentRepository.update(id: id, docName: docName, docDesc: docDesc);
    } catch (e) {
      print(e);
    }
  }

  deleteDoc({String id}) async {
    try {
      final data = await introDocumentRepository.deleteIdea(id: id);
      document.remove(data);
      update();
    } catch (e) {
      print(e);
    }
  }
}
