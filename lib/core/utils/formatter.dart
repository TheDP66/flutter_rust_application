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
}
