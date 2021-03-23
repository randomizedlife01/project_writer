import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:project_writer_v04/services/logic/free_write_bloc.dart';

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
  static const historyLength = 5;

  List<String> _searchHistory = [
    'a',
    'b',
    'c',
    'd',
    'e',
  ];

  List<String> filteredSearchHistory;

  String selectTerm;

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  List<String> filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerms(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTerms(term);
      return;
    }
    _searchHistory.add(term);

    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void deleteSearchTerms(String term) {
    _searchHistory.removeWhere((element) => element == term);
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void putSearchTerms(String term) {
    deleteSearchTerms(term);
    addSearchTerms(term);
  }

  @override
  Widget build(BuildContext context) {
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
        selectTerm ?? '태그 검색',
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
        setState(() {
          filteredSearchHistory = filteredSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchTerms(query);
          selectTerm = query;
          controller.close();
        });
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Color(0xFFe4f9f5),
            elevation: 0.0,
            child: Builder(
              builder: (context) {
                if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
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
                } else if (filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(
                      controller.query,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTerms(controller.query);
                        selectTerm = controller.query;
                      });
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
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
                                setState(() {
                                  deleteSearchTerms(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTerms(term);
                                selectTerm = term;
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
  final dataBloc = FreeWriteBloc();

  SearchResultsListView({Key key, this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (BlocProvider.of<IdeaBloc>(context).state.props == null) {
    //   return Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Icon(
    //           Icons.search,
    //           size: 64,
    //         ),
    //         Text(
    //           'Start Searching',
    //           style: Theme.of(context).textTheme.bodyText1,
    //         ),
    //       ],
    //     ),
    //   );
    // }

    final fsb = FloatingSearchBar.of(context);

    //TODO: RxDart로 리스트 데이터 받아오는 부분
    return StreamBuilder<List<MovieUserFavourite>>(
        stream: dataBloc.moviesUserFavouritesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.separated(
              padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              //TODO: 아이템 카운트
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
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
                        //BlocProvider.of<IdeaBloc>(context)..add(IdeaDeleted(IdeaMemo(id: state.ideaMemo[index].id)));
                      },
                    ),
                  ],
                  //TODO: RxDart 데이터 리스트타일
                  child: ListTile(
                    title: Text(snapshot.hasData ? snapshot.data[index].idea.memo : ''),
                    subtitle: Text(snapshot.hasData ? snapshot.data[index].tags.tag : ''),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('ERROR!'),
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

class BasicTag extends StatefulWidget {
  @override
  _BasicTagState createState() => _BasicTagState();
}

class _BasicTagState extends State<BasicTag> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
