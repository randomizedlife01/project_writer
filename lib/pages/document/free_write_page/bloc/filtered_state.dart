// part of 'filtered_cubit.dart';
//
// enum VisibilityFilter { all, active, completed }
//
// abstract class FilteredIdeasState extends Equatable {
//   const FilteredIdeasState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class FilteredIdeasLoadInProgress extends FilteredIdeasState {}
//
// class FilteredIdeasLoadSuccess extends FilteredIdeasState {
//   final List<IdeaMemo> filteredIdeas;
//   final List<SearchHistory> searchHistory;
//
//   const FilteredIdeasLoadSuccess(
//     this.filteredIdeas,
//     this.searchHistory,
//   );
//
//   @override
//   List<Object> get props => [filteredIdeas, searchHistory];
//
//   @override
//   String toString() {
//     return 'FilteredIdeasLoadSuccess { filteredIdeas: $filteredIdeas, searchHistory: $searchHistory }';
//   }
// }
