import 'package:adapt_clicker/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

/// Abstract class for defining the app theme.
abstract class AppTheme {
  /// Returns the current app theme based on the provided [context].
  static AppTheme of(BuildContext context) {
    return LightModeTheme();
  }

  String get fontFamily => typography.fontFamily;
  TextStyle get title1 => typography.title1;
  TextStyle get title2 => typography.title2;
  TextStyle get title3 => typography.title3;
  TextStyle get subtitle1 => typography.subtitle1;
  TextStyle get subtitle2 => typography.subtitle2;
  TextStyle get bodyText1 => typography.bodyText1;
  TextStyle get reverseBodyText => typography.reverseBodyText;
  TextStyle get bodyText2 => typography.bodyText2;
  TextStyle get bodyText3 => typography.bodyText2;

  /// Returns the typography for the app theme.
  Typography get typography => ThemeTypography(this);

  /// Builds an [OutlineInputBorder] with the specified [color].
  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  /// Returns the input decoration theme for text fields.
  InputDecorationTheme inputTheme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(Dimens.sMargin),
        floatingLabelStyle: const TextStyle(color: CColors.primaryColor),
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

  /// Returns the icon theme data for the app bar icons.
  IconThemeData appBarIconThemes() => const IconThemeData(
        size: Dimens.basicIconSize,
        color: CColors.primaryBackground,
      );

  /// Returns the app bar theme.
  AppBarTheme appBarTheme() => AppBarTheme(
        backgroundColor: CColors.primaryColor,
        titleTextStyle: title3,
        centerTitle: false,
        actionsIconTheme: appBarIconThemes(),
        iconTheme: appBarIconThemes(),
        titleSpacing: 14, //This is because the built in padding
        elevation: 0,
      );

  /// Returns Divider Theme
  DividerTheme dividerTheme() => const DividerTheme(
      data: DividerThemeData(
        color: CColors.primaryColor,
        thickness: Dimens.dividerThickness,
        space: Dimens.dividerHeight,
      ),
      child: Divider());
}

/// Concrete implementation of the app theme for light mode.
class LightModeTheme extends AppTheme {}

/// Abstract class that defines the typography configuration for an app.
abstract class Typography {
  String get fontFamily;
  TextStyle get title1;
  TextStyle get title2;
  TextStyle get title3;
  TextStyle get subtitle1;
  TextStyle get subtitle2;
  TextStyle get bodyText1;
  TextStyle get reverseBodyText;
  TextStyle get bodyText2;
  TextStyle get bodyText3;
}

/// Concrete implementation of the [Typography] abstract class that provides
/// the typography configuration for a specific app theme.
class ThemeTypography extends Typography {
  /// Creates an instance of [ThemeTypography] with the given [theme].
  ThemeTypography(this.theme);

  /// The app theme associated with this typography.
  final AppTheme theme;

  @override
  String get fontFamily => 'Open Sans';
  @override
  TextStyle get title1 => GoogleFonts.getFont(
        fontFamily,
        color: CColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: Dimens.titleTextSize,
      );
  @override
  TextStyle get title2 => GoogleFonts.getFont(
      fontFamily,
        color: CColors.primaryBackground,
        fontSize: Dimens.titleTextSize,
        fontWeight: FontWeight.bold,
      );
  @override
  TextStyle get title3 => GoogleFonts.getFont(
        fontFamily,
        color: CColors.primaryBackground,
        fontWeight: FontWeight.w600,
        fontSize: Dimens.titleTwoTextSize,
      );
  @override
  TextStyle get subtitle1 => GoogleFonts.getFont(
    fontFamily,
        color: CColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: Dimens.subtitleOneTextSize,
      );
  @override
  TextStyle get subtitle2 => GoogleFonts.getFont(
        fontFamily,
        color: CColors.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: Dimens.subtitleTwoTextSize,
      );
  @override
  TextStyle get bodyText1 => GoogleFonts.getFont(
    fontFamily,
        color: CColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: Dimens.defaultTextSize,
      );
  @override
  TextStyle get reverseBodyText => GoogleFonts.getFont(
    fontFamily,
    color: CColors.primaryBackground,
    fontWeight: FontWeight.normal,
    fontSize: Dimens.defaultTextSize,
  );
  @override
  TextStyle get bodyText2 => GoogleFonts.getFont(
    fontFamily,
        color: CColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: Dimens.defaultTextSize,
      );
  @override
  TextStyle get bodyText3 => GoogleFonts.getFont(
    fontFamily,
        color: CColors.tertiaryText,
        fontWeight: FontWeight.normal,
        fontSize: Dimens.defaultTextSize,
      );


}

/// Extension on the [TextStyle] class that provides helper methods for
/// overriding specific properties of a [TextStyle].
extension TextStyleHelper on TextStyle {
  /// Creates a new [TextStyle] by overriding specific properties of the current [TextStyle].
  ///
  /// The properties that can be overridden are:
  /// - [fontFamily]: The font family to use.
  /// - [color]: The color to use.
  /// - [fontSize]: The font size to use.
  /// - [fontWeight]: The font weight to use.
  /// - [letterSpacing]: The letter spacing to use.
  /// - [fontStyle]: The font style to use.
  /// - [useGoogleFonts]: Whether to use Google Fonts or not. Defaults to true.
  /// - [decoration]: The text decoration to use.
  /// - [decorationColor]: The color of the text decoration.
  /// - [lineHeight]: The line height to use.
  /// - [shadows]: The shadows to apply to the text.
  /// - [decorationThickness]: The thickness of the text decoration.
  ///
  /// Returns a new [TextStyle] with the specified properties overridden.
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
