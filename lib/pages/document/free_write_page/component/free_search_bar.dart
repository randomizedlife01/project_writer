import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:project_writer_v04/services/controller/free_write_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

class SearchBarView extends StatelessWidget {
  final bool isVisible;
  final bool isEnabled;

  final controller = FloatingSearchBarController();
  final freeWriteController = FreeWriteController.to;

  SearchBarView({Key key, this.isVisible, this.isEnabled}) : super(key: key);

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      hint: 'Search...',
      controller: controller,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        freeWriteController.filterSearchTerms(query: query);
      },
      onSubmitted: (query) {
        freeWriteController.createTag(query: query);
        query.isEmpty ? freeWriteController.readIdeaAndTags() : freeWriteController.filteredIdeaAndTags(filter: query);
        controller.close();
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: GetBuilder<FreeWriteController>(
              builder: (writeController) {
                return Builder(
                  builder: (context) {
                    if (writeController.searchHistory.isEmpty && controller.query.isEmpty) {
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
                    } else if (controller.query.isEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: writeController.searchHistory
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
                                    writeController.deleteTag(id: term.id);
                                  },
                                ),
                                onTap: () {
                                  print('called');
                                },
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: writeController.filteredSearchHistory
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
                                    freeWriteController.deleteTag(id: term.id);
                                  },
                                ),
                                onTap: () {},
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
      body: SearchResultsListView(isVisible: isVisible, isEnabled: isEnabled),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildFloatingSearchBar();
  }
}

//검색 결과 리스트 뷰
class SearchResultsListView extends StatelessWidget {
  final bool isVisible;
  final bool isEnabled;

  SearchResultsListView({Key key, this.isVisible, this.isEnabled}) : super(key: key);

  final freeController = FreeWriteController.to;
  final storyController = StorySummaryController.to;

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: GetBuilder<FreeWriteController>(
        builder: (freeController) {
          return ListView.separated(
            padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: freeController.ideaMemo.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 50.0,
                color: Colors.white,
                indent: 150.0,
                endIndent: 150.0,
              );
            },
            itemBuilder: (context, toIndex) {
              final tags = freeController.ideaMemo[toIndex].tags.split(" ");
              return Slidable(
                actionPane: SlidableStrechActionPane(),
                enabled: isEnabled,
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
                      freeController.deleteIdea(id: freeController.ideaMemo[toIndex].id);
                    },
                  ),
                ],
                //RxDart 데이터 리스트타일
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          freeController.ideaMemo.isNotEmpty ? freeController.ideaMemo[toIndex].memo : '',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            //TODO: 문장 가져오기 기능..
                            int _lastIdeaIdNum = 0;

                            if (storyController.summaries.isNotEmpty) {
                              final lastId = storyController.summaries.last.id;
                              final number = lastId.split("_").last;
                              _lastIdeaIdNum = int.parse(number);
                            }

                            storyController.createSummary(
                              storySummary: freeController.ideaMemo[toIndex].memo ?? '',
                              id: 'my_summary_' + (_lastIdeaIdNum + 1).toString(),
                              documentId: storyController.setDocumentId.value,
                            );

                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
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
        },
      ),
    );
  }
}
