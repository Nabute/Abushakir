// Copyright 2020 GC (2012 ETC) Nabute and Nahom. All rights reserved.
// Use of this source code is governed by MIT license, which can be found
// in the LICENSE file.

part of abushakir;

///
/// The Ethiopian calendar is one of the the calendars which uses the solar
/// system to reckon years, months and days, even time. Ethiopian single year
/// consists of 365.25 days which will be 366 days with in 4 years period which
/// causes the leap year. Ethiopian calendar has 13  months from which 12 months
/// are full 30 days each and the 13th month will be 5 days or 6 days during
/// leap year.
///
///
/// Create [ETC] object instances which are days of certain month in a certain
/// year, using one of the constructors.
///
/// ```
/// ETC etc = ETC(year: 2012, month: 7, day: 4);
/// ```
///
/// or
///
/// ```
/// ETC today = ETC.today();
/// ```
///
/// After creating instance of [ETC], you can navigate to the future or past
/// of the given date.
///
/// ```
/// ETC _nextMonth = today.nextMonth;
/// ETC _prevMonth = today.prevMonth;
/// ```
///
/// you can also get the same month of different year (the next year or
/// prev one)
///
/// ```
/// ETC _nextYear = today.nextYear;
/// ETC _prevYear = today.prevYear;
/// ```
///
/// All the available days within a single month can be found using
///
/// ```
/// var monthDaysIter = today.monthDays();
/// ```
///
/// or just all of the days available in the given year can also be found using
/// ```
/// var yearDaysIter = today.yearDays();
/// ```
///
///
class ETC implements Calendar {
  final EtDatetime _date;

  ///
  /// Construct an [ETC] instance.
  ///
  /// For example. to create a new [ETC] object representing the 1st of ጷጉሜን 2011,
  ///
  ///
  /// ```
  /// var etc = ETC(year: 2011, month: 13, day: 1);
  /// ```
  ///
  ///
  ///  Month and day are optional, if not provided ETC will assume the first
  ///  day of the first month of the given year.
  ///
  ///
  ETC({required int year, int month = 1, int day = 1})
      : _date = EtDatetime(year: year, month: month, day: day);

  ///
  /// Construct an [ETC] instance of the day the object is created.
  ///
  /// ```
  /// var today = ETC.today();
  /// ```
  ///

  ETC.today() : _date = EtDatetime.now();

  ///
  /// Getter property that return year of the current [ETC] instance.
  ///
  int get year => _date.year;

  ///
  /// Getter property that return month of the current [ETC] instance.
  ///
  int get month => _date.month;

  ///
  /// Getter property that return day of the current [ETC] instance.
  ///
  int get day => _date.day;

  ///
  /// All Month names  ["መስከረም", "ጥቅምት", ... ,"ጷጉሜን"]
  ///
  List get allMonths => _months;

  ///
  /// All Days number in Ge'ez ["፩", "፪", ... , "፴"]
  ///
  List get dayNumbers => _dayNumbers;

  ///
  /// All Day names ["ሰኞ", "ማግሰኞ", ... , "እሁድ"]
  ///
  List get weekdays => _weekdays;

  ///
  /// Getter property that return the month name for the current [ETC]
  /// instance.
  ///
  String? get monthName => _date.monthGeez;

  ///
  /// Returning [ETC] instance of same year with a month next to this.
  ///
  ETC get nextMonth => ETC(year: _date.year, month: _date.month + 1);

  ///
  /// Returning [ETC] instance of same year with a month previous to this.
  ///
  ETC get prevMonth => ETC(
      year: _date.month == 1 ? _date.year - 1 : _date.year,
      month: _date.month - 1 == 0 ? 13 : _date.month - 1);

  ///
  /// Returning [ETC] instance of same month with a year next to this.
  ///
  ETC get nextYear => ETC(year: _date.year + 1, month: _date.month);

  ///
  /// Returning [ETC] instance of same month with a year previous to this.
  ///
  ETC get prevYear => ETC(year: _date.year - 1, month: _date.month);

  ///
  /// Returns month range and monthStartDay as an array.
  ///
  List<int> _monthRange() {
    if (_date.month <= 1 && _date.month >= 13) throw MonthNumberException;
    return [_date.weekday, _date.month == 13 ? _date.isLeap ? 6 : 5 : 30];
  }

