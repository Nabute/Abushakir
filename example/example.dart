// Copyright 2020 GC (2012 ETC) Nabute and Nahom. All rights reserved.
// Use of this source code is governed by MIT license, which can be found
// in the LICENSE file.

/// An Example of using the package to create and manipulate Ethiopian Date and
/// Time with the unique Calendar system which includes the way ethiopians
/// use to find movable feasts and holiday.

import 'package:abushakir/abushakir.dart';

void main() {
  /**
   * Ethiopian Datetime Module [EtDatetime]
   */
  EtDatetime now = new EtDatetime.now(); // => 2012-07-28 17:18:31.466
  print(now.date); // => {year: 2012, month: 7, day: 28}
  print(now.time); // => {h: 17, m: 18, s: 31}

  EtDatetime covidFirstConfirmed = new EtDatetime(year: 2012, month: 7, day: 4);
  EtDatetime covidFirstConfirmedEpoch =
      new EtDatetime.fromMillisecondsSinceEpoch(covidFirstConfirmed.moment);

  EtDatetime covidFirstDeath = EtDatetime.parse("2012-07-26 23:00:00");

  /// Comparison of two EtDatetime Instances
  Duration daysWithOutDeath = covidFirstConfirmed.difference(covidFirstDeath);

  assert(daysWithOutDeath.inDays == -22, true); // 22 days

  assert(covidFirstDeath.isAfter(covidFirstConfirmed), true);

  assert(covidFirstDeath.isBefore(now), true);

  assert(covidFirstConfirmed.isAtSameMomentAs(covidFirstConfirmedEpoch), true);

  /**
   * Ethiopian Calendar Module [ETC]
   */
  ETC ethiopianCalendar = new ETC(year: 2011, month: 13, day: 4);

  ///
  print(ethiopianCalendar.monthDays(
      geezDay: true, weekDayName: true)); // Iterable Object of the given month
  print(ethiopianCalendar.monthDays().toList()[0]); // => [2012, 7, 1, 1]
  // [year, month, dateNumber, dateNameIndex], Monday as First weekday

  print(ethiopianCalendar.nextMonth); // => ETC instance of nextMonth, same year
  print(ethiopianCalendar.prevYear); // => ETC instance of prevYear, same month

  /**
   * Bahire Hasab Module [BahireHasab]
   */
  BahireHasab bh = BahireHasab(year: 2011);
//  BahireHasab bh = BahireHasab(); // Get's the current year

  print(bh.getEvangelist(returnName: true)); // => ሉቃስ

  print(bh.getSingleBealOrTsom("ትንሳኤ")); // {month: ሚያዝያ, date: 20}

  bh.allAtswamat; // => List of All fasting and Movable holidays

  /**
   * Arabic or English number (1,2,3...) to Ethiopic or GE'EZ (፩, ፪, ፫...) number Converter
   */

  var input = [
    1,
    10,
    15,
    20,
    25,
    78,
    105,
    333,
    450,
    600,
    1000,
    1001,
    1010,
    1056,
    1200,
    2013,
    9999,
    10000
  ];

  for (var arabic in input) {
    print(ConvertToEthiopic(
        arabic)); // [፩, ፲, ፲፭, ፳, ፳፭, ፸፰, ፻፭, ፫፻፴፫, ፬፻፶, ፮፻, ፲፻, ፲፻፩, ፲፻፲, ፲፻፶፮, ፲፪፻, ፳፻፲፫, ፺፱፻፺፱, ፻፻]
  }

  /*
  Conversion from any calendar (in this case, Gregorian) into Ethiopian Calendar.
   */
  DateTime gregorian1 = new DateTime.now();
  EtDatetime ethiopian1 = new EtDatetime.fromMillisecondsSinceEpoch(
      gregorian1.millisecondsSinceEpoch);
  print(
      "*******************   Gregorian into Ethiopian   ***********************");
  print(
      "Gregorian := ${gregorian1.toString()} is equivalent to Ethiopian ${ethiopian1.toString()}");

  /*
   Conversion from Ethiopian Calendar into any calendar (in this case, Gregorian).
   */
  EtDatetime ethiopian = new EtDatetime.now();
  DateTime gregorian =
      new DateTime.fromMillisecondsSinceEpoch(ethiopian.moment);
  print("Ethiopian EPOCH := ${ethiopian.moment}");
  print("Gregorian EPOCH := ${gregorian.millisecondsSinceEpoch}");
  print(
      "*******************   Ethiopian into Gregorian   ***********************");
  print(
      "Ethiopian ${ethiopian.toString()} is equivalent to Gregorian := ${gregorian.toString()}");
}
