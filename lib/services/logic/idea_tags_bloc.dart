import 'package:equatable/equatable.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/SearchTags.dart';

part 'idea_tags_state.dart';
part 'idea_tags_event.dart';

//TODO: RxDart로 전부 교체하기.
// class TagsBloc extends Bloc<TagsEvent, TagsCustomState> {
//   final IdeaBloc _ideasBloc;
//   StreamSubscription _ideaSubscription;
//
//   TagsBloc({@required IdeaBloc ideaBloc})
//       : assert(ideaBloc != null),
//         _ideasBloc = ideaBloc,
//         super(ideaBloc.state is IdeasLoadSuccess
//             ? TagsLoadSuccess(
//                 (ideaBloc.state as IdeasLoadSuccess).ideaMemo,
//               )
//             : TagsLoadingInProgress()) {
//     print('aaa : ${ideaBloc.state}');
//     _ideaSubscription = ideaBloc.listen((state) {
//       if (state is IdeasLoadSuccess) {
//         add(UpdateIdeaInTagsModel((ideaBloc.state as IdeasLoadSuccess).ideaMemo));
//       }
//     });
//   }
//
//   @override
//   Stream<TagsCustomState> mapEventToState(TagsEvent event) async* {
//     if (event is TagsLoaded) {
//       yield* _mapUpdateTagsToState(event);
//     } else if (event is UpdateIdeaInTagsModel) {
//       yield* _mapUpdateIdeasToState(event);
//     }
//   }
//
//   Stream<TagsCustomState> _mapUpdateTagsToState(TagsLoaded event) async* {
//     final currentState = _ideasBloc.state;
//     if (currentState is IdeasLoadSuccess) {
//       yield TagsLoadSuccess(
//         _mapIdeasToIdeasInTags(ideas: currentState.ideaMemo, tags: event.tags),
//       );
//     }
//   }
//
//   Stream<TagsCustomState> _mapUpdateIdeasToState(UpdateIdeaInTagsModel event) async* {}
//
//   List<IdeaMemo> _mapIdeasToIdeasInTags({List<IdeaMemo> ideas, List<SearchTags> tags}) {
//     return ideas.where((idea) {
//       if (idea.tags.contains(tags.join())) {
//         return true;
//       } else {
//         return false;
//       }
//     }).toList();
//   }
//
//   @override
//   Future<void> close() {
//     _ideaSubscription?.cancel();
//     return super.close();
//   }
// }
