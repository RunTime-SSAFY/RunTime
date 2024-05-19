import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/character.dart';
import 'package:front_android/src/repository/character_repository.dart';
import 'package:front_android/src/service/https_request_service.dart';

final characterViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => CharacterViewModel());

class CharacterViewModel with ChangeNotifier {
  CharacterRepository characterRepository = CharacterRepository();
  List<CharacterData> get characterList =>
      characterRepository.characters.toList()
        ..sort((a, b) => a.id.compareTo(b.id));
  String get characterCount => characterRepository.characters
      .where((element) => element.isCheck)
      .length
      .toString();

  //String get profileCharacter=>characterRepository.characters

  //String get profileCharacter{
  //  if(characterRepository.characters.where((element) => element.isCheck))

//}
  void getCharacterList() async {
    await Future.wait(
      [
        characterRepository.getCharacterList(),
      ],
    );
    notifyListeners();
  }

  Future<void> setMainCharacter(int characterId) async {
    try {
      var response = await apiInstance
          .patch('api/characters/$characterId/profile-characters');

      characterRepository.characters
          .firstWhere(
            (element) => element.id == characterId,
          )
          .isMain = true;
      characterRepository.characters
          .firstWhere(
            (element) => element.id == response.data['before'],
          )
          .isMain = false;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