  ///
  /// Returns [Iterable] object of [List] which looks like:
  ///
  /// ```
  /// [year, month, day, weekday]
  /// ```
  ///
  /// Where: all are integer values representing [year], [month], [day] and
  /// weekday respectively. The weekday can be returned in day name or just
  /// index of the day, assuming ሰኞ as the first day of the week with index of 0.
  ///
  /// ```
  /// // const List<String> _weekdays = ["ሰኞ", "ማግሰኞ", "ረቡዕ", "ሐሙስ", "አርብ", "ቅዳሜ", "እሁድ"];
  ///
  /// etc.monthDays(weekDayName: true); // => [2011, 13, 1, አርብ]
  ///
  /// ```
  ///
  /// The day number in Geez can also be returned by passing geezDay parameter.
  ///
  /// ```
  /// // Days of ጷጉሜን in 2011
  /// // ["፩", "፪", "፫", "፬", "፭", "፮"]
  /// // [2011, 13, ፮, ረቡዕ]
  ///
  /// etc.monthDays(geezDay: true, weekDayName: true); // => [2011, 13, ፮, ረቡዕ]
  ///
  /// ```
  ///
  Iterable<List<dynamic>> monthDays(
      {bool geezDay = false, bool weekDayName = false}) sync* {
    int monthBeginning = _monthRange()[0];
    int daysInMonth = _monthRange()[1];
    for (int i = 0; i < daysInMonth; i++) {
      if (geezDay) {
        yield [
          _date.year,
          _date.month,
          _dayNumbers[i],
          weekDayName ? _weekdays[monthBeginning] : monthBeginning
        ];
      } else
        yield [
          _date.year,
          _date.month,
          i + 1,
          weekDayName ? _weekdays[monthBeginning] : monthBeginning
        ];
      monthBeginning = (monthBeginning + 1) % 7;
    }
  }

  ///
  /// Similar method as monthDays but the difference is this one will take
  /// year and month as a parameter and then generate all available days of
  /// the given month of the year.
  ///
  /// This method is used by yearDays for generating all available days
  /// for the whole year.
  ///
  Iterable<List<dynamic>> _monthDays(int year, int month,
      {bool geezDay: false, bool weekDayName: false}) sync* {
    EtDatetime yr = EtDatetime(year: year, month: month);
    int monthBeginning = yr.weekday;
    int daysInMonth = yr.month == 13 ? yr.isLeap ? 6 : 5 : 30;
    for (int i = 0; i < daysInMonth; i++) {
      if (geezDay) {
        yield [
          year,
          month,
          _dayNumbers[i],
          weekDayName ? _weekdays[monthBeginning] : monthBeginning
        ];
      } else
        yield [
          year,
          month,
          i + 1,
          weekDayName ? _weekdays[monthBeginning] : monthBeginning
        ];
      monthBeginning = (monthBeginning + 1) % 7;
    }
  }

  ///
  /// Method that can be used to generate all the available days of the [year].
  ///
  /// The weekday can be returned in day name or just index of the day,
  /// assuming ሰኞ as the first day of the week with index of 0.
  ///
  /// ```
  /// // const List<String> _weekdays = ["ሰኞ", "ማግሰኞ", "ረቡዕ", "ሐሙስ", "አርብ", "ቅዳሜ", "እሁድ"];
  ///
  /// etc.yearDays(weekDayName: true); // => [2011, 13, 1, አርብ]
  ///
  /// ```
  ///
  /// The day number in Geez can also be returned by passing geezDay parameter.
  ///
  /// ```
  /// // Days of ጷጉሜን in 2011
  /// // ["፩", "፪", "፫", "፬", "፭", "፮"]
  /// // [2011, 13, ፮, ረቡዕ]
  ///
  /// etc.monthDays(geezDay: true, weekDayName: true); // => [2011, 13, ፮, ረቡዕ]
  ///
  /// ```
  ///
  ///

  Iterable<Iterable<List<dynamic>>> yearDays(
      {bool geezDay: false, bool weekDayName: false}) sync* {
    for (int i = 0; i < _months.length; i++) {
      yield _monthDays(_date.year, i + 1,
          geezDay: geezDay, weekDayName: weekDayName);
    }
  }

  @override
  List<Object> get props => [year, month, day];

  @override
  bool get stringify => true;
}
