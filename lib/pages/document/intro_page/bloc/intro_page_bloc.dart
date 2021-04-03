import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/intro_page/bloc/intro_page_repository.dart';

part 'intro_page_state.dart';

class IntroDocumentCubit extends Cubit<IntroDocumentState> {
  List<Document> document = [];

  final IntroDocumentRepository introDocumentRepository;

  IntroDocumentCubit({this.introDocumentRepository, this.document}) : super(IntroDocumentLoading());

  Future<void> readDocument() async {
    try {
      emit(IntroDocumentLoading());

      document = await introDocumentRepository.readDocument();

      emit(IntroDocumentLoaded(document: document));
    } catch (e) {
      emit(IntroDocumentNotLoaded());
    }
  }

  Future<void> createDoc({String id, String docName, String docDesc}) async {
    try {
      emit(IntroDocumentLoading());

      final data = await introDocumentRepository.createDocument(
        id: 'docId' + state.document.length.toString(),
        docName: docName,
        docDesc: docDesc,
      );
      document.add(data);

      emit(IntroDocumentLoaded(document: document));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateDoc({String id, String docName, String docDesc}) async {
    try {
      emit(IntroDocumentLoading());

      await introDocumentRepository.update(id: id, docName: docName, docDesc: docDesc);
      readDocument();

      emit(IntroDocumentLoaded(document: document));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteDoc({String id}) async {
    try {
      emit(IntroDocumentLoading());

      final data = await introDocumentRepository.deleteIdea(id: id);
      document.remove(data);

      emit(IntroDocumentLoaded(document: document));
    } catch (e) {
      throw e;
    }
  }
}
