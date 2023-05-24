import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    return LightModeTheme();
  }

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;
  String get bodyText3Family => typography.bodyText2Family;
  TextStyle get bodyText3 => typography.bodyText2;

  Typography get typography => ThemeTypography(this);

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  InputDecorationTheme inputTheme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(16),
        floatingLabelStyle:
            const TextStyle(color: CColors.primaryColor),
        alignLabelWithHint: true,
        labelStyle: bodyText2,
        filled: true,

        //default, all other null
        border: _buildBorder(CColors.textFieldBorder),
        //Enabled and not showing error
        enabledBorder: _buildBorder(CColors.textFieldBorder),
        //No Focus but error
        errorBorder: _buildBorder(CColors.failure),
        //Focussed with error
        focusedErrorBorder: _buildBorder(CColors.failure),
        //Focused but no Error
        focusedBorder: _buildBorder(CColors.primaryColor),

        fillColor: CColors.textFieldBackground,
        prefixIconColor: CColors.tertiaryColor,
        suffixIconColor: CColors.tertiaryColor,
      );

  IconThemeData appBarIconThemes() => const IconThemeData(
        size: 24,
        color: CColors.primaryBackground,
      );

  AppBarTheme appBarTheme() => AppBarTheme(
        backgroundColor: CColors.primaryColor,
        titleTextStyle: title3,
        centerTitle: false,
        actionsIconTheme: appBarIconThemes(),
        iconTheme: appBarIconThemes(),
        titleSpacing: 14, //This is because the built in padding
        elevation: 0,
      );
}

class LightModeTheme extends AppTheme {}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;
  String get bodyText3Family;
  TextStyle get bodyText3;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  @override
  String get title1Family => 'Open Sans';
  @override
  TextStyle get title1 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  @override
  String get title2Family => 'Open Sans';
  @override
  TextStyle get title2 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.primaryBackground,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
  @override
  String get title3Family => 'Open Sans';
  @override
  TextStyle get title3 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.primaryBackground,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  @override
  String get subtitle1Family => 'Open Sans';
  @override
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  @override
  String get subtitle2Family => 'Open Sans';
  @override
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  @override
  String get bodyText1Family => 'Open Sans';
  @override
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText2Family => 'Open Sans';
  @override
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText3Family => 'Open Sans';
  @override
  TextStyle get bodyText3 => GoogleFonts.getFont(
        'Open Sans',
        color: CColors.tertiaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    Color? decorationColor,
    double? lineHeight,
    List<Shadow>? shadows,
    double? decorationThickness,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              decorationColor: decorationColor ?? this.color,
              height: lineHeight,
              shadows: shadows,
              decorationThickness: decorationThickness,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
