import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/component/my_life_create_pop.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';

class MyLifePageBody extends StatelessWidget {
  final _scrollController = PageController(viewportFraction: 0.8);
  final myLifeController = MyLifeStoryController.to;

  Widget nothingInMyLifeStory({BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '아직 연표가 없네요.\n내 이야기로 연표를 만들어보세요 :)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style.copyWith(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFebe4db)),
                ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return MyLifeCreatePop(
                      nameLabelText: '태그 입력',
                      nameHintText: '#제외, 띄어쓰기로 구분합니다.',
                    );
                  });
            },
            child: Text('나의 연표 만들기'),
          ),
        ],
      ),
    );
  }

  Widget myLifeStory({BuildContext context}) {
    String seasonToHangul = '';
    var years = [];
    myLifeController.myLifeStory.value.forEach((element) {
      if (!years.contains(element.year)) {
        years.add(element.year);
      }
    });
    var yearData = [];
    return PageView.builder(
      // separatorBuilder: (context, index) => DottedLine(
      //   direction: Axis.horizontal,
      //   lineLength: double.infinity,
      //   lineThickness: 1.0,
      //   dashLength: 4.0,
      //   dashColor: Colors.black,
      //   dashRadius: 0.0,
      //   dashGapLength: 4.0,
      //   dashGapColor: Colors.transparent,
      //   dashGapRadius: 0.0,
      // ),
      // shrinkWrap: true,
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: years.length,
      itemBuilder: (context, yearIndex) {
        yearData = myLifeController.myLifeStory.value.where((element) => element.year == years[yearIndex]).toList();
        var seasons = [];
        yearData.forEach((element) {
          if (!seasons.contains(element.season)) {
            seasons.add(element.season);
          }
        });
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      years.isNotEmpty ? years[yearIndex] : '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Color(0xFF020205), fontSize: 40.0, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                //TODO: 연표 레이아웃 및 디자인 수정하기....
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: seasons.length,
                    itemBuilder: (context, seasonIndex) {
                      if (seasons[seasonIndex] == '1') {
                        seasonToHangul = '봄';
                      } else if (seasons[seasonIndex] == '2') {
                        seasonToHangul = '여름';
                      } else if (seasons[seasonIndex] == '3') {
                        seasonToHangul = '가을';
                      } else {
                        seasonToHangul = '겨울';
                      }
                      final seasonData = yearData.where((element) => element.season == seasons[seasonIndex]).toList();
                      var lifeMemo = [];
                      seasonData.forEach((element) {
                        if (!lifeMemo.contains(element.lifeMemo)) {
                          lifeMemo.add(element.lifeMemo);
                        }
                      });
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seasonToHangul ?? '',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, fontSize: 24.0),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: lifeMemo.length,
                              itemBuilder: (context, memoIndex) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        lifeMemo[memoIndex] ?? '',
                                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        final data = myLifeController.myLifeStory.value
                                            .where((element) => element.lifeMemo == lifeMemo[memoIndex])
                                            .toList();

                                        myLifeController.deleteMyStory(id: data.first.id);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //myLifeController.deleteMyStory(id: 'my_life_6');
    return Container(
      padding: EdgeInsets.all(15.0),
      child: myLifeController.myLifeStory.isEmpty
          ? Obx(() => nothingInMyLifeStory(context: context))
          : Obx(() => myLifeStory(context: context)),
    );
  }
}
