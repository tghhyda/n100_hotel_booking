part of 'app_theme.dart';

abstract class AppColors {
  factory AppColors(Brightness brightness) {
    // if (brightness == Brightness.dark) {
    //   return AppDarkColors();
    // }
    // Default
    return AppLightColors();
  }

  static AppColors get of => AppColors(Get.theme.brightness);

  Brightness get brightness;

  Color get errorColor;

  Color get warningColor;

  Color get successColor;

  Color get processInformColor;

  Color get cancelColor;

  Color get mainTextColor;

  Color get subTextColor;

  Color get disableColor;

  Color get borderColor;

  Color get dividerColor;

  Color get backgroundColor;

  Color get whiteColor;

  MaterialColor get primaryColor;

  MaterialColor get secondaryColor;

  MaterialColor get grayColor;

  MaterialColor get tealColor;

  MaterialColor get yellowColor;

  MaterialColor get redColor;

  MaterialColor get lightBlueColor;

  MaterialColor get greenColor;

  MaterialColor get daybreakBlueColor;
}

class AppLightColors implements AppColors {
  @override
  Brightness get brightness => Brightness.light;

  @override
  MaterialColor get primaryColor => tealColor;

  @override
  MaterialColor get secondaryColor => yellowColor;

  @override
  Color get errorColor => redColor[5] ?? redColor;

  @override
  Color get warningColor => yellowColor[5] ?? yellowColor;

  @override
  Color get successColor => greenColor[5] ?? greenColor;

  @override
  Color get processInformColor => lightBlueColor[5] ?? lightBlueColor;

  @override
  Color get cancelColor => grayColor[6] ?? grayColor;

  @override
  Color get mainTextColor => grayColor[10] ?? grayColor;

  @override
  Color get subTextColor => grayColor[7] ?? grayColor;

  @override
  Color get disableColor => grayColor[5] ?? grayColor;

  @override
  Color get borderColor => grayColor[4] ?? grayColor;

  @override
  Color get dividerColor => grayColor[3] ?? grayColor;

  @override
  Color get backgroundColor => grayColor[2] ?? grayColor;

  @override
  Color get whiteColor => grayColor[1] ?? grayColor;

  @override
  MaterialColor get grayColor => const MaterialColor(
        0xFF000D0B,
        {
          1: Color(0xFFFFFFFF),
          2: Color(0xFFF5F6FA),
          3: Color(0xFFEBECF0),
          4: Color(0xFFD4D5D9),
          5: Color(0xFFBBBCBF),
          6: Color(0xFF8A8B8C),
          7: Color(0xFF575859),
          8: Color(0xFF414142),
          9: Color(0xFF2A2A2B),
          10: Color(0xFF000D0B),
        },
      );

  @override
  MaterialColor get tealColor => const MaterialColor(
        0xFF00a499,
        {
          1: Color(0xFFE5F6F5),
          2: Color(0xFFC7EBE9),
          3: Color(0xFF8CD6D1),
          4: Color(0xFF4CBFB8),
          5: Color(0xFF00a499),
          6: Color(0xFF00867D),
          7: Color(0xFF00685E),
          8: Color(0xFF005149),
          9: Color(0xFF003B35),
          10: Color(0xFF002B27),
        },
      );

  @override
  MaterialColor get yellowColor => const MaterialColor(
        0xFFFFB81C,
        {
          1: Color(0xFFFFF8E8),
          2: Color(0xFFFFEFCD),
          3: Color(0xFFFFDF99),
          4: Color(0xFFFFCD60),
          5: Color(0xFFFFB81C),
          6: Color(0xFFCC9619),
          7: Color(0xFF997415),
          8: Color(0xFF735A13),
          9: Color(0xFF4C4010),
          10: Color(0xFF332F0E),
        },
      );

  @override
  MaterialColor get redColor => const MaterialColor(
        0xFFF5222D,
        {
          1: Color(0xFFFEE9EA),
          2: Color(0xFFFDCED1),
          3: Color(0xFFFB9CA0),
          4: Color(0xFFF8646C),
          5: Color(0xFFF5222D),
          6: Color(0xFFC91C25),
          7: Color(0xFF9A151C),
          8: Color(0xFF7B1117),
          9: Color(0xFF580C10),
          10: Color(0xFF42090C),
        },
      );

  @override
  MaterialColor get lightBlueColor => const MaterialColor(
        0xFF0089B6,
        {
          1: Color(0xFFE5F3F8),
          2: Color(0xFFC7E5EF),
          3: Color(0xFF8CCADE),
          4: Color(0xFF4CACCC),
          5: Color(0xFF0089B6),
          6: Color(0xFF007094),
          7: Color(0xFF005772),
          8: Color(0xFF004558),
          9: Color(0xFF00323E),
          10: Color(0xFF00262D),
        },
      );

  @override
  MaterialColor get greenColor => const MaterialColor(
        0xFF00A100,
        {
          1: Color(0xFFE5F6E5),
          2: Color(0xFFC7EAC7),
          3: Color(0xFF8CD58C),
          4: Color(0xFF4CBD4C),
          5: Color(0xFF00A100),
          6: Color(0xFF008302),
          7: Color(0xFF006604),
          8: Color(0xFF005006),
          9: Color(0xFF003908),
          10: Color(0xFF002B09),
        },
      );
  @override
  MaterialColor get daybreakBlueColor => const MaterialColor(
        0xFF1890FF,
        {
          1: Color(0xFFE0F5FF),
          2: Color(0xFFBAE7FF),
          3: Color(0xFF8AD2FF),
          4: Color(0xFF4DB4FF),
          5: Color(0xFF1890FF),
          6: Color(0xFF096DD9),
          7: Color(0xFF005BBD),
          8: Color(0xFF0049A3),
          9: Color(0xFF003073),
          10: Color(0xFF001D4D),
        },
      );
}

