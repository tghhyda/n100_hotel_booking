part of 'app_theme.dart';

class _AppTextSize {
  static const double T24 = 24;
  static const double T18 = 18;
  static const double T16 = 16;
  static const double T14 = 14;
  static const double T12 = 12;
  static const double T10 = 10;
}

class _AppTextHeight {
  static const double H24_32 = 32 / 24;
  static const double H18_26 = 26 / 18;
  static const double H16_24 = 24 / 16;
  static const double H14_22 = 22 / 14;
  static const double H12_18 = 18 / 12;
  static const double H10_16 = 16 / 10;
}

abstract class _AppTextStyle {
  static FontWeight get bold => FontWeight.w700;

  static FontWeight get semiBold => FontWeight.w600;

  static FontWeight get regular => FontWeight.w400;

  static FontWeight get medium => FontWeight.w500;

  static TextTheme textTheme(AppColors appColor) {
    return TextTheme(
      /// headline1
      displayLarge: _textHeading1s.copyWith(
        color: appColor.grayColor,
      ),

      /// headline2
      displayMedium: _textHeading2s.copyWith(
        color: appColor.grayColor,
      ),

      /// headline3
      displaySmall: _textHeading3s.copyWith(
        color: appColor.grayColor,
      ),

      /// bodyText1
      bodyLarge: _textBody1r.copyWith(
        color: appColor.grayColor,
      ),

      labelLarge: _subTitle1r.copyWith(
        color: appColor.grayColor,
      ),

      labelMedium: _subTitle2r.copyWith(
        color: appColor.grayColor,
      ),
    );
  }

  static final TextStyle _textHeading1s = TextStyle(
    height: _AppTextHeight.H24_32,
    fontSize: _AppTextSize.T24,
    fontWeight: semiBold,
  );

  static final TextStyle _textHeading2s = TextStyle(
    height: _AppTextHeight.H18_26,
    fontSize: _AppTextSize.T18,
    fontWeight: semiBold,
  );

  static final TextStyle _textHeading3s = TextStyle(
    height: _AppTextHeight.H16_24,
    fontSize: _AppTextSize.T16,
    fontWeight: semiBold,
  );

  static final TextStyle _textBody1r = TextStyle(
    height: _AppTextHeight.H14_22,
    fontSize: _AppTextSize.T14,
    fontWeight: regular,
  );

  static final TextStyle _subTitle1r = TextStyle(
    height: _AppTextHeight.H12_18,
    fontSize: _AppTextSize.T12,
    fontWeight: regular,
  );

  static final TextStyle _subTitle2r = TextStyle(
    height: _AppTextHeight.H10_16,
    fontSize: _AppTextSize.T10,
    fontWeight: regular,
  );
}
