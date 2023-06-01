import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Represents the localizations for a specific locale.
class LBTXTLocalizations {
  LBTXTLocalizations(this.locale);

  final Locale locale;

  /// Retrieves the current [LBTXTLocalizations] instance from the given [context].
  static LBTXTLocalizations of(BuildContext context) =>
      Localizations.of<LBTXTLocalizations>(context, LBTXTLocalizations)!;

  /// Returns a list of supported languages.
  static List<String> languages() => ['en'];

  /// Returns the language code for the current locale.
  String get languageCode => locale.toString();

  /// Returns the index of the current language in the list of supported languages.
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  /// Retrieves the localized text for the given [key] based on the current locale.
  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  /// Retrieves the localized variable text based on the current language index.
  String getVariableText({
    String? enText = '',
  }) =>
      [enText][languageIndex] ?? '';
}

/// A [LocalizationsDelegate] for [LBTXTLocalizations].
class LBTXTLocalizationsDelegate
    extends LocalizationsDelegate<LBTXTLocalizations> {
  const LBTXTLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LBTXTLocalizations.languages().contains(locale.toString());

  @override
  Future<LBTXTLocalizations> load(Locale locale) =>
      SynchronousFuture<LBTXTLocalizations>(LBTXTLocalizations(locale));

  @override
  bool shouldReload(LBTXTLocalizationsDelegate old) => false;
}

/// Creates a [Locale] instance from the given [language] string.
Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

/// The map containing the translations for different languages.
final kTranslationsMap =
    <Map<String, Map<String, String>>>[].reduce((a, b) => a..addAll(b));
