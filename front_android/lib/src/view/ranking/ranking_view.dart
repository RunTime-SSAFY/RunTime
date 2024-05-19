import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/ranking/ranking_view_model.dart';

class RankingView extends ConsumerStatefulWidget {
  const RankingView({super.key});

  @override
  ConsumerState<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends ConsumerState<RankingView> {
  late RankingViewModel viewModel;

  @override
  void initState() {
    // characterRepository = CharacterRepository();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        viewModel.getRankingList();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(rankingViewModelProvider);
    final rankings = viewModel.rankingList;
    return ListView.builder(
        itemCount: rankings.length,
        itemBuilder: ((context, index) {
          final ranking = rankings[index];

          // final rankinglists = List.generate(10, (index) {
          //   return {
          //     'rank': index + 1,
          //     'nickname': ranking.nickname,
          //     'tierImage': Image.network(ranking.tierImage, fit: BoxFit.contain)
          //   };
          // });

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Top 10',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: rankings.length,
              itemBuilder: (context, index) {
                final ranking = rankings[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      // 등수
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: const Text(
                          'a',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // 닉네임
                      Expanded(
                        child: Text(
                          ranking.nickname,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // 티어 이미지
                      Image.network(ranking.tierImage, fit: BoxFit.contain),
                      //const SizedBox(width: 20),
                    ],
                  ),
                );
              },
            ),
          );
        }));
  }
}
