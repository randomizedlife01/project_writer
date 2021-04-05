import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/story_page/bloc/story_repository.dart';

part 'story_state.dart';

class StorySummaryCubit extends Cubit<StorySummaryState> {
  final String documentId;

  List<StorySummary> summaries = [];
  bool isVisible = false;

  final StorySummaryRepository storySummaryRepository;

  StorySummaryCubit({@required this.documentId, @required this.storySummaryRepository, this.summaries, this.isVisible})
      : super(StorySummaryLoading());

  Future<void> readStorySummaries() async {
    try {
      emit(StorySummaryLoading());

      summaries = await storySummaryRepository.readStorySummary(documentId: documentId);

      emit(StorySummaryLoaded(storySummaries: summaries, isVisible: isVisible));
    } catch (e) {
      emit(StorySummaryNotLoaded());
    }
  }

  Future<void> createSummary({String id, String storySummary}) async {
    try {
      emit(StorySummaryLoading());

      final data = await storySummaryRepository.createStorySummary(
        id: id,
        storySummary: storySummary,
      );
      summaries.add(data);

      emit(StorySummaryLoaded(storySummaries: summaries, isVisible: isVisible));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateDoc({String id, String storySummary}) async {
    try {
      emit(StorySummaryLoading());

      await storySummaryRepository.updateStorySummary(storySummaryId: id, storySummary: storySummary);
      readStorySummaries();

      emit(StorySummaryLoaded(storySummaries: summaries, isVisible: isVisible));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteDoc({String id}) async {
    try {
      emit(StorySummaryLoading());

      final data = await storySummaryRepository.deleteStorySummary(storySummaryId: id);
      summaries.remove(data);

      emit(StorySummaryLoaded(storySummaries: summaries, isVisible: isVisible));
    } catch (e) {
      throw e;
    }
  }

  Future<void> selectVisible() async {
    try {
      emit(StorySummaryLoading());

      isVisible = !isVisible;

      emit(StorySummaryLoaded(storySummaries: summaries, isVisible: isVisible));
    } catch (e) {
      throw e;
    }
  }
}
