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

  Widget buildFloatingSearchBar(BuildContext context) {
    return FloatingSearchBar(
      hint: 'Search...',
      hintStyle: Theme.of(context).textTheme.bodyText1,
      queryStyle: Theme.of(context).textTheme.bodyText1,
      controller: controller,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      backgroundColor: Color(0xFFebe4db),
      elevation: 0.0,
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      border: BorderSide(),
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
            icon: const Icon(Icons.search),
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
            color: Color(0xFFf2f4f7),
            elevation: 0.0,
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
                          '?????? ??????',
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
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                leading: const Icon(
                                  Icons.search,
                                  color: Color(0xFF111f4d),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Color(0xFF111f4d),
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
    return buildFloatingSearchBar(context);
  }
}

//?????? ?????? ????????? ???
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
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            // ),
            padding: EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: freeController.ideaMemo.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 50.0,
                color: Color(0xFF111f4d),
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
                    caption: '??????',
                    color: Colors.transparent,
                    icon: Icons.archive,
                    onTap: () {},
                  ),
                  IconSlideAction(
                    caption: '??????',
                    color: Color(0xFFe23e57),
                    icon: Icons.delete,
                    onTap: () {
                      freeController.deleteIdea(id: freeController.ideaMemo[toIndex].id);
                    },
                  ),
                ],
                //RxDart ????????? ???????????????
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          freeController.ideaMemo.isNotEmpty ? freeController.ideaMemo[toIndex].memo : '',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w300, fontSize: 18.0),
                        ),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
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
                  //???????????? ????????? ?????? ?????????(??????)
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
                            padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF111f4d)),
                              //color: Color(0xFF111f4d),
                              borderRadius: BorderRadius.all(Radius.circular(13.0)),
                            ),
                            child: Text(
                              '#' + tags[index],
                              style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 13.0),
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
