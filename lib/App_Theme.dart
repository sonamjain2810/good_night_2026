import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/SizeConfig.dart';

class AppTheme {
  AppTheme._();

  // ================= LIGHT COLORS =================
  static const Color _lightIconColor = Colors.grey;
  static Color? _lightPrimaryColor = Colors.blueGrey[100];
  static Color? _lightPrimaryVariantColor = Colors.blue[900];
  static const Color _lightSecondaryColor = Colors.grey;
  static const Color _lightOnPrimaryColor = Colors.black;
  static Color _lightPrimaryIconThemeColor = Colors.purple;
  static const Color _lightButtonTextColor = Colors.white;
  static const Color _lightButtonColor = Colors.yellow;
  static Color _lightButtonSplashColor = Colors.purple;
  static const Color _lightAppBarTextColor = Colors.white;
  static const Color _lightDividerColor = Colors.black;
  static const Color _lightCardColor = Colors.white70;
  static const Color _lightShadowColor = Colors.grey;

  // ================= DARK COLORS =================
  static Color _darkIconColor = Colors.white;
  static const Color _darkPrimaryColor = Colors.black;
  static Color? _darkPrimaryVariantColor = Colors.grey[800];
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkPrimaryIconThemeColor = Colors.red;
  static const Color _darkButtonTextColor = Colors.white;
  static const Color _darkButtonColor = Colors.red;
  static const Color _darkButtonSplashColor = Colors.blue;
  static const Color _darkAppBarTextColor = Colors.white;
  static const Color _darkDividerColor = Colors.white;
  static const Color _darkCardColor = Colors.grey;
  static const Color _darkShadowColor = Colors.white70;

  // ================= LIGHT THEME =================
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor!,
      primaryContainer: _lightPrimaryVariantColor!,
      secondary: _lightPrimaryVariantColor!,
      onPrimary: _lightOnPrimaryColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _lightPrimaryVariantColor,
      elevation: 8,
      iconTheme: IconThemeData(color: _lightPrimaryColor),
      titleTextStyle:
          GoogleFonts.lobster(textStyle: _lightAppBarHeadlineStyle),
      toolbarTextStyle:
          GoogleFonts.lobster(textStyle: _lightAppBarHeadlineStyle),
    ),

    iconTheme: const IconThemeData(color: _lightIconColor),
    primaryIconTheme:
        IconThemeData(color: _lightPrimaryIconThemeColor),

    textTheme: _lightTextTheme,

    dividerColor: _lightDividerColor,
    canvasColor: _lightPrimaryColor,

    cardTheme: _lightCardTheme,

    inputDecorationTheme: _lightInputDecorationTheme,
  );

  // ================= TEXT THEMES =================
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge:
        GoogleFonts.oswald(textStyle: _lightScreenHeadingStyle),
    bodyLarge:
        GoogleFonts.ptSans(textStyle: _lightScreenBody1Style),
    bodyMedium:
        GoogleFonts.ptSans(textStyle: _lightScreenBody2Style),
    titleMedium:
        GoogleFonts.ptSans(textStyle: _lightScreenSubTitle1Style),
    titleSmall:
        GoogleFonts.ptSans(textStyle: _lightScreenSubTitle2Style),
    labelLarge:
        GoogleFonts.ptSans(textStyle: _lightButtonTextStyle),
  );

  // ================= TEXT STYLES =================
  static final TextStyle _lightAppBarHeadlineStyle =
      TextStyle(color: _lightAppBarTextColor);

  static final TextStyle _lightScreenHeadingStyle = TextStyle(
    fontSize: 2.68 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold,
    color: _lightOnPrimaryColor,
    letterSpacing: 1,
  );

  static final TextStyle _lightScreenBody1Style = TextStyle(
    fontSize: 2.23 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
    letterSpacing: .5,
  );

  static final TextStyle _lightScreenBody2Style = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: _lightPrimaryColor,
    letterSpacing: .5,
  );

  static final TextStyle _lightScreenSubTitle1Style = TextStyle(
    fontSize: 1.79 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
    letterSpacing: .3,
  );

  static final TextStyle _lightScreenSubTitle2Style = TextStyle(
    fontSize: 1.60 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
    letterSpacing: .10,
  );

  static final TextStyle _lightButtonTextStyle = TextStyle(
    fontSize: 1.56 * SizeConfig.textMultiplier,
    color: _lightButtonTextColor,
  );

  // ================= INPUT =================
  static final InputDecorationTheme _lightInputDecorationTheme =
      InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: _lightPrimaryVariantColor!),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: _lightPrimaryVariantColor!),
    ),
    hintStyle:
        GoogleFonts.ptSans(textStyle: _lightScreenBody1Style),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );

  // ================= CARD =================
  static final CardThemeData _lightCardTheme = CardThemeData(
  elevation: 6.0,
  color: _lightCardColor,
  shadowColor: _lightShadowColor,
);

  // ================= DARK THEME =================
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor!,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _darkPrimaryVariantColor,
      elevation: 8,
      iconTheme: const IconThemeData(color: _darkOnPrimaryColor),
      titleTextStyle:
          GoogleFonts.lobster(textStyle: _darkAppBarHeadlineStyle),
      toolbarTextStyle:
          GoogleFonts.lobster(textStyle: _darkAppBarHeadlineStyle),
    ),

    iconTheme: IconThemeData(color: _darkIconColor),
    primaryIconTheme:
        const IconThemeData(color: _darkPrimaryIconThemeColor),

    textTheme: _darkTextTheme,

    dividerColor: _darkDividerColor,
    canvasColor: _darkPrimaryColor,
    cardTheme: _darkCardTheme,
    inputDecorationTheme: _darkInputDecorationTheme,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge:
        GoogleFonts.oswald(textStyle: _darkScreenHeadingStyle),
    bodyLarge:
        GoogleFonts.ptSans(textStyle: _darkScreenBody1Style),
    titleMedium:
        GoogleFonts.ptSans(textStyle: _darkScreenSubTitle1Style),
    titleSmall:
        GoogleFonts.ptSans(textStyle: _darkScreenSubTitle2Style),
    labelLarge:
        GoogleFonts.ptSans(textStyle: _darkButtonTextStyle),
  );

  static final TextStyle _darkAppBarHeadlineStyle =
      _lightAppBarHeadlineStyle.copyWith(
          color: _darkAppBarTextColor);

  static final TextStyle _darkScreenHeadingStyle =
      _lightScreenHeadingStyle.copyWith(
          color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenBody1Style =
      _lightScreenBody1Style.copyWith(
          color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenSubTitle1Style =
      _lightScreenSubTitle1Style.copyWith(
          color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenSubTitle2Style =
      _lightScreenSubTitle2Style.copyWith(
          color: _darkOnPrimaryColor);

  static final TextStyle _darkButtonTextStyle =
      _lightButtonTextStyle.copyWith(
          color: _darkButtonTextColor);

  static final InputDecorationTheme _darkInputDecorationTheme =
      _lightInputDecorationTheme.copyWith(
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: _darkPrimaryVariantColor!),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: _darkPrimaryVariantColor!),
    ),
  );

 static final CardThemeData _darkCardTheme = _lightCardTheme.copyWith(
  color: _darkCardColor,
  shadowColor: _darkShadowColor,
);
}