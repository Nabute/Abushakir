/**
 * The Ethiopian calendar is one of the the calendars which uses the solar
 * system to reckon years, months and days, even time. Ethiopian single year
 * consists of 365.25 days which will be 366 days with in 4 years period which
 * causes the leap year. Ethiopian calendar has 13  months from which 12 months
 * are full 30 days each and the 13th month will be 5 days or 6 days during
 * leap year.
 *
 *
 * Create [ETC] object instances which are days of certain month in a certain
 * year, using one of the constructors.
 *
 * ```
 * ETC etc = new ETC(year: 2012, month: 7, day: 4);
 * ```
 *
 * or
 *
 * ```
 * ETC today = ETC.today();
 * ```
 *
 * After creating instance of [ETC], you can navigate to the future or past
 * of the given date.
 *
 * ```
 * ETC _nextMonth = today.nextMonth;
 * ETC _prevMonth = today.prevMonth;
 * ```
 *
 * you can also get the same month of different year (the next year or
 * prev one)
 *
 * ```
 * ETC _nextYear = today.nextYear;
 * ETC _prevYear = today.prevYear;
 * ```
 *
 * All the available days within a single month can be found using
 *
 * ```
 * var monthDaysIter = today.monthDays();
 * ```
 *
 * or just all of the days available in the given year can also be found using
 * ```
 * var yearDaysIter = today.yearDays();
 * ```
 *
 */
part of abushakir;

class ETC implements Calendar {
  EtDatetime _date;

  ETC({@required int year, int month = 1, int day = 1}) {
    _date = new EtDatetime(year: year, month: month, day: day);
  }

  ETC.today() {
    _date = new EtDatetime.now();
  }

  /**
   * Getter property that return year of the current [ETC] instance.
   */
  int get year => _date.year;

  /**
   * Getter property that return month of the current [ETC] instance.
   */
  int get month => _date.month;

  /**
   * Getter property that return day of the current [ETC] instance.
   */
  int get day => _date.day;

  /**
   * Getter property that return the month name for the current [ETC]
   * instance.
   */
  String get monthName => _date.monthGeez;

  /**
   * Returning [ETC] instance of same year with a month next to [this]
   */
  ETC get nextMonth => new ETC(year: _date.year, month: _date.month + 1);

  /**
   * Returning [ETC] instance of same year with a month previous to [this]
   */
  ETC get prevMonth => new ETC(
      year: _date.month == 1 ? _date.year - 1 : _date.year,
      month: _date.month - 1 == 0 ? 13 : _date.month - 1);

  /**
   * Returning [ETC] instance of same month with a year next to [this]
   */
  ETC get nextYear => new ETC(year: _date.year + 1, month: _date.month);

  /**
   * Returning [ETC] instance of same month with a year previous to [this]
   */
  ETC get prevYear => new ETC(year: _date.year - 1, month: _date.month);

  /**
   * Returns month range and monthStartDay as an array.
   */
  List<int> _monthRange() {
    if (_date.month <= 1 && _date.month >= 13) throw MonthNumberException;
    return [_date.weekday, _date.month == 13 ? _date.isLeap ? 6 : 5 : 30];
  }

  /**
   * Returns [Iterable] object of [List] which looks like:
   * ```
   * [year, month, day, weekday]
   * ```
   * Where: all are integer values representing [year], [month], [day] and
   * [weekday](_date.weekdays) respectively. The weekday value can be used to get the
   * name of the weekday using
   *
   * ```
   * const List<String> _weekdays = ["ሰኞ", "ማግሰኞ", "ረቡዕ", "ሐሙስ", "አርብ",
   * "ቅዳሜ", "እሁድ"];
   *
   * String dayName = _weekdays[weekday];
   * ```
   *
   * The month value can also be used to get the name like
   *
   * ```
   * const List<String> _months = ["መስከረም","ጥቅምት","ኅዳር","ታኅሳስ","ጥር",
   * "የካቲት","መጋቢት","ሚያዝያ","ግንቦት","ሰኔ","ኃምሌ","ነሐሴ","ጷጉሜን"];
   *
   * String monthName = _months[month];
   * ```
   */
  Iterable<List<int>> monthDays() sync* {
    int monthBeginning = _monthRange()[0];
    int daysInMonth = _monthRange()[1];
    for (int i = 0; i < daysInMonth; i++) {
      yield [_date.year, _date.month, i + 1, monthBeginning];
      monthBeginning = (monthBeginning + 1) % 7;
    }
  }

  /**
   * Similar method as [monthDays] but the difference is this one will take
   * year and month as a parameter and then generate all available days of
   * the given month of the year.
   *
   * This method is used by [yearDays] for generating all available days
   * for the whole year.
   */
  Iterable<List<int>> _monthDays(int year, int month) sync* {
    EtDatetime yr = new EtDatetime(year: year, month: month);
    int monthBeginning = yr.weekday;
    int daysInMonth = yr.month == 13 ? yr.isLeap ? 6 : 5 : 30;
    for (int i = 0; i < daysInMonth; i++) {
      yield [year, month, i + 1, monthBeginning];
      monthBeginning = (monthBeginning + 1) % 7;
    }
  }

  /**
   * Method that can be used to generate all the available days of the [year].
   */

  Iterable<Iterable<List<int>>> yearDays() sync* {
    for (int i = 0; i < _months.length; i++) {
      yield _monthDays(_date.year, i + 1);
    }
  }

  @override
  List<Object> get props => [year, month, day];

  @override
  bool get stringify => true;
}
