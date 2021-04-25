import 'package:get/get.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/services/controller/character_repository.dart';

class CharactersController extends GetxController {
  List<CharacterData> myCharacters = [];

  final CharactersRepository myCharacterRepository = CharactersRepository();

  static CharactersController get to => Get.find<CharactersController>();

  @override
  void onInit() {
    super.onInit();
  }

  readMyCharacters() async {
    try {
      myCharacters = await myCharacterRepository.readMyCharacters();
      update();

      // myLifeStory.forEach((element) {
      //   if (!years.contains(element.year)) {
      //     years.add(element.year);
      //   }
      // });
      //
      // myLifeStory.forEach((element) {
      //   if (!seasons.contains(element.season)) {
      //     seasons.add(element.season);
      //   }
      // });

    } catch (e) {
      print(e);
    }
  }

  createMyCharacter({
    String id,
    String motivation,
    String name,
    int tendency,
    String description,
    String age,
    String gender,
  }) async {
    try {
      final data = await myCharacterRepository.createCharacter(
        id: id,
        name: name,
        age: age,
        gender: gender,
        motivation: motivation,
        tendency: tendency,
        description: description,
      );
      myCharacters.add(data);
      update();
    } catch (e) {
      print(e);
    }
  }

  updateMyCharacter({String id, String memo, String tag}) async {
    try {} catch (e) {
      print(e);
    }
  }

  deleteMyCharacter({String id}) async {
    try {
      final data = await myCharacterRepository.deleteMyCharacter(id: id);
      myCharacters.remove(data);
      update();
    } catch (e) {
      print(e);
    }
  }
}
