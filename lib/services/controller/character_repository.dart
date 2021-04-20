import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class CharactersRepository {
  Future<List<CharacterData>> readMyCharacters() async {
    try {
      final characterData = await Amplify.DataStore.query(CharacterData.classType);

      return characterData;
    } catch (e) {
      throw e;
    }
  }

  Future<CharacterData> createCharacter({String id, String name, String motivation, int tendency, String description}) async {
    final myCharacter = CharacterData(
      id: id,
      name: name,
      motivation: motivation,
      tendency: tendency,
      description: description,
    );

    try {
      await Amplify.DataStore.save(myCharacter);

      return myCharacter;
    } catch (e) {
      return e;
    }
  }

  Future<CharacterData> readByIdCharacter({String id}) async {
    try {
      final myCharacters = await Amplify.DataStore.query(
        CharacterData.classType,
        where: CharacterData.ID.eq(
          id,
        ),
      );

      if (myCharacters.isEmpty) {
        print('No Data');
        return null;
      }

      final myCharacter = myCharacters.first;

      return myCharacter;
    } catch (e) {
      throw (e);
    }
  }

  Future<CharacterData> updateMyCharacter({String id, String description}) async {
    final myCharacter = await readByIdCharacter(id: id);
    final updateCharacter = myCharacter.copyWith(description: description);

    await Amplify.DataStore.save(updateCharacter);

    return updateCharacter;
  }

  Future<CharacterData> deleteMyCharacter({String id}) async {
    try {
      final myCharacter = await readByIdCharacter(id: id);
      await Amplify.DataStore.delete(myCharacter);

      return myCharacter;
    } catch (e) {
      throw e;
    }
  }
}
