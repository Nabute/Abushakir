import 'package:ethiopiancalendar/abushakir.dart';

void main() {
//  DateTime now = DateTime.parse("1969-07-20 20:18:04Z");

//  EthiopianCalendar(now);
//  var now = EthiopianCalendar.parse("1995-04-27 20:18:04Z");
//  var now = EthiopianCalendar.parse("1970-01-01 00:00:00"); // 1962-ታኅሳስ-23 unix epoch started
//  print(now);
//  print(DateTime.parse("1970-01-01 00:00:00"));
//  print(DateTime.now().day);
//  print(DateTime.now().millisecondsSinceEpoch);
////  var now = EthiopianCalendar.parse(DateTime.now().toString());
//  print("${now['year']}-${now['month']['name']}-${now['date']}");  // 1991-ታኅሳስ-8

//  EtDatetime now = EtDatetime.now();
  EtDatetime now = EtDatetime.parse("2011-13-06 02:15:22");
//  print(EtDatetime.fromMillisecondsSinceEpoch(now.moment));
  print("Year: ${now.year}");
  print("Month: ${now.month}");
  print("Day: ${now.day}");
  print("Hour: ${now.hour}");
  print("Minutes: ${now.minute}");
  print("Seconds: ${now.second}");
  print("MilliSeconds: ${now.millisecond}");
  print("To String: ${now.toString()}");
  print("To JSON: ${now.toJson()}");
  print("To ISO8601String Format: ${now.toIso8601String()}");
  print("The Month is ${now.monthGeez}");

//  EtDatetime dt = new EtDatetime(year: 2011, month: 1);
//  print("Year First Day:= ${dt.yearFirstDay}");
//  print("Year First Day:= ${dt.weekday}");
//  print("Year First Day:= ${dt.toString()}");

  print("**********************FROM EPOCH**********************************");

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
//  print("ToString ${a.toString()}");
//  print("ToJson ${a.toJson()}");
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
  print("Wenber:= ${b.getWenber()}");
  print("Metkih:= ${b.getMetkih()}");
  print("Abekte:= ${b.getAbekte()}");
  print(
      "Meskerem 1:= ${b.getMeskeremOne(returnName: true)}-- ${b.getMeskeremOne()}");
//  print(
//      "*********************  Movable Feasts and Holidays   **********************");
////  print('Nenewe Tsom:= ${b.getNenewe()}');
////  print("Abiy Tsom:= ${b.getAbiyTsom()}");
//  print("Getting single Beal's date:= ${b.getSingleBealOrTsom("ቅለት")}");
//  print("Bealat:= ${b.getAllAtswamat()}");

  //////////////////////////////////////////////////////////////////////////////
//  print("//////////////////////  ETHIOPIAN CALENDAR  ///////////////////////");

//  EtDatetime dt = new EtDatetime(year: 2011, month: 1);
//  print("Year First Day:= ${dt.yearFirstDay}");
//  print("Year First Day:= ${dt.weekday}");
//  print("Year First Day:= ${dt.toString()}");

//  EtDatetime abc = EtDatetime.fromMillisecondsSinceEpoch(1568211322);
  ETC et = new ETC(year: now.year, month: now.month);
//
  print("Days in the month ${now.month} of ${now.year}:= ${et.monthDays()}");
  print("Days in the whole Year 2011:= ${et.yearDays()}");
//  EtDatetime date = new EtDatetime(year: 2012);
//  print("Year First Day:= ${date.yearFirstDay}");
//  print("Year First Month First Day:= ${date.weekday}");
}
