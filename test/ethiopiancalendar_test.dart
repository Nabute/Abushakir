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

  test('Testing Constructor with Parameters', (){
    final ec = EthiopianCalendar(year: 2012,month: 07, day: 07);
    expect(ec.getYear(), 2012);
    expect(ec.getMonth(), 07);
    expect(ec.getDay(), 07);
    print("The value of 'moment' is ${ec.moment}"); // moment shouldn't be null

  });
  
  test('Testing Year with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getYear(), 2012);

  });

  test('Testing Month with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getMonth(), 07);

  });
  
  //FIXME: Day is reduced by 1.
  test('Testing Day with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getDay(), 07);
  });

  //FIXME: Reason unknown
  test('Testing Hour with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getHour(), 18);
  });

  test('Testing Minute with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getMinute(), 26);

  });

  test('Testing Second with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getSecond(), 31);
  });

  test('Testing Millisecond with Formatted String Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getMilliSecond(), 449);
  });
}
