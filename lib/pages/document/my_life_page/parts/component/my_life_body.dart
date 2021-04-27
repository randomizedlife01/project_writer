import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_writer_v04/models/MyLifeStory.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/component/my_life_create_pop.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';

//TODO: 새 데이터 모델 읽어오기 수정 중....
class MyLifePageBody extends StatelessWidget {
  final _scrollController = ScrollController();
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
    return Obx(() {
      var years = [];
      myLifeController.myLifeStory.forEach((element) {
        if (!years.contains(element.year)) {
          years.add(element.year);
        }
      });
      return ListView.separated(
        separatorBuilder: (context, index) => DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 4.0,
          dashColor: Colors.black,
          dashRadius: 0.0,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
          dashGapRadius: 0.0,
        ),
        shrinkWrap: true,
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: years.length,
        itemBuilder: (context, yearIndex) {
          List<MyLifeStory> yearList = myLifeController.myLifeStory.value
              .where((element) => element.year == myLifeController.myLifeStory.value[yearIndex].year)
              .toList();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
            child: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: yearList.length,
                    itemBuilder: (context, seasonIndex) {
                      List<MyLifeStory> seasonList = yearList.where((element) => element.season == yearList[seasonIndex].season).toList();
                      if (yearList[seasonIndex].season == '1') {
                        seasonToHangul = '봄';
                      } else if (yearList[seasonIndex].season == '2') {
                        seasonToHangul = '여름';
                      } else if (yearList[seasonIndex].season == '3') {
                        seasonToHangul = '가을';
                      } else {
                        seasonToHangul = '겨울';
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              seasonToHangul ?? '',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, fontSize: 24.0),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: seasonList.length,
                                itemBuilder: (context, memoIndex) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              seasonList[memoIndex].lifeMemo ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(fontSize: 20.0, fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: () =>
                                                myLifeController.deleteMyStory(id: myLifeController.myLifeStory[memoIndex].lifeMemo),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                      //return Text(yearList[seasonIndex].season.toString());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(myLifeController.myLifeStory);
    //myLifeController.deleteMyStory(id: 'my_life_4');
    return Container(
      padding: EdgeInsets.all(15.0),
      child: myLifeController.myLifeStory.isEmpty ? nothingInMyLifeStory(context: context) : myLifeStory(context: context),
    );
  }
}
