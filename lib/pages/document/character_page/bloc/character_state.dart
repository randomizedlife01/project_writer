part of 'character_bloc.dart';

@immutable
abstract class CharactersState extends Equatable {
  final List<CharacterData> myCharacters;

  const CharactersState({this.myCharacters});

  @override
  List<Object> get props => [myCharacters];
}

class CharactersLoading extends CharactersState {
  @override
  String toString() => 'My Life Loading';
}

class CharactersLoaded extends CharactersState {
  final List<CharacterData> myCharacters;

  CharactersLoaded({this.myCharacters = const []}) : super(myCharacters: myCharacters);

  @override
  String toString() => 'myCharacters {myCharacters: $myCharacters}';
}

class CharactersNotLoaded extends CharactersState {
  @override
  String toString() => 'CharactersNotLoaded';
}
