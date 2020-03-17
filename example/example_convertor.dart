import 'package:ethiopiancalendar/ethiopiancalendar.dart';

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

  EthiopianCalendar now = EthiopianCalendar.now();
  print("Year: ${now.getYear()}");
  print("Month: ${now.getMonth()}");
  print("Date: ${now.getDay()}");
  print("Hour: ${now.getHour()}");
  print("Seconds: ${now.getSecond()}");
  print("Minutes: ${now.getMinute()}");
  print("MiliSeconds: ${now.getMilliSecond()}");
  print(now.toString());
  print(now.toJson());
  print(now.toIso8601String());
  print("The Month is ${now.getMonthName()}");
  var a = EthiopianCalendar.parse("1995-04-27 00:00:00");
  print(a.runtimeType);
  print("ToString ${a.toString()}");
  print("ToJson ${a.toJson()}");
  print("The date is ${a.getDate()}");
  print("The Month is ${a.getMonthName()}");
//  var moonLanding = new DateTime.parse("1969, 7, 20, 20, 18, 04");

  /// TODO: Try to print all days of the month for a single year

/////////////////////////////////////////////////////////////////////
// Bahire Hasab (Abusakir) Implementation Examples
  print("********************HAHIRE HASAB***********************");
  BahireHasab b = BahireHasab();
  print("Wengelawi:= ${b.getEvangelist(returnName: true)}");
  print("Wenber:= ${b.getWenber()}");
  print("Metkih:= ${b.getMetkih()}");
  print("Abekte:= ${b.getAbekte()}");
  print("Meskerem 1:= ${b.getMeskeremOne(returnName: true)}");
  print("*********************  Movable Feasts and Holidays   **********************");
//  print('Nenewe Tsom:= ${b.getNenewe()}');
//  print("Abiy Tsom:= ${b.getAbiyTsom()}");
  print("Getting single Beal's date:= ${b.getSingleBealOrTsom("ቅለት")}");
  print("Bealat:= ${b.getAllAtswamat()}");
}
