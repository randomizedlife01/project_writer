part of 'intro_page_bloc.dart';

@immutable
abstract class IntroDocumentState extends Equatable {
  final List<Document> document;

  const IntroDocumentState({this.document});

  @override
  List<Object> get props => [document];
}

class IntroDocumentLoading extends IntroDocumentState {
  @override
  String toString() => 'Ideas Loading';
}

class IntroDocumentLoaded extends IntroDocumentState {
  final List<Document> document;

  IntroDocumentLoaded({this.document = const []}) : super(document: document);

  @override
  String toString() => 'Document Loaded { Document Loaded: $document}';
}

class IntroDocumentNotLoaded extends IntroDocumentState {
  @override
  String toString() => 'Document Loaded Loaded NotLoaded';
}
