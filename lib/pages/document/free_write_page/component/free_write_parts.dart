// //기본 서치 바
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';
// import 'package:project_writer_v04/services/controller/free_write_controller.dart';
//
// class SearchBar extends StatelessWidget {
//   String selectTerm = '';
//   int lastIdIndex = 0;
//   int firstIdIndex = 0;
//
//   FloatingSearchBarController controller = FloatingSearchBarController();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FreeWriteController>(
//       builder: (freeController) {
//         return FloatingSearchBar(
//           autocorrect: false,
//           shadowColor: Colors.transparent,
//           border: BorderSide(
//             color: Color(0xFFBF6C84),
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//           automaticallyImplyBackButton: false,
//           iconColor: Color(0xFFBF6C84),
//           controller: controller,
//           backgroundColor: Color(0xFF3b4445),
//           body: SearchResultsListView(
//             searchTerm: selectTerm,
//           ),
//           transition: SlideFadeFloatingSearchBarTransition(),
//           physics: BouncingScrollPhysics(),
//           title: Text(
//             selectTerm == null || selectTerm == '' ? '태그 검색' : selectTerm,
//             style: TextStyle(color: Color(0xFFBF6C84)),
//           ),
//           backdropColor: Colors.transparent,
//           queryStyle: TextStyle(color: Color(0xFFBF6C84), fontSize: 15.0, fontWeight: FontWeight.w400),
//           hint: '검색하실 태그를 입력해주세요',
//           hintStyle: TextStyle(color: Color(0xFFBF6C84), fontSize: 12.0),
//           actions: [
//             FloatingSearchBarAction.searchToClear(),
//           ],
//           onQueryChanged: (query) {
//             freeController.filteredSearchTerms(filter: query);
//           },
//           onSubmitted: (query) {
//             freeController.createTag(tag: query);
//             selectTerm = query;
//             query.isEmpty ? freeController.readIdeaAndTags() : freeController.filteredIdeaAndTags(filter: query);
//             controller.close();
//           },
//           builder: (context, transition) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Material(
//                 color: Color(0xFFe4f9f5),
//                 elevation: 0.0,
//                 child: Builder(
//                   builder: (context) {
//                     if (freeController.searchHistory.isEmpty && controller.query.isEmpty) {
//                       return Container(
//                         height: 56.0,
//                         width: double.infinity,
//                         alignment: Alignment.center,
//                         child: Text(
//                           '태그 검색',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyText2,
//                         ),
//                       );
//                     } else if (freeController.searchHistory.isEmpty) {
//                       return ListTile(
//                         title: Text(
//                           controller.query,
//                           style: Theme.of(context).textTheme.bodyText2,
//                         ),
//                         leading: const Icon(Icons.search),
//                         onTap: () {
//                           //BlocProvider.of<ReFreeCubit>(context).createTag(tag: controller.query);
//                           selectTerm = controller.query;
//                         },
//                       );
//                     } else {
//                       print(freeController.searchHistory.value);
//                       return Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: freeController.searchHistory
//                             .map(
//                               (term) => ListTile(
//                                 title: Text(
//                                   term.searchHistory,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: Theme.of(context).textTheme.bodyText2.copyWith(color: Color(0xFF3b4445)),
//                                 ),
//                                 leading: const Icon(
//                                   Icons.search,
//                                   color: Color(0xFF3b4445),
//                                 ),
//                                 trailing: IconButton(
//                                   icon: Icon(
//                                     Icons.clear,
//                                     color: Color(0xFF3b4445),
//                                   ),
//                                   onPressed: () {
//                                     freeController.deleteSearchTerms(term: term.searchHistory);
//                                   },
//                                 ),
//                                 onTap: () {
//                                   freeController.putSearchTerms(term: term.searchHistory);
//                                   selectTerm = term.searchHistory;
//                                   controller.close();
//                                 },
//                               ),
//                             )
//                             .toList(),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// //검색 결과 리스트 뷰
// class SearchResultsListView extends StatelessWidget {
//   final String searchTerm;
//
//   SearchResultsListView({Key key, this.searchTerm}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final fsb = FloatingSearchBar.of(context);
//     return Padding(
//       padding: const EdgeInsets.only(top: 15.0),
//       child: GetBuilder<FreeWriteController>(
//         builder: (freeController) {
//           return ListView.separated(
//             padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemCount: freeController.ideaMemo.length,
//             separatorBuilder: (context, index) {
//               return Divider(
//                 height: 50.0,
//                 color: Colors.white,
//                 indent: 150.0,
//                 endIndent: 150.0,
//               );
//             },
//             itemBuilder: (context, toIndex) {
//               final tags = freeController.ideaMemo[toIndex].tags.split(" ");
//               return Slidable(
//                 actionPane: SlidableStrechActionPane(),
//                 enabled: true,
//                 secondaryActions: [
//                   IconSlideAction(
//                     caption: '미정',
//                     color: Colors.transparent,
//                     icon: Icons.archive,
//                     onTap: () {},
//                   ),
//                   IconSlideAction(
//                     caption: '삭제',
//                     color: Color(0xFFe23e57),
//                     icon: Icons.delete,
//                     onTap: () {
//                       freeController.deleteIdea(id: freeController.ideaMemo[toIndex].id);
//                     },
//                   ),
//                 ],
//                 //RxDart 데이터 리스트타일
//                 child: ListTile(
//                   title: Text(
//                     freeController.ideaMemo.isNotEmpty ? freeController.ideaMemo[toIndex].memo : '',
//                     style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
//                   ),
//                   //아이디어 메모당 태그 리스트(가로)
//                   subtitle: Container(
//                     height: 38.0,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: tags.length,
//                       itemBuilder: (_, index) {
//                         if (tags.isNotEmpty) {
//                           return Container(
//                             margin: const EdgeInsets.only(top: 15.0, right: 10.0),
//                             padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Color(0xFF6c5c7a)),
//                               color: Color(0xFF6c5c7a),
//                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             ),
//                             child: Text(
//                               '#' + tags[index],
//                               style: Theme.of(context).textTheme.bodyText2.copyWith(color: Color(0xFFfae3da), fontSize: 14.0),
//                             ),
//                           );
//                         } else {
//                           return Text('No Tags Data!!');
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
