import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Useful functions to manipulate currency.
class Currency {
  /// Formats the given number to and easily readable string.
  static String formatWithCurrency(
          {required num price,
          required Locale locale,
          required String currencyCodeAlpha3}) =>
      NumberFormat.currency(
        name: currencyCodeAlpha3,
        symbol: '${NumberFormat.simpleCurrency(
              name: currencyCodeAlpha3,
            ).currencySymbol ?? currencyCodeAlpha3} ',
        locale: _getCurrencyLocale(locale),
      ).format(price);

  static String _getCurrencyLocale(Locale locale) {
    final String frenchLocale = 'fr';
    final String englishLocale = 'en';

    return locale.languageCode.toLowerCase() == frenchLocale
        ? frenchLocale
        : englishLocale;
  }
}
