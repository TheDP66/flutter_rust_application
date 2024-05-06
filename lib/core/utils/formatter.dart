import 'package:intl/intl.dart';

class Formatter {
  static price(int price) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    );

    return currencyFormat.format(price);
  }

  static date(DateTime date) {
    final outputFormat = DateFormat('yyyy-MM-dd');

    return outputFormat.format(date).replaceAll("/", "-");
  }

  static monthDate(DateTime date) {
    final outputFormat = DateFormat('MMM d');

    return outputFormat.format(date).replaceAll("/", "-");
  }

  static time(DateTime date) {
    // ? Hm -> 13:27
    // ? jm -> 1:27 PM
    final outputFormat = DateFormat('Hm');

    return outputFormat.format(date).replaceAll("/", "-");
  }
}
