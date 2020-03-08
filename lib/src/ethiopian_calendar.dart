//
//
//

import 'package:equatable/equatable.dart';

abstract class Calendar extends Equatable {
  @override
  List<Object> get props => [];
}

class EthiopianCalendar extends Calendar {

  DateTime moment;

  // Weekday constants that are returned by [weekday] method:
  static const Map<String, dynamic> monday = {"name": "ሰኞ", "value": 1};
  static const Map<String, dynamic> tuesday = {"name": "ማግሰኞ", "value": 2};
  static const Map<String, dynamic> wednesday = {"name": "ረቡዕ", "value": 3};
  static const Map<String, dynamic> thursday = {"name": "ሐሙስ", "value": 4};
  static const Map<String, dynamic> friday = {"name": "አርብ", "value": 5};
  static const Map<String, dynamic> saturday = {"name": "ቅዳሜ", "value": 6};
  static const Map<String, dynamic> sunday = {"name": "እሁድ", "value": 7};
  static const Map<String, dynamic> daysPerWeek = {
    "name": "ዐውደ እለት",
    "value": 7
  };

  // Month constants that are returned by the [month] getter.
  static const Map<String, dynamic> september = {'name': "መስከረም", "value": 1};
  static const Map<String, dynamic> october = {'name': "ጥቅምት", "value": 2};
  static const Map<String, dynamic> november = {'name': "ኅዳር", "value": 3};
  static const Map<String, dynamic> december = {'name': "ታኅሳስ", "value": 4};
  static const Map<String, dynamic> january = {'name': "ጥር", "value": 5};
  static const Map<String, dynamic> february = {'name': "የካቲት", "value": 6};
  static const Map<String, dynamic> march = {'name': "መጋቢት", "value": 7};
  static const Map<String, dynamic> april = {'name': "ሚያዝያ", "value": 8};
  static const Map<String, dynamic> may = {'name': "ግንቦት", "value": 9};
  static const Map<String, dynamic> june = {'name': "ሰኔ", "value": 10};
  static const Map<String, dynamic> july = {'name': "ኃምሌ", "value": 11};
  static const Map<String, dynamic> august = {'name': "ነሐሴ", "value": 12};
  static const Map<String, dynamic> puagume = {'name': "ጷጉሜን", "value": 13};
  static const Map<String, dynamic> monthsPerYear = {
    'name': "ዐውደ ወርህ",
    "value": 13
  };


  EthiopianCalendar(this.moment);

  static EthiopianCalendar now() {
    return parse(DateTime.now().toString());
  }

  static EthiopianCalendar parse(String dt){


  }







}
