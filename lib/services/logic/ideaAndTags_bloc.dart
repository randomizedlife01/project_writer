import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/SearchTags.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class IdeaAndTagModel {
  List<IdeaMemo> idea;
  List<SearchTags> tags;

  IdeaAndTagModel(this.idea, this.tags);
}

class IdeasAndTagsBloc implements BlocBase {
  List<IdeaMemo> _ideaMemo = [];
  List<SearchTags> _searchTags = [];

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

  Stream<IdeaAndTagModel> moviesUserFavouritesStream() {
    readIdeaAndTags();
    return Rx.combineLatest2(ideaStream, searchTagsStream, (List<IdeaMemo> ideas, List<SearchTags> tags) {
      return IdeaAndTagModel(ideas, tags);
    });
  }

  Stream<IdeaAndTagModel> get counterObservable =>
      Rx.combineLatest2(ideaStream, searchTagsStream, (ideas, tags) => IdeaAndTagModel(ideas, tags));

  void readIdeas() async {
    try {
      _ideaMemo = await Amplify.DataStore.query(IdeaMemo.classType);
    } catch (e) {
      throw e;
    }
  }

  void readTags() async {
    //TODO: 오류 지점.
    try {
      _searchTags = await Amplify.DataStore.query(SearchTags.classType);
    } catch (e) {
      throw e;
    }
  }

  void readIdeaAndTags() {
    try {
      readIdeas();
      readTags();

      _ideaController.add(_ideaMemo);
      _tagsController.add(_searchTags);

      print('idea : $_ideaMemo, tags : $_searchTags');
    } catch (e) {
      return e;
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
    // TODO: implement dispose
    _tagsController.close();
    _ideaController.close();
  }
}
