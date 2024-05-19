import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_android/src/view/character/character_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(characterViewModelProvider);
    final characters = viewModel.characterList; // viewModel에서 characters 가져오기

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '보유중 2/20',
              style: TextStyle(
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
                    onPressed: () =>
                        _showCharacterInfo(character.name, character.imgUrl),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 162),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Center(
                            child: SvgPicture.asset('assets/icons/lock.svg'),
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            character.imgUrl,
                            fit: BoxFit.cover,
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
    );
  }

  void _showCharacterInfo(String name, String image) {
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
                Image.network(image, fit: BoxFit.cover),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '설명',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