// class AppDarkColors implements AppColors {
//   @override
//   Brightness get brightness => Brightness.dark;

//   @override
//   MaterialColor get primaryColor => tealColor;

//   @override
//   MaterialColor get secondaryColor => yellowColor;

//   @override
//   Color get errorColor => redColor[5] ?? redColor;

//   @override
//   Color get warningColor => yellowColor[5] ?? yellowColor;

//   @override
//   Color get successColor => greenColor[5] ?? greenColor;

//   @override
//   Color get processInformColor => lightBlueColor[5] ?? lightBlueColor;

//   @override
//   Color get cancelColor => grayColor[6] ?? grayColor;

//   @override
//   Color get mainTextColor => grayColor[10] ?? grayColor;

//   @override
//   Color get subTextColor => grayColor[7] ?? grayColor;

//   @override
//   Color get disableColor => grayColor[5] ?? grayColor;

//   @override
//   Color get borderColor => grayColor[4] ?? grayColor;

//   @override
//   Color get dividerColor => grayColor[3] ?? grayColor;

//   @override
//   Color get backgroundColor => grayColor[2] ?? grayColor;

//   @override
//   Color get whiteColor => grayColor[1] ?? grayColor;

//   @override
//   MaterialColor get grayColor => const MaterialColor(
//         0xFF000D0B,
//         {
//           1: Color(0xFFFFFFFF),
//           2: Color(0xFFF5F6FA),
//           3: Color(0xFFEBECF0),
//           4: Color(0xFFD4D5D9),
//           5: Color(0xFFBBBCBF),
//           6: Color(0xFF8A8B8C),
//           7: Color(0xFF575859),
//           8: Color(0xFF414142),
//           9: Color(0xFF2A2A2B),
//           10: Color(0xFF000D0B),
//         },
//       );

//   @override
//   MaterialColor get tealColor => const MaterialColor(
//         0xFF00a499,
//         {
//           1: Color(0xFFE5F6F5),
//           2: Color(0xFFC7EBE9),
//           3: Color(0xFF8CD6D1),
//           4: Color(0xFFE5F6F5),
//           5: Color(0xFF00a499),
//           6: Color(0xFF00867D),
//           7: Color(0xFF00685E),
//           8: Color(0xFF005149),
//           9: Color(0xFF003B35),
//           10: Color(0xFF002B27),
//         },
//       );

//   @override
//   MaterialColor get yellowColor => const MaterialColor(
//         0xFFFFB81C,
//         {
//           1: Color(0xFFFFF8E8),
//           2: Color(0xFFFFEFCD),
//           3: Color(0xFFFFDF99),
//           4: Color(0xFFFFCD60),
//           5: Color(0xFFFFB81C),
//           6: Color(0xFFCC9619),
//           7: Color(0xFF997415),
//           8: Color(0xFF735A13),
//           9: Color(0xFF4C4010),
//           10: Color(0xFF332F0E),
//         },
//       );

//   @override
//   MaterialColor get redColor => const MaterialColor(
//         0xFFF5222D,
//         {
//           1: Color(0xFFFEE9EA),
//           2: Color(0xFFFDCED1),
//           3: Color(0xFFFB9CA0),
//           4: Color(0xFFF8646C),
//           5: Color(0xFFF5222D),
//           6: Color(0xFFC91C25),
//           7: Color(0xFF9A151C),
//           8: Color(0xFF7B1117),
//           9: Color(0xFF580C10),
//           10: Color(0xFF42090C),
//         },
//       );

//   @override
//   MaterialColor get lightBlueColor => const MaterialColor(
//         0xFF0089B6,
//         {
//           1: Color(0xFFE5F3F8),
//           2: Color(0xFFC7E5EF),
//           3: Color(0xFF8CCADE),
//           4: Color(0xFF4CACCC),
//           5: Color(0xFF0089B6),
//           6: Color(0xFF007094),
//           7: Color(0xFF005772),
//           8: Color(0xFF004558),
//           9: Color(0xFF00323E),
//           10: Color(0xFF00262D),
//         },
//       );

//   @override
//   MaterialColor get greenColor => const MaterialColor(
//         0xFF00A100,
//         {
//           1: Color(0xFFE5F6E5),
//           2: Color(0xFFC7EAC7),
//           3: Color(0xFF8CD58C),
//           4: Color(0xFF4CBD4C),
//           5: Color(0xFF00A100),
//           6: Color(0xFF008302),
//           7: Color(0xFF006604),
//           8: Color(0xFF005006),
//           9: Color(0xFF003908),
//           10: Color(0xFF002B09),
//         },
//       );
//   @override
//   MaterialColor get daybreakBlueColor => const MaterialColor(
//         0xFF1890FF,
//         {
//           1: Color(0xFFE0F5FF),
//           2: Color(0xFFBAE7FF),
//           3: Color(0xFF8AD2FF),
//           4: Color(0xFF4DB4FF),
//           5: Color(0xFF1890FF),
//           6: Color(0xFF096DD9),
//           7: Color(0xFF005BBD),
//           8: Color(0xFF0049A3),
//           9: Color(0xFF003073),
//           10: Color(0xFF001D4D),
//         },
//       );
// }
