import 'package:intl/intl.dart';

class Formatter {
  static price(int price) => 'Rp$price';
  static date(DateTime date) => DateFormat.yMd().format(date);
}
