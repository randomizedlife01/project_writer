import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

class StoryDeletePopup extends StatelessWidget {
  final String id;

  const StoryDeletePopup({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '정말로 요약과 스토리를\n삭제하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'GothicA1',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFe23e57),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '이 작업은 되돌릴 수 없습니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'GothicA1',
                        fontWeight: FontWeight.w200,
                        color: Color(0xFFe23e57),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              child: Text('취 소'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: GetBuilder<StorySummaryController>(
                              builder: (controller) {
                                return ElevatedButton(
                                  child: Text("삭 제"),
                                  onPressed: () {
                                    controller.deleteSummary(id: id);
                                    Navigator.pop(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
