import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';
import 'package:project_writer_v04/pages/document/free_write_page/parts/free_write_create_pop.dart';
import 'package:project_writer_v04/pages/document/free_write_page/parts/free_write_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/re_free_cubit.dart';

class FreeWritePage extends StatelessWidget {
  final String appBarTitle;

  FreeWritePage({Key key, this.appBarTitle});

  final memoController = TextEditingController();
  final tagsController = TextEditingController();

  Widget floatingButton() {
    return Container(
      width: 50.0,
      height: 50.0,
      child: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(
          Icons.add,
          size: 25.0,
        ),
        backgroundColor: Color(0xFFe23e57),
        elevation: 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReFreeCubit>(context).readIdeaAndTags();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: appBarTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar(),
      ),
      floatingActionButton: BasicFloatingButton(
        icon: Icons.add,
        //onPressed: () => _openPopup(context),
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: ReFreeCubit(NewCombineRepository()),
              child: FreeWriteCreatePop(),
            );
          },
        ),
      ),
    );
  }
}
