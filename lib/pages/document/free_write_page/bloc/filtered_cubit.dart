// import 'dart:async';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_writer_v04/models/IdeaMemo.dart';
// import 'package:project_writer_v04/models/SearchHistory.dart';
// import 'package:project_writer_v04/pages/document/free_write_page/bloc/re_free_cubit.dart';
//
// part 'filtered_state.dart';
//
// class FilteredCubit extends Cubit<FilteredIdeasState> {
//   final ReFreeCubit ideaBloc;
//
//   List<SearchHistory> searchHistory;
//
//   FilteredCubit(this.ideaBloc, [this.searchHistory = const []]) : super(FilteredIdeasLoadInProgress());
//
//   Future<void> readIdeaAndTags() async {
//     try {
//       emit(FilteredIdeasLoadInProgress());
//       if (ideaBloc.state is StateOfIdeasLoaded) {
//         ideaBloc.state. = await
//       }
//
//       ideaBloc.state as StateOfIdeasLoaded = await _newCombineRepository.readIdeas();
//       emit(StateOfIdeasLoaded(ideaMemo));
//     } catch (e) {
//       emit(StateOfIdeasNotLoaded());
//     }
//   }
// }
