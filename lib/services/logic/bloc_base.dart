import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }
}
