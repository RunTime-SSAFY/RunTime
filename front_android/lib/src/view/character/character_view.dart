import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/character/character_view_model.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class CharacterView extends ConsumerStatefulWidget {
  const CharacterView({super.key});

  @override
  ConsumerState<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterView> {
  // late CharacterRepository characterRepository;
  late CharacterViewModel viewModel;
  @override
  void initState() {
    // characterRepository = CharacterRepository();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        viewModel.getCharacterList();
      },
    );
    super.initState();
  }

//캐릭터 리스트
  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(characterViewModelProvider);
    final characters = viewModel.characterList; // viewModel에서 characters 가져오기
    final cnt = viewModel.characterCount;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '캐릭터',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '보유중 $cnt/${viewModel.characterList.length}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.65,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => _showCharacterInfo(
                        character.name,
                        character.imgUrl,
                        character.detail,
                        character.unlockStatus,
                        character.id,
                        character.isMain,
                        character.achievementName,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(100, 162),
                        backgroundColor: character.unlockStatus
                            ? ref.color.surface
                            : ref.color.profileEditButtonBackground,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Center(
                              child: character.unlockStatus
                                  ? character.isMain
                                      ? SvgPicture.asset(
                                          'assets/icons/unlock.svg',
                                          height: 20,
                                        )
                                      : const SizedBox(height: 20)
                                  : SvgPicture.asset(
                                      'assets/icons/lock.svg',
                                      height: 20,
                                    ),
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                              character.imgUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              character.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//캐릭터 상세조회
  void _showCharacterInfo(
    String name,
    String image,
    String detail,
    bool isUnlock,
    int characterId,
    bool isMain,
    String achievementName,
  ) {
    bool canChange = !isMain && isUnlock;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Stack(
            children: <Widget>[
              Positioned(
                left: 1.0,
                top: 1.0,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/cancel.svg',
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40.0, left: 40),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(image, fit: BoxFit.contain),
                const SizedBox(height: 10),
                if (!isUnlock)
                  SvgPicture.asset(
                    'assets/icons/lock.svg',
                    height: 30,
                  ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                if (!isUnlock)
                  Text(
                    S.current.characterAchievement(achievementName),
                    style: ref.typo.subTitle5,
                  ),
                if (!isUnlock) const SizedBox(height: 5),
                Button(
                  onPressed: () async {
                    await viewModel.setMainCharacter(characterId);
                    if (!context.mounted) return;
                    context.pop();
                  },
                  text: isMain
                      ? S.current.characterAlreadyMain
                      : isUnlock
                          ? S.current.characterSelect
                          : S.current.characterNotHave,
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.onAccept,
                  isInactive: !canChange,
                )
                // isCheck?ElevatedButton(onPressed: viewModel.setProfileCharacter(name);
                //       Navigator.of(context).pop();,
                //       child: viewModel.setProfileCharacter(name);
                //       Navigator.of(context).pop();)
              ],
            ),
          ),
        );
      },
    );
  }
}
