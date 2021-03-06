import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/models/CharacterData.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';

class CharacterWritePage extends StatefulWidget {
  final CharacterData characterData;

  const CharacterWritePage({Key key, this.characterData}) : super(key: key);

  @override
  _CharacterWritePageState createState() => _CharacterWritePageState();
}

class _CharacterWritePageState extends State<CharacterWritePage> {
  final _characterKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _motiveController = TextEditingController();
  final _descController = TextEditingController();

  final scrollController = ScrollController();

  String genderValue = '여성';

  int _lastMyCharacterIdNum = 0;
  int ageValue = 20;
  double tendencyValue = 50;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.characterData.name ?? '';
    _ageController.text = widget.characterData.age ?? '';
    _motiveController.text = widget.characterData.motivation ?? '';
    _descController.text = widget.characterData.description ?? '';
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown.shade800,
            child: Text('AH'),
          ),
        ],
      ),
    );
  }

  Widget nameBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imageProfile(),
        SizedBox(
          height: 30.0,
        ),
        DocInputForm(hintText: '홍길동', labelText: '이름', controller: _nameController),
      ],
    );
  }

  Widget genderAndAge() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF020205),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: genderValue,
                style: Theme.of(context).textTheme.bodyText2,
                onChanged: (String newValue) {
                  setState(() {
                    genderValue = newValue;
                  });
                },
                items: <String>['남성', '여성', '기타'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: DocInputForm(hintText: '20', labelText: '나이', controller: _ageController),
        ),
      ],
    );
  }

  Widget motivationForm() {
    return DocInputForm(hintText: '가족,친구,그 밖의 누군가', labelText: '모티브가 된 인물', controller: _motiveController);
  }

  Widget descriptionForm() {
    return Container(
      height: 100.0,
      child: DocInputForm(hintText: '그(그녀)는 좋은 사람이었다.', labelText: '인물 묘사', controller: _descController),
    );
  }

  Widget tendencySlider() {
    return Column(
      children: [
        Text('성향', style: Theme.of(context).textTheme.headline4),
        Row(
          children: [
            Text('선', style: Theme.of(context).textTheme.headline4),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Slider(
                value: tendencyValue,
                activeColor: Color(0xFF020205),
                inactiveColor: Color(0xFF2B2B57),
                min: 0,
                max: 100,
                onChanged: (newValue) {
                  setState(() {
                    tendencyValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text('악', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Form(
              key: _characterKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      nameBar(),
                      SizedBox(
                        height: 10,
                      ),
                      genderAndAge(),
                      SizedBox(
                        height: 40,
                      ),
                      motivationForm(),
                      SizedBox(
                        height: 20,
                      ),
                      descriptionForm(),
                      tendencySlider(),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(backgroundColor: Colors.transparent),
                                child: Text("취 소"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GetBuilder<CharactersController>(
                                builder: (controller) {
                                  return ElevatedButton(
                                    child: Text("저 장"),
                                    onPressed: () {
                                      if (_characterKey.currentState.validate()) {
                                        _characterKey.currentState.save();

                                        if (controller.myCharacters.isNotEmpty) {
                                          final lastId = controller.myCharacters.last.id;
                                          final number = lastId.split("_").last;
                                          _lastMyCharacterIdNum = int.parse(number);
                                        }

                                        controller.createMyCharacter(
                                          id: 'my_character_' + (_lastMyCharacterIdNum + 1).toString(),
                                          motivation: _motiveController.text,
                                          description: _descController.text,
                                          name: _nameController.text,
                                          gender: genderValue,
                                          age: _ageController.text,
                                          tendency: tendencyValue.toInt(),
                                        );

                                        Navigator.pop(context);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ageController.clear();
    _nameController.clear();
    _descController.clear();
    _motiveController.clear();
  }
}
