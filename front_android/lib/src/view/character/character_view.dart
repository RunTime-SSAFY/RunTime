import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/character/character_view_model.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '보유중 $cnt/${viewModel.characterList.length}',
                style: TextStyle(
                  color: ref.palette.gray500,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
                            ? ref.color.white
                            : ref.color.profileEditButtonBackground,
                        // inline border
                        side: character.isMain
                            ? const BorderSide(
                                color: Color(0xFF6563FF),
                                width: 1,
                              )
                            : BorderSide(
                                color: ref.color.black.withOpacity(0),
                                width: 0,
                              ),

                        // 그림자
                        elevation: 3,
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
                            child: OverflowTextAnimated(
                              text: character.name,
                              style: TextStyle(
                                color: character.unlockStatus
                                    ? Colors.black
                                    : ref.palette.gray500,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              curve: Curves.fastEaseInToSlowEaseOut,
                              animation: OverFlowTextAnimations.scrollOpposite,
                              animateDuration:
                                  const Duration(milliseconds: 1500),
                              delay: const Duration(milliseconds: 500),
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
          titlePadding: EdgeInsets.zero,
          backgroundColor: ref.color.white,
          surfaceTintColor: Colors.transparent,
          // 타이틀 (닫기 버튼)
          title: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.close_rounded,
                color: ref.palette.gray500,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // 내용
          content: SingleChildScrollView(
            child: SizedBox(
              // padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // 캐릭터 이미지
                  Image.network(
                      // image 변수를 가져와서 끝 3글자만 잘라서 이미지 경로로 사용
                      '${image.substring(0, image.length - 3)}gif',
                      fit: BoxFit.contain,
                      height: 160,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Image.network(
                                  image,
                                  height: 160,
                                )),
                  // : const SizedBox(
                  //     height: 160,
                  //     child: Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  //   )),
                  const SizedBox(height: 10),

                  // 잠금 상태 표시
                  !isUnlock
                      ? SvgPicture.asset(
                          'assets/icons/lock.svg',
                          height: 24,
                        )
                      : const SizedBox(
                          height: 24,
                        ),
                  const SizedBox(height: 6),
                  // 캐릭터 이름
                  Text(name,
                      style: ref.typo.headline1.copyWith(
                        color: ref.color.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      )),
                  // 잠금 해제 조건
                  if (!isUnlock)
                    Text(
                      S.current.characterAchievement(achievementName),
                      style: ref.typo.subTitle5.copyWith(
                        color: ref.palette.gray400,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  if (!isUnlock) const SizedBox(height: 5),

                  const SizedBox(height: 20),
                  // 캐릭터 설명
                  Text(
                    detail,
                    style: ref.typo.body1.copyWith(
                      color: ref.palette.gray600,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 캐릭터 선택 버튼
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
                    fontSize: 18,
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
          ),
        );
      },
    );
  }
}
