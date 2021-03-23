import 'dart:async';

import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:rxdart/rxdart.dart';

class MovieUserFavourite {
  final IdeaMemo idea;
  final SearchTags tags;

  MovieUserFavourite(this.idea, this.tags);
}

class FreeWriteBloc {
  final _ideasSubject = BehaviorSubject<List<IdeaMemo>>.seeded([]);
  final _tagsSubject = BehaviorSubject<List<SearchTags>>.seeded([]);

  Stream<List<MovieUserFavourite>> moviesUserFavouritesStream() {
    return Rx.combineLatest2(ideasStream(), tagsStream(), (List<IdeaMemo> movies, List<SearchTags> userFavourites) {
      if (movies.isNotEmpty && userFavourites.isNotEmpty) {
        return movies.map((movie) {
          final userFavourite = userFavourites?.firstWhere((userFavourite) => userFavourite.tag.contains(movie.tags), orElse: () => null);
          return MovieUserFavourite(
            movie,
            userFavourite?.tag ?? false,
          );
        }).toList();
      } else {
        return null;
      }
    });
  }

  Stream<List<IdeaMemo>> ideasStream() {
    try {
      return Amplify.DataStore.query(IdeaMemo.classType).asStream();
    } catch (e) {
      return e;
    }
  }

  Stream<List<SearchTags>> tagsStream() {
    try {
      return Amplify.DataStore.query(SearchTags.classType).asStream();
    } catch (e) {
      return e;
    }
  }

  // void createIdea({String memo, String tags, String id}) async {
  //   final newIdea = await ideaRepository.createIdea(memo: memo, tags: tags, id: id);
  //   _ss.map((e) => e.)
  //   initialIdeas.add(newIdea);
  //   _subjectIdeaNote.sink.add(initialIdeas);
  // }
  //
  // void readIdeas() async {
  //   initialIdeas = await ideaRepository.ideas();
  //   _subjectIdeaNote.sink.add(initialIdeas);
  // }
  //
  // void updateIdea() {}
  //
  // void deleteIdea() {}
  //

  void dispose() {
    _ideasSubject.close();
    _tagsSubject.close();
  }
}
