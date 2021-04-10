part of 'my_life_bloc.dart';

@immutable
abstract class MyLifeStoryState extends Equatable {
  final List<MyLifeStory> myLifeStory;
  final List<String> years;
  final List<String> seasons;

  const MyLifeStoryState({this.myLifeStory, this.years, this.seasons});

  @override
  List<Object> get props => [myLifeStory];
}

class MyLifeStoryLoading extends MyLifeStoryState {
  @override
  String toString() => 'My Life Loading';
}

class MyLifeStoryLoaded extends MyLifeStoryState {
  final List<MyLifeStory> myLifeStory;
  final List<String> years;
  final List<String> seasons;

  MyLifeStoryLoaded({this.myLifeStory = const [], this.years, this.seasons})
      : super(myLifeStory: myLifeStory, years: years, seasons: seasons);

  @override
  String toString() => 'My Life {My Life: $myLifeStory, Year : $years, Season : $seasons}';
}

class MyLifeStoryNotLoaded extends MyLifeStoryState {
  @override
  String toString() => 'MyLifeStoryNotLoaded';
}
