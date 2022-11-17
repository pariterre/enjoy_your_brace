import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocaleText with ChangeNotifier {
  LocaleText({required this.language});

  void setLanguage(language) {
    this.language = language;
    notifyListeners();
  }

  String language;

  static LocaleText of(BuildContext context, {bool listen = true}) {
    return Provider.of<LocaleText>(context, listen: listen);
  }

  String get template => {'en': 'Template', 'fr': 'Canevas'}[language]!;
  String get title =>
      {'en': 'Enjoy Your Brace', 'fr': 'Aime ton corset'}[language]!;
  String get temperature =>
      {'en': 'Temperature', 'fr': 'Température'}[language]!;
  String get mean => {'en': 'mean:', 'fr': 'moyenne :'}[language]!;
  String get day => {'en': 'day', 'fr': 'jour'}[language]!;
  String get meanWearingTime =>
      {'en': 'Mean wearing time:', 'fr': 'Temps de port moyen :'}[language]!;
  String get totalWearingTime =>
      {'en': 'Total wearing time:', 'fr': 'Temps de port total :'}[language]!;
}
