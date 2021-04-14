import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/parts/my_life_create_pop.dart';

class MyLifePage extends StatefulWidget {
  @override
  _MyLifePageState createState() => _MyLifePageState();
}

class _MyLifePageState extends State<MyLifePage> {
  final _scrollController = ScrollController();

  String seasonToHangul = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyLifeStoryCubit>(context).readMyStory();
  }

  Widget nothingInMyLifeStory() {
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
                  backgroundColor: MaterialStateProperty.all(Color(0xFF3b4445)),
                ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<MyLifeStoryCubit>(context),
                      child: MyLifeCreatePop(
                        nameLabelText: '태그 입력',
                        nameHintText: '#제외, 띄어쓰기로 구분합니다.',
                      ),
                    );
                  });
            },
            child: Text('나의 연표 만들기'),
          ),
        ],
      ),
    );
  }

  Widget myLifeStory() {
    //BlocProvider.of<MyLifeStoryCubit>(context)..deleteMyStory(id: 'my_life_1');
    return BlocBuilder<MyLifeStoryCubit, MyLifeStoryState>(
      builder: (context, state) {
        if (state is MyLifeStoryLoaded) {
          //state.myLifeStory.isNotEmpty ? _isVisible = true : _isVisible = false;
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: state.years.length,
              itemBuilder: (context, toIndex) {
                var subList = state.myLifeStory.where((element) => element.year == state.years[toIndex]).toList();
                print(subList);
                return ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            state.myLifeStory.isNotEmpty ? state.years[toIndex] : '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Color(0xFFF8FEE9), fontSize: 40.0, fontWeight: FontWeight.w700),
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
                        itemCount: subList.length,
                        itemBuilder: (context, seasonIndex) {
                          var seasonList = subList.where((element) => element.season == subList[seasonIndex].season).toList();
                          if (subList[seasonIndex].season == '1') {
                            seasonToHangul = '봄';
                          } else if (subList[seasonIndex].season == '2') {
                            seasonToHangul = '여름';
                          } else if (subList[seasonIndex].season == '3') {
                            seasonToHangul = '가을';
                          } else {
                            seasonToHangul = '겨울';
                          }
                          return ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(seasonToHangul),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: seasonList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //날짜와 시간 분리되는 곳
                                        Container(
                                          child: Text(
                                            seasonList[index].month.isNotEmpty && seasonList[index].date.isNotEmpty
                                                ? (seasonList[index].month + '.' + seasonList[index].date)
                                                : '어느 날',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(color: Color(0xFFF8FEE9), fontSize: 16.0, fontWeight: FontWeight.w200),
                                          ),
                                        ),
                                        Text(
                                          seasonList.isNotEmpty ? seasonList[index].lifeMemo : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xFFF8FEE9)),
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
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is MyLifeStoryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('ERROR!'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLifeStoryCubit, MyLifeStoryState>(
        builder: (context, state) {
          if (state is MyLifeStoryLoaded) {
            return Container(
              padding: EdgeInsets.all(15.0),
              child: state.myLifeStory.isEmpty ? nothingInMyLifeStory() : myLifeStory(),
            );
          } else if (state is MyLifeStoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('ERROR!'),
            );
          }
        },
      ),
      floatingActionButton: Visibility(
        //visible: _isVisible,
        child: BasicFloatingButton(
          icon: Icons.add,
          onPressed: () => showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<MyLifeStoryCubit>(context),
                child: MyLifeCreatePop(
                  nameLabelText: '태그 입력',
                  nameHintText: '#제외, 띄어쓰기로 구분합니다.',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
