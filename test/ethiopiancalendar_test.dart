import 'package:flutter_test/flutter_test.dart';

import 'package:ethiopiancalendar/ethiopiancalendar.dart';

void main() {


  // Parameterized Constructors


  //FIXME: Day is reduced by 1
  test('Should Print the parsed Date and Time', () {
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.toString(), "2012-07-07 18:26:31.449");
  });

  test('Testing Year on Parameterized Constructor', (){
    final ec = EthiopianCalendar(year: 2012, month: 07, day: 07);
    expect(ec.getYear(), 2012);
  });

  test('Testing Month on Parameterized Constructor', (){
    final ec = EthiopianCalendar(year: 2012, month: 07, day: 07);
    expect(ec.getMonth(), 07);
  });

  //FIXME: Day is reduced by 1
  test('Testing Day on Parameterized Constructor', (){
    final ec = EthiopianCalendar(year: 2012, month: 07, day: 07);
    expect(ec.getDay(), 07);
  });

  //FIXME: Day is reduced by 1
  test('Testing Date on Parameterized Constructor', (){
    final ec = EthiopianCalendar(year: 2012, month: 07, day: 07);
    expect(ec.getDate(), "፯");
  });


  // Named Constructors
  

  test('Testing Year on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getYear(), 2012);
  });

  test('Testing Month on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getMonth(), 07);
  });
  
  //FIXME: Day is reduced by 1
  test('Testing Day on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getDay(), 07);
  });

  //FIXEME: Day is reduced 1
  test('Testing Date with Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getDate(), "፯");
  });

  //FIXME: Reason Unknown
  test('Testing Hour on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getHour(), 18);
  });

  test('Testing Minute on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getMinute(), 26);

  });

  test('Testing Second on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getSecond(), 31);
  });

  test('Testing Millisecond on Named Constructor', (){
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    expect(ec.getMilliSecond(), 449);
  });
}
