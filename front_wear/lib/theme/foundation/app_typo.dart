part of 'app_theme.dart';

class AppTypo {
  AppTypo({
    required Typo typo,
    required this.fontColor,
  }) : _typo = typo;

  // typo
  final Typo _typo;

  // font weight
  late FontWeight regular = _typo.regular;
  late FontWeight semibold = _typo.semiBold;
  late FontWeight bold = _typo.bold;

  final Color fontColor;

  late final TextStyle mainTitle = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.bold,
    fontSize: 50,
    color: fontColor,
  );

  late final TextStyle appBarMainTitle = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.bold,
    fontSize: 24,
    color: fontColor,
  );

  late final TextStyle appBarSubTitle = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.bold,
    fontSize: 24,
    color: fontColor,
  );

  late final TextStyle count = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.bold,
    fontSize: 80,
    color: fontColor,
  );

  late final TextStyle countSubTitle = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.semiBold,
    fontSize: 20,
    color: fontColor,
  );

  late final TextStyle ranking = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.bold,
    fontSize: 30,
    color: fontColor,
  );

  late final TextStyle headline1 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.semiBold,
    fontSize: 24,
    color: fontColor,
  );
  late final TextStyle headline2 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.semiBold,
    fontSize: 20,
    color: fontColor,
  );
  late final TextStyle headline3 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.semiBold,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle headline4 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.semiBold,
    fontSize: 16,
    color: fontColor,
  );

  late final TextStyle subTitle1 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 20,
    color: fontColor,
  );
  late final TextStyle subTitle2 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 18,
    color: fontColor,
  );
  late final TextStyle subTitle3 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle subTitle4 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 14,
    color: fontColor,
  );
  late final TextStyle subTitle5 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 12,
    color: fontColor,
  );

  late final TextStyle body1 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle body2 = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.regular,
    fontSize: 14,
    color: fontColor,
  );
  late final TextStyle wSubTitle = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.semiBold,
    fontSize: 14,
    color: fontColor,
  );
  late final TextStyle wCounter = TextStyle(
    height: 1.3,
    fontFamily: _typo.name,
    fontWeight: _typo.bold,
    fontSize: 50,
    color: fontColor,
  );
}
