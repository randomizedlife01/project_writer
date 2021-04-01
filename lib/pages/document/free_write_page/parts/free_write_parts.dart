//기본 서치 바
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_bloc.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';

class SearchBar extends StatelessWidget {
  String selectTerm = '';
  int lastIdIndex = 0;
  int firstIdIndex = 0;

  FloatingSearchBarController controller = FloatingSearchBarController();
  FreeWriteBloc _searchHistoryListBloc;
  //IdeasBloc _ideasBloc;

  //TODO: Bloc 작성은 끝났음. 태그 검색창 및 태그 리스트 진행.
  @override
  Widget build(BuildContext context) {
    _searchHistoryListBloc = BlocProvider.of<FreeWriteBloc>(context);
    //_ideasBloc = BlocProvider.of<IdeasBloc>(context);
    return StreamBuilder<FreeWriteModel>(
        stream: _searchHistoryListBloc.combineStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return FloatingSearchBar(
              shadowColor: Colors.transparent,
              border: BorderSide(
                color: Color(0xFFBF6C84),
              ),
              borderRadius: BorderRadius.circular(10.0),
              automaticallyImplyBackButton: false,
              iconColor: Color(0xFFBF6C84),
              controller: controller,
              backgroundColor: Color(0xFF3b4445),
              body: SearchResultsListView(
                searchTerm: selectTerm,
                snapshot: snapshot,
              ),
              transition: SlideFadeFloatingSearchBarTransition(),
              physics: BouncingScrollPhysics(),
              title: Text(
                selectTerm == null || selectTerm == '' ? '태그 검색' : selectTerm,
                style: TextStyle(color: Color(0xFFBF6C84)),
              ),
              backdropColor: Colors.transparent,
              queryStyle: TextStyle(color: Color(0xFFBF6C84), fontSize: 15.0, fontWeight: FontWeight.w400),
              hint: '검색하실 태그를 입력해주세요',
              hintStyle: TextStyle(color: Color(0xFFBF6C84), fontSize: 12.0),
              actions: [
                FloatingSearchBarAction.searchToClear(),
              ],
              onQueryChanged: (query) {
                _searchHistoryListBloc.filteredSearchTerms(filter: query);
              },
              onSubmitted: (query) {
                _searchHistoryListBloc.createTag(tag: query);
                selectTerm = query;
                query.isEmpty ? _searchHistoryListBloc.readIdeaAndTags() : _searchHistoryListBloc.filteredIdeaAndTags(filter: query);
                controller.close();
              },
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Material(
                    color: Color(0xFFe4f9f5),
                    elevation: 0.0,
                    child: Builder(
                      builder: (context) {
                        if (snapshot.data.searchHistory.isEmpty && controller.query.isEmpty) {
                          return Container(
                            height: 56.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              '태그 검색',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          );
                        } else if (snapshot.data.searchHistory.isEmpty) {
                          return ListTile(
                            title: Text(
                              controller.query,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            leading: const Icon(Icons.search),
                            onTap: () {
                              _searchHistoryListBloc.createTag(tag: controller.query);
                              selectTerm = controller.query;
                            },
                          );
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: snapshot.data.searchHistory
                                .map(
                                  (term) => ListTile(
                                    title: Text(
                                      term.searchHistory,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Color(0xFF3b4445)),
                                    ),
                                    leading: const Icon(
                                      Icons.search,
                                      color: Color(0xFF3b4445),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Color(0xFF3b4445),
                                      ),
                                      onPressed: () {
                                        _searchHistoryListBloc.deleteSearchTerms(term: term.searchHistory);
                                      },
                                    ),
                                    onTap: () {
                                      _searchHistoryListBloc.putSearchTerms(term: term.searchHistory);
                                      selectTerm = term.searchHistory;
                                      controller.close();
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Center(child: Text('데이터 로드 중\n오류가 발생하였습니다.'));
          }
        });
  }
}

//검색 결과 리스트 뷰
class SearchResultsListView extends StatelessWidget {
  final String searchTerm;
  final AsyncSnapshot snapshot;

  SearchResultsListView({Key key, this.searchTerm, this.snapshot}) : super(key: key);

  //TODO: Bloc 작성은 끝났음. 여기는 리스트 불러오고 필터 적용하는 곳.
  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context);
    //RxDart로 리스트 데이터 받아오는 부분. 검색시 리스트뷰 빌드 다시 하기.
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.separated(
        padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: snapshot.data.ideaMemo.length,
        separatorBuilder: (context, index) {
          return Divider(
            height: 50.0,
            color: Colors.white,
            indent: 150.0,
            endIndent: 150.0,
          );
        },
        itemBuilder: (context, toIndex) {
          final tags = snapshot.data.ideaMemo[toIndex].tags.split(" ");
          return Slidable(
            actionPane: SlidableStrechActionPane(),
            enabled: true,
            secondaryActions: [
              IconSlideAction(
                caption: '미정',
                color: Colors.transparent,
                icon: Icons.archive,
                onTap: () {},
              ),
              IconSlideAction(
                caption: '삭제',
                color: Color(0xFFe23e57),
                icon: Icons.delete,
                onTap: () {
                  BlocProvider.of<FreeWriteBloc>(context)..deleteIdea(id: snapshot.data.ideaMemo[toIndex].id);
                },
              ),
            ],
            //RxDart 데이터 리스트타일
            child: ListTile(
              title: Text(
                snapshot.hasData ? snapshot.data.ideaMemo[toIndex].memo : '',
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
              ),
              //아이디어 메모당 태그 리스트(가로)
              subtitle: Container(
                height: 38.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (_, index) {
                    if (tags.isNotEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(top: 15.0, right: 10.0),
                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF6c5c7a)),
                          color: Color(0xFF6c5c7a),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Text(
                          '#' + tags[index],
                          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Color(0xFFfae3da), fontSize: 14.0),
                        ),
                      );
                    } else {
                      return Text('No Tags Data!!');
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
