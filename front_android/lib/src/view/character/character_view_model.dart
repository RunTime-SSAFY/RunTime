import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/character.dart';
import 'package:front_android/src/repository/character_repository.dart';

final characterViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => CharacterViewModel());

class CharacterViewModel with ChangeNotifier {
  CharacterRepository characterRepository = CharacterRepository();
  List<Character> get characterList => characterRepository.characters;
  String get characterCount => characterRepository.characters
      .where((element) => element.isCheck)
      .length
      .toString();
      
  // String get profileCharacter{
  //   if(characterRepository.characters.where((element) => element.isCheck)) 
  // }
  void getCharacterList() async {
    await Future.wait(
      [
        characterRepository.getCharacterList(),
      ],
    );
    notifyListeners();
  }
}
