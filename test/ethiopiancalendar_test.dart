//import 'package:flutter_test/flutter_test.dart';

import 'package:ethiopiancalendar/ethiopiancalendar.dart';

void main() {

<<<<<<< Updated upstream
  // All the starting dates of the months
  //TODO መስከረም - Regular = September 11, Leap Year = September 12 
  //TODO ጥቅምት - Regular = October 11, Leap Year = October 12 
  //TODO ኅዳር - Regular = November 10, Leap Year = November 11 
  //TODO ታኅሳስ - Regular = December 10, Leap Year = December 12 
  //TODO ጥር - Regular = January 09, Leap Year = September 10 
  //TODO የካቲት - Regular = February 08, Leap Year = September 09 
  //TODO መጋቢት - Regular = March 10 
  //TODO ሚያዝያ - Regular = April 09 
  //TODO ግንቦት - Regular = May 09 
  //TODO ሰኔ - Regular = June 08 
  //TODO ኃምሌ - Regular = July 08 
  //TODO ነሐሴ - Regular = August 07
  //TODO ጷጉሜን - Regular = September 06 

  // Holidays
  //TODO አዲስ አመት - Regular = September 11, Leap Year = September 12 

=======
  test('Should Print the parsed Date and Time', () {
    final ec = EthiopianCalendar.parse("2012-07-07 18:26:31.449");
    // expect(ec.toString(), "2012-07-07 18:26:31.449");
    print(ec.moment);
  });

  test('Should Print Constructed Date', () {
    final ec = EthiopianCalendar(year: 2012, month: 07, day: 07);
    // expect(ec.toString(), "2012-07-07");
    print(ec.moment);
  });

  test('Should Print the correct Month Name', () {
    final ec = EthiopianCalendar.now();
    expect(ec.monthName, 'መጋቢት');
    print(ec.toIso8601String());
  });
>>>>>>> Stashed changes
}
