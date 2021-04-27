import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBarView<T> extends StatefulWidget {
  final String searchTerm;
  final int itemCount;
  final String tagList;
  final List<T> title;
  final VoidCallback onTap;

  const SearchBarView({
    Key key,
    @required this.searchTerm,
    @required this.itemCount,
    @required this.tagList,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  _SearchBarViewState createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  static const historyLength = 5;

  List<String> _searchHistory = [];

  List<String> filteredSearchHistory;

  String selectedTerm;

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filteredSearchTerm(filter: null);
  }

  List<String> filteredSearchTerm({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm({String term}) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filteredSearchTerm(filter: null);
  }

  void deleteSearchTerm({String term}) {
    _searchHistory.removeWhere((element) => element == term);
    filteredSearchHistory = filteredSearchTerm(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term: term);
    addSearchTerm(term: term);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            tagList: widget.tagList,
            title: widget.title,
            itemCount: widget.itemCount,
            onTap: widget.onTap,
            searchTerm: widget.searchTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(selectedTerm ?? 'Search...'),
        hint: '태그 검색',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filteredSearchTerm(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(term: query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        '검색어를 입력해주세요',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12.0),
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(term: controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term: term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
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
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;
  final int itemCount;
  final String tagList;
  final List<String> title;
  final VoidCallback onTap;

  const SearchResultsListView({
    Key key,
    @required this.searchTerm,
    @required this.itemCount,
    @required this.tagList,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context);
    return ListView.separated(
      padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) {
        return Divider(
          height: 50.0,
          color: Colors.white,
          indent: 150.0,
          endIndent: 150.0,
        );
      },
      itemBuilder: (context, toIndex) {
        final tags = tagList.split(" ");
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
              onTap: onTap,
            ),
          ],
          //RxDart 데이터 리스트타일
          child: ListTile(
            title: Text(
              title.isNotEmpty ? title[toIndex] : '',
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
    );
  }
}
