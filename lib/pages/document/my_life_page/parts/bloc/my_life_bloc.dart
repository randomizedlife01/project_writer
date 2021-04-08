import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_repository.dart';

part 'my_life_state.dart';

class MyLifeStoryCubit extends Cubit<MyLifeStoryState> {
  List<MyLifeStory> myLifeStory;

  final MyLifeRepository myLifeRepository;

  MyLifeStoryCubit({this.myLifeRepository, this.myLifeStory}) : super(MyLifeStoryLoading());

  Future<void> readMyStory() async {
    try {
      emit(MyLifeStoryLoading());

      //myLifeStory = await myLifeRepository.readMyStory();

      emit(MyLifeStoryLoaded(myLifeStory: myLifeStory));
    } catch (e) {
      emit(MyLifeStoryNotLoaded());
    }
  }

  Future<void> createMyStory({String id, String lifeMemo, TemporalDate date}) async {
    try {
      emit(MyLifeStoryLoading());

      final data = await myLifeRepository.createMyStory(id: id, lifeMemo: lifeMemo, date: date);
      myLifeStory.add(data);

      emit(MyLifeStoryLoaded(myLifeStory: myLifeStory));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateMyStory({String id, String memo, String tag}) async {
    try {} catch (e) {
      throw e;
    }
  }

  Future<void> deleteMyStory({String id}) async {
    try {
      emit(MyLifeStoryLoading());

      final data = await myLifeRepository.deleteMyStory(id: id);
      myLifeStory.remove(data);

      emit(MyLifeStoryLoaded(myLifeStory: myLifeStory));
    } catch (e) {
      throw e;
    }
  }
}
