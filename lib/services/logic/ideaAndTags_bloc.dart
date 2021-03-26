import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/SearchTags.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/note_repository.dart';
import 'package:rxdart/rxdart.dart';

class IdeaAndTagModel {
  List<IdeaMemo> idea;
  List<SearchTags> tags;

  IdeaAndTagModel(this.idea, this.tags);
}

class IdeasAndTagsBloc implements BlocBase {
  final ideaAndTagRepository = FreeWriteRepository();
  List<IdeaMemo> _ideaMemo;
  List<SearchTags> _searchTags;

  List<IdeaMemo> get ideaMemo => _ideaMemo;
  List<SearchTags> get searchTags => _searchTags;

  BehaviorSubject<List<IdeaMemo>> _ideaController = BehaviorSubject<List<IdeaMemo>>.seeded([]);
  BehaviorSubject<List<SearchTags>> _tagsController = BehaviorSubject<List<SearchTags>>.seeded([]);

  Stream<List<IdeaMemo>> get ideaStream => _ideaController.stream;
  Stream<List<SearchTags>> get searchTagsStream => _tagsController.stream;

  IdeasAndTagsBloc() {
    readIdeaAndTags();
  }

  Stream<IdeaAndTagModel> moviesUserFavouritesStream() {
    //readIdeaAndTags();
    return Rx.combineLatest2(ideaStream, searchTagsStream, (List<IdeaMemo> ideas, List<SearchTags> tags) {
      return IdeaAndTagModel(ideas, tags);
    });
  }

  Future<List<IdeaMemo>> readIdeas() async {
    try {
      _ideaMemo = await Amplify.DataStore.query(IdeaMemo.classType);
      return _ideaMemo;
    } catch (e) {
      return e;
    }
  }

  Future<List<SearchTags>> readTags({String id}) async {
    try {
      _searchTags = await Amplify.DataStore.query(SearchTags.classType);
      return _searchTags;
    } catch (e) {
      throw e;
    }
  }

  void readIdeaAndTags() async {
    try {
      _ideaMemo = await readIdeas();
      _searchTags = await readTags();

      print('idea : $_ideaMemo, tags : $_searchTags');

      _ideaController.add(_ideaMemo);
      _tagsController.add(_searchTags);
    } catch (e) {
      throw e;
    }
  }

  void addIdea({String memo, String tags, String id}) async {
    final ideaObject = IdeaMemo(
      id: id,
      memo: memo,
      tags: tags,
      isVisible: true,
    );

    final tag = tags.split(" ");

    try {
      await Amplify.DataStore.save(ideaObject);
      tag.forEach((element) async {
        final tagObject = SearchTags(id: element, tag: element);
        await Amplify.DataStore.save(tagObject);
        _searchTags.add(tagObject);
      });
      _ideaMemo.add(ideaObject);

      _ideaController.add(_ideaMemo);
      _tagsController.add(_searchTags);
    } catch (e) {
      return e;
    }
  }

  //TODO: 탐색기능부터 시작함.
  void readFilterdIdea({String searchTags}) async {
    try {
      final searchTagsList = await Amplify.DataStore.query(
        IdeaMemo.classType,
        where: IdeaMemo.TAGS.contains(
          searchTags,
        ),
      );
      print(searchTagsList);
      //_ideaController.add(searchTagsList);
    } catch (e) {
      throw e;
    }
  }

  void deleteIdeaAndTags({String id}) async {
    try {
      ideaAndTagRepository.deleteIdea(id: id);
      _ideaMemo.removeWhere((element) => element.id == id);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _tagsController.close();
    _ideaController.close();
  }
}
