import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/models/SearchHistory.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/idea_bloc.dart';
import 'package:project_writer_v04/services/logic/search_history_bloc.dart';

//기본 메뉴 버튼
class BasicMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String buttonText;

  const BasicMenuButton({Key key, this.onPressed, this.icon, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0.0),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(12.0, 12.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 18.0,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

//기본 앱 바
class BasicAppBar extends StatelessWidget {
  final String appBarTitle;

  const BasicAppBar({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w200, fontSize: 20.0),
      ),
    );
  }
}

//기본 우하단 플로팅 버튼
class BasicFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BasicFloatingButton({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Center(
          child: Container(
            width: 45,
            height: 45,
            child: Icon(
              icon,
              size: 25.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF3b4445),
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF181c1c),
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Color(0xFF596769),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}

//버튼 가로 리스트 나눌 때 선
class BasicVerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      indent: 40.0,
      endIndent: 40.0,
      color: Color(0xFFc4d6cb),
      width: 8.0,
    );
  }
}

//기본 서치 바
class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String selectTerm;
  int lastIdIndex;
  int firstIdIndex;

  FloatingSearchBarController controller;
  SearchHistoryBloc _searchHistoryListBloc;
  IdeasBloc _ideasBloc;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    _searchHistoryListBloc = BlocProvider.of<SearchHistoryBloc>(context);
    _ideasBloc = BlocProvider.of<IdeasBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: setState 부분 전부 stream으로 변경!
    return StreamBuilder<SearchModel>(
        stream: _searchHistoryListBloc.searchCombineStream(),
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
              ),
              transition: SlideFadeFloatingSearchBarTransition(),
              physics: BouncingScrollPhysics(),
              title: Text(
                selectTerm == null ? '태그 검색' : selectTerm,
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
                print('called');
                snapshot.data.filteredSearchHistoryList = _searchHistoryListBloc.filteredSearchTerms(filter: query);
              },
              onSubmitted: (query) {
                //검색창 엔터 펑션
                if (snapshot.data.searchHistoryList.isNotEmpty) {
                  final lastIndexString = snapshot.data.searchHistoryList.last.id.split("_").last;
                  lastIdIndex = int.parse(lastIndexString);
                  final firstIndexString = snapshot.data.searchHistoryList.last.id.split("_").first;
                  firstIdIndex = int.parse(firstIndexString);
                }
                _searchHistoryListBloc.addSearchTerms(
                    term: query,
                    firstId: 'history_' + (firstIdIndex).toString() ?? 'history_0',
                    lastId: 'history_' + (lastIdIndex + 1).toString());
                selectTerm = query;
                _ideasBloc.readFilteredIdea(searchTags: query);
                if (query.isEmpty) {
                  _ideasBloc.readIdeas();
                }
                selectTerm = null;
                print(selectTerm);
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
                        print(snapshot.connectionState);
                        if (snapshot.data.filteredSearchHistoryList.isEmpty && controller.query.isEmpty) {
                          return Container(
                            height: 56.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'start searching',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          );
                        } else if (snapshot.data.filteredSearchHistoryList.isEmpty) {
                          return ListTile(
                            title: Text(
                              controller.query,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            leading: const Icon(Icons.search),
                            onTap: () {
                              final lastIndexString = snapshot.data.searchHistoryList.last.id.split("_").last;
                              final lastIdIndex = int.parse(lastIndexString);
                              final firstIndexString = snapshot.data.searchHistoryList.last.id.split("_").first;
                              final firstIdIndex = int.parse(firstIndexString);
                              _searchHistoryListBloc.addSearchTerms(
                                  term: controller.query,
                                  firstId: 'history_' + (firstIdIndex).toString(),
                                  lastId: 'history_' + (lastIdIndex + 1).toString());
                              selectTerm = controller.query;
                            },
                          );
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: snapshot.data.filteredSearchHistoryList
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
                                        _searchHistoryListBloc.deleteSearchTerms(term.searchHistory);
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _searchHistoryListBloc.putSearchTerms(term.searchHistory);
                                        selectTerm = term.searchHistory;
                                      });
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

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

//검색 결과 리스트 뷰
class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  SearchResultsListView({Key key, this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _countBloc = BlocProvider.of<IdeasBloc>(context);
    final fsb = FloatingSearchBar.of(context);
    //RxDart로 리스트 데이터 받아오는 부분. 검색시 리스트뷰 빌드 다시 하기.
    return StreamBuilder<List<IdeaMemo>>(
        stream: _countBloc.ideaStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.separated(
                padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 50.0,
                    color: Colors.white,
                    indent: 150.0,
                    endIndent: 150.0,
                  );
                },
                itemBuilder: (context, toIndex) {
                  final tags = snapshot.data[toIndex].tags.split(" ");
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
                          BlocProvider.of<IdeasBloc>(context)..deleteIdeaAndTags(id: snapshot.data[toIndex].id);
                        },
                      ),
                    ],
                    //RxDart 데이터 리스트타일
                    child: ListTile(
                      title: Text(
                        snapshot.hasData ? snapshot.data[toIndex].memo : '',
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('No Data!'),
            );
          }
        });
  }
}

class DocInputForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool autoFocus;
  final VoidCallback onTap;

  const DocInputForm({
    Key key,
    this.hintText,
    this.labelText,
    this.controller,
    this.autoFocus = true,
    this.onTap,
  }) : super(key: key);

  Widget inputForm({String hintText, String labelText, TextEditingController controller}) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF252a34),
        fontWeight: FontWeight.w600,
      ),
      onTap: onTap,
      autofocus: autoFocus,
      autocorrect: false,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF252a34),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFe23e57),
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.0,
          fontFamily: 'GothicA1',
          color: Color(0xFF8785a2),
          fontWeight: FontWeight.w600,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 12.0,
          fontFamily: 'GothicA1',
          color: Color(0xFF252a34),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return inputForm(hintText: hintText, labelText: labelText, controller: controller);
  }
}
