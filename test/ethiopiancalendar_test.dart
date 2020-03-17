import 'package:flutter_test/flutter_test.dart';

import 'package:ethiopiancalendar/ethiopiancalendar.dart';

void main() {
//  test('adds one to input values', () {
//    final calculator = Calculator();
//    expect(calculator.addOne(2), 3);
//    expect(calculator.addOne(-7), -6);
//    expect(calculator.addOne(0), 1);
//    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
//  });

  test('Should Print the parsed Date and TIme', () {
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.toString(), "2012-07-07 18:26:31.449");
  });
}
