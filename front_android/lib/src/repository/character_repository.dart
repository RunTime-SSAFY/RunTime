import 'package:flutter/foundation.dart';
import 'package:front_android/src/model/character.dart';
import 'package:front_android/src/service/https_request_service.dart';

class CharacterRepository {
  List<CharacterData> characters = [];

  Future<void> getCharacterList({
    int page = 1,
  }) async {
    try {
      var response = await apiInstance.get(
        'api/characters',
      );
      characters = (response.data as List)
          .map((e) => CharacterData.fromJson(e))
          .toList();
      return;
    } catch (error) {
      debugPrint(error.toString());
      return;
    }
  }
}
// class CharacterRepository {
//   List<CharacterView> characterList = [];
//   CharacterView newCharacter = CharacterView();
//   var api = apiInstance;

//   Future<void> getCharacterList() async {
//     try {
//       var response = await api.get('/characters');
//       print("--------[CharacterRepository] getCharacterList --------");
//       print(response.data);
//       characterList = (response.data as List)
//           .map((character) => CharacterView.fromJson(character))
//           .toList();
//     } catch (e, s) {
//       debugPrint('$e, $s');
//       throw Error();
//     }
//   }

//   Future<void> updateCharacter() async {
//     try {
//       var response = await api.patch('/api/characters');
//       print("--------[CharacterRepository] updateCharacter --------");
//       print(response.data);
//     } catch (e, s) {
//       debugPrint('$e, $s');
//       throw Error();
//     }
//   }
// }
