import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LBTXTLocalizations {
  LBTXTLocalizations(this.locale);

  final Locale locale;

  static LBTXTLocalizations of(BuildContext context) =>
      Localizations.of<LBTXTLocalizations>(context, LBTXTLocalizations)!;

  static List<String> languages() => ['en'];

  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
  }) =>
      [enText][languageIndex] ?? '';
}

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

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap =
    <Map<String, Map<String, String>>>[].reduce((a, b) => a..addAll(b));
