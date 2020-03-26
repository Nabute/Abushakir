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

<<<<<<< HEAD
  EthiopianCalendar now = EthiopianCalendar.now();
  print("Year: ${now.year}");
  print("Month: ${now.month}");
  print("Date: ${now.day}");
  print("Hour: ${now.hour}");
  print("Seconds: ${now.second}");
  print("Minutes: ${now.minute}");
  print("MiliSeconds: ${now.millisecond}");
  print(now.toString());
  print(now.toJson());
  print(now.toIso8601String());
<<<<<<< Updated upstream
=======
  print("The Month is ${now.monthName}");
>>>>>>> Stashed changes
  var a = EthiopianCalendar.parse("1995-04-27 00:00:00");
  print("ToString ${a.toString()}");
  print("ToJson ${a.toJson()}");
  print("The date is ${a.date}");
  print("The Month is ${a.monthName}");
=======
//  EtDatetime now = EtDatetime.now();
//  EtDatetime now = EtDatetime.parse("2012-13-02 00:00:00");
//  print(EtDatetime.fromMillisecondsSinceEpoch(now.moment));
//  print("Year: ${now.year}");
//  print("Month: ${now.month}");
//  print("Date: ${now.day}");
//  print("Hour: ${now.hour}");
//  print("Seconds: ${now.second}");
//  print("Minutes: ${now.minute}");
//  print("MiliSeconds: ${now.millisecond}");
//  print(now.toString());
//  print(now.toJson());
//  print(now.toIso8601String());
//  print("The Month is ${now.monthGeez}");

  print("********************************************************");

  var b = EtDatetime.fromMillisecondsSinceEpoch(1568206800);
  print("Year: ${b.year}");
  print("Month: ${b.month}");
  print("Date: ${b.day}");
  print("Hour: ${b.hour}");
  print("Minutes: ${b.minute}");
  print("Seconds: ${b.second}");
  print("MiliSeconds: ${b.millisecond}");
  print(b.toString());
  print(b.toJson());
  print(b.toIso8601String());
  print("The Month is ${b.monthGeez}");

  print("********************************************************");


  var a = EtDatetime.parse("2011-10-12 00:00:00");
  print(a.runtimeType);
  print("ToString ${a.toString()}");
  print("ToJson ${a.toJson()}");
  print(a.day);
  print("The date is ${a.dayGeez}");
  print("The Month is ${a.monthGeez}");
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
//  var moonLanding = new DateTime.parse("1969, 7, 20, 20, 18, 04");

  /// TODO: Try to print all days of the month for a single year

/////////////////////////////////////////////////////////////////////
// Bahire Hasab (Abusakir) Implementation Examples
//  print("********************HAHIRE HASAB***********************");
//  BahireHasab b = BahireHasab();
//  print("Wengelawi:= ${b.getEvangelist(returnName: true)}");
//  print("Wenber:= ${b.getWenber()}");
//  print("Metkih:= ${b.getMetkih()}");
//  print("Abekte:= ${b.getAbekte()}");
//  print("Meskerem 1:= ${b.getMeskeremOne(returnName: true)}");
//  print("*********************  Movable Feasts and Holidays   **********************");
////  print('Nenewe Tsom:= ${b.getNenewe()}');
////  print("Abiy Tsom:= ${b.getAbiyTsom()}");
//  print("Getting single Beal's date:= ${b.getSingleBealOrTsom("ቅለት")}");
//  print("Bealat:= ${b.getAllAtswamat()}");
}
