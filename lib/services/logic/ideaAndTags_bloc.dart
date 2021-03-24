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

  // Stream<List<IdeaAndTagsModel>> moviesUserFavouritesStream() {
  //   return Rx.combineLatest2(ideasStream(), tagsStream(), (List<IdeaMemo> ideas, List<SearchTags> tags) {
  //     if (ideas.isNotEmpty && tags.isNotEmpty) {
  //       return ideas.map((idea) {
  //         final userFavourite = tags?.firstWhere((userFavourite) => userFavourite.tag.contains(idea.tags), orElse: () => null);
  //         return IdeaAndTagsModel(
  //           idea,
  //           userFavourite?.tag ?? false,
  //         );
  //       }).toList();
  //     } else {
  //       return null;
  //     }
  //   });
  // }

  //TODO: 오옷쓰 쓰기 읽기 되었음. 이젠 태그랑 분리해서 저장하고 검색기능 하기...
  Stream<IdeaAndTagModel> moviesUserFavouritesStream() {
    readIdeaAndTags();
    return Rx.combineLatest2(ideaStream, searchTagsStream, (List<IdeaMemo> ideas, List<SearchTags> tags) {
      //print('idea : $ideas, tag : $tags');
      return IdeaAndTagModel(ideas, tags);
    });
  }

  Future<List<IdeaMemo>> readIdeas() async {
    try {
      _ideaMemo = await ideaAndTagRepository.ideas();
      return _ideaMemo;
    } catch (e) {
      throw e;
    }
  }

  Future<List<SearchTags>> readTags({String id}) async {
    try {
      _searchTags = await Amplify.DataStore.query(SearchTags.classType);
      print(searchTags);
    } catch (e) {
      throw e;
    }
  }

  void readIdeaAndTags() async {
    try {
      _ideaMemo = await readIdeas();
      _searchTags = await readTags();

      _ideaController.add(_ideaMemo);
      _tagsController.add(_searchTags);

      print('idea : $_ideaMemo, tags : $_searchTags');
    } catch (e) {
      throw e;
    }
  }

  void addIdea({String memo, String tags, String id}) async {
    final ideaObject = IdeaMemo(
      id: id,
      memo: memo,
      tags: tags,
    );

    try {
      await Amplify.DataStore.save(ideaObject);
      _ideaMemo.add(ideaObject);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      return e;
    }
  }

  @override
  void dispose() {
    _tagsController.close();
    _ideaController.close();
  }
}
