import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/ranking/ranking_view_model.dart';
import 'package:front_android/src/view/ranking/widgets/ranking_list_card.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

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
        viewModel.clearRankingList();
        viewModel.getRankingList();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(rankingViewModelProvider);
    final rankings = viewModel.rankingList;
    // final rankinglists = List.generate(10, (index) {
    //   return {
    //     'rank': index + 1,
    //     'nickname': ranking.nickname,
    //     'tierImage': Image.network(ranking.tierImage, fit: BoxFit.contain)
    //   };
    // });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          color: ref.color.black,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          S.current.ranking,
          style: ref.typo.appBarSubTitle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rankings.length,
              itemBuilder: (context, index) {
                final ranking = rankings[index];
                return RankingListCard(
                  rank: index + 1,
                  ranking: ranking,
                );
              },
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: RankingListCard(
          //         rank: rank,
          //         ranking: ranking,
          //       );
          // )
        ],
      ),
    );
  }
}
