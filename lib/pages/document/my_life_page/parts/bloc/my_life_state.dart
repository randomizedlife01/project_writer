part of 'my_life_bloc.dart';

@immutable
abstract class MyLifeStoryState extends Equatable {
  final List<MyLifeStory> myLifeStory;

  const MyLifeStoryState({this.myLifeStory});

  @override
  List<Object> get props => [myLifeStory];
}

class MyLifeStoryLoading extends MyLifeStoryState {
  @override
  String toString() => 'My Life Loading';
}

class MyLifeStoryLoaded extends MyLifeStoryState {
  final List<MyLifeStory> myLifeStory;

  MyLifeStoryLoaded({this.myLifeStory = const []}) : super(myLifeStory: myLifeStory);

  @override
  String toString() => 'My Life {My Life: $myLifeStory}';
}

class MyLifeStoryNotLoaded extends MyLifeStoryState {
  @override
  String toString() => 'MyLifeStoryNotLoaded';
}
