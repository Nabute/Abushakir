import 'package:abushakir/abushakir.dart';

void main() {
//  DateTime now = DateTime.parse("1969-07-20 20:18:04Z");

//  EthiopianCalendar(now);
//  var now = EthiopianCalendar.parse("1995-04-27 20:18:04Z");
//  var now = EthiopianCalendar.parse("1970-01-01 00:00:00"); // 1962-ታኅሳስ-23 unix epoch started

//  EtDatetime now = EtDatetime.now();
//  EtDatetime now = EtDatetime(year: 2012, month: 07, day: 26, hour: 15, minute: 06, second: 16, millisecond: 058);
//  EtDatetime now = EtDatetime.parse("2012-07-07 15:12:17.500"); //
//   Monday, June 23, 2003 8:15:22 PM GMT+03:00 == 1995-10-16 02:15:22 ET == 1056388522000
//  print(now.moment);
//  EtDatetime now1 = new EtDatetime.fromMillisecondsSinceEpoch(1548918809500);  // 14 Hour == 2 PM
//  print(EtDatetime.fromMillisecondsSinceEpoch(now.moment));
//  print("Year: ${now.year}");
//  print("Month: ${now.month}");
//  print("Day: ${now.day}");
//  print("Hour: ${now.hour}");
//  print("Minutes: ${now.minute}");
//  print("Seconds: ${now.second}");
//  print("MilliSeconds: ${now.millisecond}");
//  print("To String Now: ${now.toString()}");
//  print("To JSON Now: ${now.toJson()}");
//  print("UnParsed moment Now:= ${now.moment}, Parsed Fixed:= ${now.fixed}");
//  print("To ISO8601String Format: ${now.toIso8601String()}");
//  print("The Month is ${now.monthGeez}");

//  print("******************   Testing utility funciton   *****************");
  /*
  Saturday, March 28, 2020 1:00:00 AM
  Saturday, March 28, 2020 4:00:00 AM GMT+03:00
   */
//  EtDatetime before = new EtDatetime.fromMillisecondsSinceEpoch(1585357200);
  //
  /*
  Sunday, March 29, 2020 1:00:00 AM
  Sunday, March 29, 2020 4:00:00 AM GMT+03:00
   */
//  EtDatetime after = new EtDatetime.fromMillisecondsSinceEpoch(1585443600);
//  EtDatetime sameMomentWithAfter =
//      new EtDatetime.fromMillisecondsSinceEpoch(1585443600);

//  print("Before:= $before");
//  print("After:= $after");
//  print("Is Before:= ${after.isBefore(before)}");
//  print("Is After:= ${after.isAfter(before)}");
//  print("Compare to:= ${before.compareTo(after)}");
//  print(
//      "Is Is As the same moment as:= ${after.isAtSameMomentAs(sameMomentWithAfter)}");
//  EtDatetime addedDateTime = before.add(Duration(days: 5));
//  print("Adding one day:= $addedDateTime}");
//  print("------- RETESTING AFTER ADDING ONE DAY --------");
//  print("Is Before:= ${before.add(Duration(days: 2)).isBefore(after)}");
//  print("Is After:= ${before.add(Duration(days: 2)).isAfter(after)}");
//  print(
//      "Compare to:= ${before.add(Duration(days: 1)).compareTo(after.subtract(Duration(days: 1)))}");

//  EtDatetime dt = new EtDatetime(year: 2011, month: 1);
//  print("Year First Day:= ${dt.yearFirstDay}");
//  print("Year First Day:= ${dt.weekday}");
//  print("Year First Day:= ${dt.toString()}");

//  print("**********************FROM EPOCH**********************************");

//  var b = EtDatetime.fromMillisecondsSinceEpoch(1568222122);
//  // Epoch for Pagumen 6. 2011, 02:15:22 = 1568211322
//  // Epoch for Pagumen 6. 2011, 12:00:00 ጠዋት = 1568192400
//  print("Year: ${b.year}");
//  print("Month: ${b.month}");
//  print("Date: ${b.day}");
//  print("Hour: ${b.hour}");
//  print("Minutes: ${b.minute}");
//  print("Seconds: ${b.second}");
//  print("MilliSeconds: ${b.millisecond}");
//  print(b.toString());
//  print(b.toJson());
//  print(b.toIso8601String());
//  print("The Month is ${b.monthGeez}");

//  print("********************************************************");
//
//  var a = EtDatetime.parse("2011-10-12 00:00:00");
//  print(a.runtimeType);
//  print("Parsed moment 1:= ${now1.moment}, Parsed Fixed:= ${now1.fixed}");
//  print("ToString 1 ${now1.toString()}");
//  print("ToJson 1 ${a.toJson()}");

//  print(a.day);
//  print("The date is ${a.dayGeez}");
//  print("The Month is ${a.monthGeez}");
//  var moonLanding = new DateTime.parse("1969, 7, 20, 20, 18, 04");

  /// TODO: Try to print all days of the month for a single year

/////////////////////////////////////////////////////////////////////
// Bahire Hasab (Abusakir) Implementation Examples
//  print("********************HAHIRE HASAB***********************");
  BahireHasab b = BahireHasab(year: 2011);
  print("Wengelawi:= ${b.getEvangelist(returnName: true)}");
  print("Wenber:= ${b.wenber}");
  print("Metkih:= ${b.metkih}");
  print("Abekte:= ${b.abekte}");
  print(
      "Meskerem 1:= ${b.getMeskeremOne(returnName: true)}-- ${b.getMeskeremOne()}");
//  print(
//      "*********************  Movable Feasts and Holidays   **********************");
//  print('Nenewe Tsom:= ${b.nenewe}');
//  print("Abiy Tsom:= ${b.getAbiyTsom()}");
  print("Getting single Beal's date:= ${b.getSingleBealOrTsom("ጰራቅሊጦስ")}");
  print("Bealat:= ${b.allAtswamat}");

  //////////////////////////////////////////////////////////////////////////////
//  print("//////////////////////  ETHIOPIAN CALENDAR  ///////////////////////");

//  EtDatetime dt = new EtDatetime(year: 2011, month: 13);
//  print("Year First Day:= ${dt.yearFirstDay}");
//  print("Year First Day:= ${dt.weekday}");
//  print("Year First Day:= ${dt.toString()}");

//  EtDatetime abc = EtDatetime.fromMillisecondsSinceEpoch(1585742246021);
//  print(abc.hour);
//  ETC et = new ETC(year: now.year, month: now.month);
//  ETC et = new ETC(year: 2000, month: 13);
//

//  for (var days in et.monthDays()) {
//    print("$days \n");
//  }
//  print("Days in the month ${now.month} of ${now.year}:= ${et.monthDays()}");
//  print("Days in the whole Year 2011:= ${et.yearDays()}");
//  print("Next Month:= ${et.nextMonth.monthDays()}");
//  print("Previous Month:= ${et.prevMonth.monthDays()}");
//  EtDatetime ec = EtDatetime.parse("2012-07-07 15:12:17.500");
//  print(ec.toString());
//  print(ec.dayGeez);
//  print("Next Year:= ${et.nextYear.monthDays()}");
//  print("Previous Year:= ${et.prevYear.monthDays()}");
//  print("TODAY:= ${ETC.today().monthName}");
//  var streamController = now.clock();
//  streamController.listen(print);
//      .where((i) => i % 1000 == 0)
//      .map((i) => new EtDatetime.fromMillisecondsSinceEpoch(i).second)
//      .listen(print);
//  EtDatetime ec = EtDatetime.parse("2012-07-23 08:57:26.021");
//  EtDatetime ec = EtDatetime(
//      year: 2012,
//      month: 7,
//      day: 7,
//      hour: 15,
//      minute: 12,
//      second: 17,
//      millisecond: 500);
//  print(ec.moment);
//  EtDatetime ex = EtDatetime.fromMillisecondsSinceEpoch(1585731446021);
//  print(ex.fixed);
//
//  print(ec.toString());
//  print("from MS:= ${ex.toString()}");

//  EtDatetime date = new EtDatetime(year: 2012);
//  print("Year First Day:= ${date.yearFirstDay}");
//  print("Year First Month First Day:= ${date.weekday}");
}
