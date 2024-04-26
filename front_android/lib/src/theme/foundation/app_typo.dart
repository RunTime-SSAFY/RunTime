part of 'app_theme.dart';

class AppTypo {
  AppTypo({
    required this.typo,
    required this.fontColor,
    required this.appBarColor,
  });

  // typo
  final Typo typo;

  // font weight
  late FontWeight regular = typo.regular;
  late FontWeight semibold = typo.semiBold;
  late FontWeight bold = typo.bold;

  final Color fontColor;
  final Color appBarColor;

  late final TextStyle appBarTitle = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.bold,
    fontSize: 24,
    color: appBarColor,
  );
  late final TextStyle count = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.bold,
    fontSize: 80,
    color: fontColor,
  );

  late final TextStyle countSubTitle = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 20,
    color: fontColor,
  );

  late final TextStyle ranking = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.bold,
    fontSize: 30,
    color: fontColor,
  );

  late final TextStyle headline1 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 24,
    color: fontColor,
  );
  late final TextStyle headline2 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 20,
    color: fontColor,
  );
  late final TextStyle headline3 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle headline4 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 16,
    color: fontColor,
  );

  late final TextStyle subTitle1 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 20,
    color: fontColor,
  );
  late final TextStyle subTitle2 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 18,
    color: fontColor,
  );
  late final TextStyle subTitle3 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle subTitle4 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 14,
    color: fontColor,
  );
  late final TextStyle subTitle5 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 12,
    color: fontColor,
  );

  late final TextStyle body1 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle body2 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 14,
    color: fontColor,
  );
}
