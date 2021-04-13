import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/character_page/bloc/character_repository.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_repository.dart';

part 'character_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  List<CharacterData> myCharacters;

  final CharactersRepository myCharacterRepository;

  CharactersCubit({this.myCharacterRepository, this.myCharacters}) : super(CharactersLoading());

  Future<void> readMyCharacters() async {
    try {
      emit(CharactersLoading());

      myCharacters = await myCharacterRepository.readMyCharacters();

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

      emit(CharactersLoaded(myCharacters: myCharacters));
    } catch (e) {
      emit(CharactersNotLoaded());
    }
  }

  Future<void> createMyCharacter({String id, String motivation, String year, int tendency, String description}) async {
    try {
      emit(CharactersLoading());

      final data =
          await myCharacterRepository.createCharacter(id: id, motivation: motivation, tendency: tendency, description: description);
      myCharacters.add(data);

      emit(CharactersLoaded(myCharacters: myCharacters));
    } catch (e) {
      emit(CharactersNotLoaded());
      throw e;
    }
  }

  Future<void> updateMyCharacter({String id, String memo, String tag}) async {
    try {} catch (e) {
      emit(CharactersNotLoaded());
      throw e;
    }
  }

  Future<void> deleteMyCharacter({String id}) async {
    try {
      emit(CharactersLoading());

      final data = await myCharacterRepository.deleteMyCharacter(id: id);
      myCharacters.remove(data);

      emit(CharactersLoaded(myCharacters: myCharacters));
    } catch (e) {
      emit(CharactersNotLoaded());
      throw e;
    }
  }
}
