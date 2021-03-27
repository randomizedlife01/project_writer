import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/note_repository.dart';
import 'package:rxdart/rxdart.dart';

enum VisibleFilter { all, active, dismiss }

class IdeaAndTagModel {
  List<IdeaMemo> idea;

  IdeaAndTagModel(this.idea);
}

class IdeasBloc implements BlocBase {
  final ideaAndTagRepository = FreeWriteRepository();
  List<IdeaMemo> _ideaMemo;

  List<IdeaMemo> get ideaMemo => _ideaMemo;

  BehaviorSubject<List<IdeaMemo>> _ideaController = BehaviorSubject<List<IdeaMemo>>.seeded([]);

  Stream<List<IdeaMemo>> get ideaStream => _ideaController.stream;

  IdeasBloc() {
    readIdeas();
  }

  // Stream<IdeaAndTagModel> moviesUserFavouritesStream() {
  //   //readIdeaAndTags();
  //   return Rx.combineLatest2(ideaStream, searchTagsStream, (List<IdeaMemo> ideas, VisibleFilter filter) {
  //     return IdeaAndTagModel(ideas, filter);
  //   });
  // }

  void readIdeas() async {
    try {
      _ideaMemo = await Amplify.DataStore.query(IdeaMemo.classType);
      _ideaController.add(_ideaMemo);
    } catch (e) {
      return e;
    }
  }

  // Future<List<SearchTags>> readTags({String id}) async {
  //   try {
  //     _searchTags = await Amplify.DataStore.query(SearchTags.classType);
  //     return _searchTags;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // void readIdeaAndTags() async {
  //   try {
  //     _ideaMemo = await readIdeas();
  //     // _searchTags = await readTags();
  //
  //     print('idea : $_ideaMemo, visible : $_visibleFilter');
  //
  //     _ideaController.add(_ideaMemo);
  //     //_tagsController.add(_searchTags);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  void addIdea({String memo, String tags, String id}) async {
    final ideaObject = IdeaMemo(
      id: id,
      memo: memo,
      tags: tags,
      isVisible: true,
    );

    try {
      await Amplify.DataStore.save(ideaObject);
      // tag.forEach((element) async {
      //   final tagObject = SearchTags(id: element, tag: element);
      //   await Amplify.DataStore.save(tagObject);
      //   _searchTags.add(tagObject);
      // });
      _ideaMemo.add(ideaObject);

      _ideaController.add(_ideaMemo);
    } catch (e) {
      return e;
    }
  }

  //TODO: 탐색기능부터 시작함.
  void readFilteredIdea({String searchTags}) async {
    try {
      final filteredList = await Amplify.DataStore.query(
        IdeaMemo.classType,
        where: IdeaMemo.TAGS.contains(
          searchTags,
        ),
      );
      _ideaController.add(filteredList);
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
    _ideaController.close();
  }
}
