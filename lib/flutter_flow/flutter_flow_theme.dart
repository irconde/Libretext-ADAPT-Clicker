// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color mainGrey;
  late Color borderGrey;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  late Color primaryBtnText;
  late Color lineColor;
  late Color textFieldBackground;
  late Color drawerIconColor;
  late Color success;
  late Color failure;

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

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  late Color primaryColor = const Color(0xFF1862B3);
  late Color secondaryColor = const Color(0xFF6C757D);
  late Color tertiaryColor = const Color(0xFFEE8B60);
  late Color mainGrey = const Color(0xFF787878);
  late Color borderGrey = const Color(0xFFE3E3E3);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF57636C);

  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFFE0E3E7);
  late Color textFieldBackground = Color(0xFFEBF7FF);
  late Color drawerIconColor = Color(0xFF66AADB);
  late Color success = Color(0xFF008C3D);
  late Color failure = Color(0xFFD82828);
}

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
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get title1Family => 'Open Sans';
  TextStyle get title1 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  String get title2Family => 'Open Sans';
  TextStyle get title2 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  String get title3Family => 'Open Sans';
  TextStyle get title3 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  String get subtitle1Family => 'Open Sans';
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  String get subtitle2Family => 'Open Sans';
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  String get bodyText1Family => 'Open Sans';
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  String get bodyText2Family => 'Open Sans';
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Open Sans',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
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
