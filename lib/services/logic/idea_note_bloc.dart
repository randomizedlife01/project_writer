import 'package:equatable/equatable.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';

part 'idea_note_state.dart';
part 'idea_note_event.dart';

//TODO: RxDart로 전부 교체하기
// class IdeaBloc extends Bloc<IdeaEvent, IdeaState> {
//   final IdeaRepository _ideaRepository;
//   StreamSubscription _ideaSubscription;
//
//   IdeaBloc({@required IdeaRepository ideaRepository})
//       : assert(ideaRepository != null),
//         _ideaRepository = ideaRepository,
//         super(IdeaLoadingInProgress());
//
//   @override
//   Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
//     if (event is IdeasLoaded) {
//       yield* _mapLoadIdeasToState();
//     } else if (event is IdeaAdded) {
//       yield* _mapIdeaAddToState(event);
//     } else if (event is IdeaUpdated) {
//       yield* _mapReadIdeasToState(event);
//     } else if (event is IdeaDeleted) {
//       yield* _mapDeleteIdeasToState(event);
//     }
//   }
//
//   Stream<IdeaState> _mapLoadIdeasToState() async* {
//     try {
//       final ideas = this._ideaRepository.ideas();
//       yield IdeasLoadSuccess(await ideas);
//     } catch (_) {
//       yield IdeaError();
//     }
//   }
//
//   //TODO: 이전 아이디를 읽고 그 아이디에 1씩 더하는 걸로 수정하기
//   Stream<IdeaState> _mapIdeaAddToState(IdeaAdded event) async* {
//     if (state is IdeasLoadSuccess) {
//       if ((state as IdeasLoadSuccess).ideaMemo.length > 0) {
//         final lastIndexId = (state as IdeasLoadSuccess).ideaMemo.last.id.substring(7);
//         final data = await this._ideaRepository.createIdea(memo: event.ideaMemo.memo, id: 'idea_Id' + lastIndexId);
//         final List<IdeaMemo> updatedIdea = List.from((state as IdeasLoadSuccess).ideaMemo)..add(data);
//         yield IdeasLoadSuccess(updatedIdea);
//       } else {
//         final data = await this._ideaRepository.createIdea(memo: event.ideaMemo.memo, id: 'idea_Id' + '0');
//         final List<IdeaMemo> updatedIdea = List.from((state as IdeasLoadSuccess).ideaMemo)..add(data);
//         yield IdeasLoadSuccess(updatedIdea);
//       }
//     }
//   }
//
//   Stream<IdeaState> _mapReadIdeasToState(IdeaUpdated event) async* {}
//
//   Stream<IdeaState> _mapDeleteIdeasToState(IdeaDeleted event) async* {
//     if (state is IdeasLoadSuccess) {
//       final data = await this._ideaRepository.delete(id: event.ideaMemo.id);
//       final List<IdeaMemo> updatedIdea = List.from((state as IdeasLoadSuccess).ideaMemo)..remove(data);
//       yield IdeasLoadSuccess(updatedIdea);
//     }
//   }
//
//   @override
//   Future<void> close() {
//     _ideaSubscription?.cancel();
//     return super.close();
//   }
// }
