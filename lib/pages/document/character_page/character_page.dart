import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';

@immutable
class CharactersPage extends StatelessWidget {
  final characterController = CharactersController.to;
  final ScrollController scrollController = ScrollController();

  Widget nothingInMyLifeStory({BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '아직 캐릭터 카드가 없네요.\n새로운 캐릭터를 만들어 보세요 :)',
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
            onPressed: () => Navigator.of(context).pushNamed('/character_write_page'),
            child: Text('새로운 캐릭터 만들기'),
          ),
        ],
      ),
    );
  }

  List<Card> _buildCharacterList(BuildContext context) {
    return characterController.myCharacters.map((character) {
      return Card(
        color: Color(0xFFF8FEE9),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        character.name,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Color(0xFF3b4445)),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '성별 :' + character.gender,
                          maxLines: 1,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '나이 :' + character.age,
                          maxLines: 1,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '모티브 :\n' + character.motivation,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO: 캐릭터 편집 버튼, 페이지 이동시에 데이터 그대로 갖고 이동하기...
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/character_write_page', arguments: character),
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) {
                        return DeletePopup(
                          id: character.id,
                          delete: () {
                            characterController.deleteMyCharacter(id: character.id);
                            Navigator.pop(context);
                          },
                        );
                      }),
                  icon: Icon(Icons.clear),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget characterCards({BuildContext context}) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.6,
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.vertical,
      controller: scrollController,
      children: _buildCharacterList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    characterController.readMyCharacters();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: '캐릭터 만들기',
        ),
      ),
      body: GetBuilder<CharactersController>(
        builder: (controller) {
          return controller.myCharacters.isNotEmpty ? characterCards(context: context) : nothingInMyLifeStory(context: context);
        },
      ),
      floatingActionButton: BasicFloatingButton(
        icon: Icons.add,
        onPressed: () => Navigator.of(context).pushNamed('/character_write_page'),
      ),
    );
  }
}
