// Copyright 2020 GC (2012 ETC) Nabute and Nahom. All rights reserved.
// Use of this source code is governed by MIT license, which can be found
// in the LICENSE file.

part of abushakir;

///
/// An instant in time, such as መጋቢት 20, 2012, 8:18pm.
///
/// EtDatetime can represent time values that are at a distance of at most
/// 100,000,000 days from epoch (1970-01-01): -271821-04-20 to 275760-09-13.
///
/// Create a EtDatetime object by using one of the constructors
/// or by parsing a correctly formatted string,
/// which complies with a subset of ISO 8601.
/// Note that hours are specified between 0 and 23,
/// as in a 24-hour clock.
/// For example:
///
/// ```
/// var now = new EtDatetime.now();
/// var covid19Confirmed = new EtDatetime(year: 2012, month: 7, day: 4);
/// var lockdownBegin = new EtDatetime.fromMillisecondsSinceEpoch(1586215439441);
/// ```
///
/// Once created, the value of an EtDatetime object may not be changed.
///
/// You can use properties to get
/// the individual units of an EtDatetime object.
///
/// ```
/// assert(covid19Confirmed.year == 2012);
/// assert(covid19Confirmed.month == 7);
/// assert(covid19Confirmed.day == 2);
/// ```
///
/// For convenience and readability,
/// the EtDatetime class provides a constant for each day and month
/// name - for example, መስከረም and ማግሰኞ.
/// You can use these constants to improve code readability:
///
///
/// Day and month indexes begin at 0, and the week starts on Monday (ሰኞ).
/// That is, the constants መስከረም and ሰኞ are both 1.
///
/// ## Comparing EtDatetime objects
///
/// The EtDatetime class contains several handy methods,
/// such as [isAfter], [isBefore], and [isAtSameMomentAs],
/// for comparing EtDatetime objects.
///
/// ```
/// assert(lockdownBegin.isAfter(covid19Confirmed) == true);
/// assert(covid19Confirmed.isBefore(lockdownBegin) == false);
/// ```
///
/// ## Using EtDatetime with Duration
///
/// Use the [add] and [subtract] methods with a [Duration] object
/// to create a new EtDatetime object based on another.
/// For example, to find the date that is sixty days (24 /// 60 hours) after today,
/// write:
///
/// ```
/// var now = new EtDatetime.now();
/// var sixtyDaysFromNow = now.add(new Duration(days: 60));
/// ```
///
/// To find out how much time is between two EtDatetime objects use
/// [difference], which returns a [Duration] object:
///
/// ```
/// var difference = covid19Confirmed.difference(lockdownBegin);
/// assert(difference.inDays == 24);
/// ```
/// ### NOTE
///
/// There is no UTC or TIme zone feature in this package since it's built only
/// for ethiopia.
///
///
/// ## Realtime Clock
///
/// The EtDatetime class provides realtime clock for Ethiopian with 6 hour
/// offset and can be integrated into flutter application. See sample
/// [flutter application](https://github.com/Nabute/ethiopian_calendar) made
/// for this purpose.
///
///
class EtDatetime extends EDT {
  ///
  /// Milliseconds since [UNIX Epoch](https://en.wikipedia.org/wiki/Unix_time)
  /// of this EtDatetime.
  ///
  final int moment;

  ///
  /// Fixed date—elapsed days since the onset of Monday, January 1, 1970
  /// (Gregorian)
  ///
  final int fixed;

  ///
  /// Constructs an [EtDatetime] instance.
  ///
  /// For example,
  /// to create a new EtDatetime object representing the 7th of መስከረም 2012,
  /// 5:30pm
  ///
  /// ```
  /// var covid19Confirmed = new EtDatetime(year: 2012, month: 1, day: 7, hour: 17, minute: 30);
  /// ```
  ///
  EtDatetime(
      {int year,
      int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0})
      : fixed = _fixedFromEthiopic(year, month, day),
        moment =
            _dateToEpoch(year, month, day, hour, minute, second, millisecond) {
    if (fixed == null) throw ArgumentError();
  }

  ///
  /// Constructs an [EtDatetime] instance with current date and time.
  ///
  /// ```
  /// var thisInstant = new EtDatetime.now();
  /// ```
  ///
  EtDatetime.now()
      : fixed = _fixedFromUnix(DateTime.now().millisecondsSinceEpoch),
        moment = DateTime.now().millisecondsSinceEpoch;

  ///
  /// Constructs an [EtDatetime] instance
  /// with the given [millisecondsSinceEpoch].
  ///
  /// ```
  /// var thisInstant = new EtDatetime.fromMillisecondsSinceEpoch(1585742246021);
  /// ```
  ///
  EtDatetime.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch)
      : moment = millisecondsSinceEpoch,
        fixed = _fixedFromUnix(millisecondsSinceEpoch) {
    if (fixed == null) throw ArgumentError();
    if (millisecondsSinceEpoch.abs() > _maxMillisecondsSinceEpoch ||
        (millisecondsSinceEpoch.abs() == _maxMillisecondsSinceEpoch)) {
      throw ArgumentError(
          "Calendar is outside valid range: ${DateTime.now().millisecondsSinceEpoch}");
    }
  }

  ///
  /// Constructs a new [EtDatetime] instance based on [formattedString].
  ///
  /// The [formattedString] must not be `null`.
  /// Throws a [FormatException] if the input string cannot be parsed.
  ///
  /// The function parses a subset of ISO 8601
  /// which includes the subset accepted by RFC 3339.
  ///
  /// The accepted inputs are currently:
  ///
  /// * A date: A signed four-to-six digit year, two digit month and
  ///   two digit day, optionally separated by `-` characters.
  ///   Examples: "19700101", "-0004-12-24", "81030-04-01".
  /// * An optional time part, separated from the date by either `T` or a space.
  ///   The time part is a two digit hour,
  ///   then optionally a two digit minutes value,
  ///   then optionally a two digit seconds value, and
  ///   then optionally a '.' or ',' followed by at least a one digit
  ///   second fraction.
  ///   The minutes and seconds may be separated from the previous parts by a
  ///   ':'.
  ///   Examples: "12", "12:30:24.124", "12:30:24,124", "123010.50".
  ///
  /// Examples of accepted strings:
  ///
  /// * `"2012-02-27 13:27:00"`
  /// * `"2012-02-27 13:27:00.123456789z"`
  /// * `"2012-02-27 13:27:00,123456789z"`
  /// * `"20120227 13:27:00"`
  /// * `"20120227T132700"`
  /// * `"20120227"`
  /// * `"+20120227"`
  /// * `"2012-02-27T14Z"`
  /// * `"2012-02-27T14+00:00"`
  /// * `"-123450101 00:00:00 Z"`: in the year -12345.
  /// * `"2002-02-27T14:00:00-0500"`: Same as `"2002-02-27T19:00:00Z"`
  ///
  static EtDatetime parse(String formattedString) {
    var re = _parseFormat;
    Match match = re.firstMatch(formattedString);
    if (match != null) {
      int parseIntOrZero(String matched) {
        if (matched == null) return 0;
        return int.parse(matched);
      }

      int parseMilliAndMicroseconds(String matched) {
        if (matched == null) return 0;
        int length = matched.length;
        assert(length >= 1);
        int result = 0;
        for (int i = 0; i < 6; i++) {
          result *= 10;
          if (i < matched.length) {
            result += matched.codeUnitAt(i) ^ 0x30;
          }
        }
        return result;
      }

      int years = int.parse(match[1]);
      int month = int.parse(match[2]);
      int day = int.parse(match[3]);
      int hour = parseIntOrZero(match[4]);
      int minute = parseIntOrZero(match[5]);
      int second = parseIntOrZero(match[6]);
      int milliAndMicroseconds = parseMilliAndMicroseconds(match[7]);
      int millisecond =
          milliAndMicroseconds ~/ Duration.microsecondsPerMillisecond;
      if (match[8] != null) {
        // timezone part
        if (match[9] != null) {
          // timezone other than 'Z' and 'z'.
          int sign = (match[9] == '-') ? -1 : 1;
          int hourDifference = int.parse(match[10]);
          int minuteDifference = parseIntOrZero(match[11]);
          minuteDifference += 60 * hourDifference;
          minute -= sign * minuteDifference;
        }
      }
      int value =
          _dateToEpoch(years, month, day, hour, minute, second, millisecond);
      int fixedValue = _fixedFromEthiopic(years, month, day);
      if (value == null) {
        throw FormatException("Time out of range", formattedString);
      }
      return EtDatetime._withValue(value, fixedValue);
    } else {
      throw FormatException("Invalid date format", formattedString);
    }
  }

  ///
  /// Constructs a new [EtDatetime] instance based on [formattedString].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  ///
  static EtDatetime tryParse(String formattedString) {
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  ///
  /// The year.
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.year == 2012);
  /// ```
  ///
  int get year => ((4 * (fixed - _ethiopicEpoch) + 1463) ~/ 1461);

  ///
  /// The month [1..13].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(moonLanding.month == 7);
  /// ```
  ///
  int get month => (((fixed - _fixedFromEthiopic(year, 1, 1)) ~/ 30) + 1);

  ///
  /// The month name for the current [EtDatetime] instance.
  ///
  String get monthGeez => _months[(month - 1) % 13];

  ///
  /// The day of the month [1..30].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.day == 4);
  /// ```
  ///
  int get day => fixed + 1 - _fixedFromEthiopic(year, month, 1);

  ///
  /// The day of the month in Ge'ez ['፩'..'፴'].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.dayGeez == '፬');
  /// ```
  ///
  String get dayGeez => _dayNumbers[(day - 1) % 30];

  ///
  /// The Date
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// var date = covid19Confirmed.date;
  /// assert(date['year'] == 2012);
  /// ```
  ///
  Map<String, int> get date => {"year": year, "month": month, "day": day};

  ///
  /// The Time
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// var time = covid19Confirmed.time;
  /// assert(time['hour'] == 13);
  /// ```
  ///
  Map<String, int> get time => {"h": hour, "m": minute, "s": second};

  ///
  /// The hour of the day, expressed as in a 24-hour clock [0..23].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.hour == 13);
  /// ```
  ///
  int get hour => (moment ~/ hourMilliSec) % 24;

  ///
  /// The minute [0...59].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.minute == 18);
  /// ```
  ///
  int get minute => (moment ~/ minMilliSec) % 60;

  ///
  /// The second [0...59].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.second == 4);
  /// ```
  ///
  int get second => (moment ~/ secMilliSec) % 60;

  ///
  /// The millisecond [0...999].
  ///
  /// ```
  /// var covid19Confirmed = EtDatetime.parse("2012-07-04 13:18:04Z");
  /// assert(covid19Confirmed.millisecond == 0);
  /// ```
  ///
  int get millisecond => moment % 1000;

  ///
  /// First day of the Year
  ///
  /// ```
  /// var lastYear = EtDatetime(year: 2011);
  /// assert(lastYear.yearFirstDay == 1); // ማግሰኞ
  /// ```
  ///
  int get yearFirstDay => _yearFirstDay();

  ///
  /// First Day of the Month
  ///
  /// ```
  /// var twoMonthAgo = EtDatetime(year:2012, month: 4);
  /// assert(twoMonthAgo.weekday == 0) // ሰኞ
  /// ```
  ///
  int get weekday => (yearFirstDay + ((month - 1) * 2)) % 7;

  ///
  /// Returns true if [year] is leap year or
  /// returns false.
  ///
  bool get isLeap => year % 4 == 3;

  ///
  /// Returns the first day of the year
  ///
  int _yearFirstDay() {
    int ameteAlem = _ameteFida + year;
    int rabeet = ameteAlem ~/ 4;
    return (ameteAlem + rabeet) % 7;
  }

  ///
  /// Constructs a new [EtDatetime] instance with the given values.
  ///
  ///
  EtDatetime._withValue(this.moment, this.fixed) {
    if (DateTime.now().millisecondsSinceEpoch.abs() >
            _maxMillisecondsSinceEpoch ||
        (DateTime.now().millisecondsSinceEpoch.abs() ==
            _maxMillisecondsSinceEpoch)) {
      throw ArgumentError(
          "Calendar is outside valid range: ${DateTime.now().millisecondsSinceEpoch}");
    }
  }

  ///
  /// Converts the given broken down date to [millisecondsSinceEpoch].
  ///
  /// ```
  /// var someTime = _dateToEpoch(2012, 7, 29, 0, 15, 48, 118);
  /// assert(someTime == 1586218548118);
  /// ```
  ///
  static int _dateToEpoch(int year, int month, int date, int hour, int minute,
      int second, int millisecond) {
    return ((_fixedFromEthiopic(year, month, date) - _unixEpoch) *
            dayMilliSec) +
        (hour * hourMilliSec) +
        (minute * minMilliSec) +
        (second * secMilliSec) +
        millisecond;
  }

  ///
  /// Returns [fixed] date from Unix [millisecond] count.
  ///
  static int _fixedFromUnix(int ms) => (_unixEpoch + (ms ~/ 86400000));

  ///
  /// Converts an ethiopic date to [fixed] date by adding the days elapsed to the last day before the
  /// [_ethiopicEpoch].
  ///
  static int _fixedFromEthiopic(int year, int month, int day) {
    return (_ethiopicEpoch -
        1 +
        365 * (year - 1) +
        (year ~/ 4) +
        30 * (month - 1) +
        day);
  }

  ///
  /// Returns a human-readable string for this instance.
  ///
  /// The resulting string can be parsed back using [parse].
  ///
  ///
  String toString() {
    String y = _fourDigits(year);
    String m = _twoDigits(month);
    String d = _twoDigits(day);
    String h = _twoDigits(hour);
    String min = _twoDigits(minute);
    String sec = _twoDigits(second);
    String ms = _threeDigits(millisecond);
    return "$y-$m-$d $h:$min:$sec.$ms";
  }

  ///
  /// Returns a JSON serialization for this instance.
  ///
  String toJson() {
    return json.encode({
      "year": _fourDigits(year),
      "month": _twoDigits(month),
      "date": _twoDigits(day),
      "hour": _twoDigits(hour),
      "min": _twoDigits(minute),
      "sec": _twoDigits(second),
      "ms": _threeDigits(millisecond),
    });
  }

  ///
  /// Returns an ISO-8601 full-precision extended format representation.
  ///
  /// The format is `yyyy-MM-ddTHH:mm:ss.mmm`
  /// where:
  ///
  /// * `yyyy` is a, possibly negative, four digit representation of the year,
  ///   if the year is in the range -9999 to 9999,
  ///   otherwise it is a signed six digit representation of the year.
  /// * `MM` is the month in the range 01 to 12,
  /// * `dd` is the day of the month in the range 01 to 31,
  /// * `HH` are hours in the range 00 to 23,
  /// * `mm` are minutes in the range 00 to 59,
  /// * `ss` are seconds in the range 00 to 59 (no leap seconds),
  /// * `mmm` are milliseconds in the range 000 to 999, and
  ///
  /// The resulting string can be parsed back using [parse].
  ///
  String toIso8601String() {
    String y =
        (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    String m = _twoDigits(month);
    String d = _twoDigits(day);
    String h = _twoDigits(hour);
    String min = _twoDigits(minute);
    String sec = _twoDigits(second);
    String ms = _threeDigits(millisecond);
    return "$y-$m-${d}T$h:$min:$sec.$ms";
  }

  ///
  /// Returns a [Duration] with the difference between this and other.
  ///
  /// ```
  /// var berlinWallFell = new EtDatetime(1989, EtDatetime.november, 9);
  /// var dDay = new EtDatetime(1944, EtDatetime.june, 6);
  ///
  /// Duration difference = berlinWallFell.difference(dDay);
  /// assert(difference.inDays == 16592);
  /// ```
  ///
  /// The difference is measured in seconds and fractions of seconds.
  /// The difference above counts the number of fractional seconds between
  /// midnight at the beginning of those dates.
  ///
  /// ```
  /// var berlinWallFell = new EtDatetime(1989, EtDatetime.november, 9);
  /// var dDay = new EtDatetime(1944, EtDatetime.june, 6);
  /// Duration difference = berlinWallFell.difference(dDay);
  /// assert(difference.inDays == 16592);
  /// ```
  /// will fail because the difference is actually 16591 days and 23 hours, and
  /// [Duration.inDays] only returns the number of whole days.
  ///
  Duration difference(EtDatetime date) =>
      Duration(days: (fixed - date.fixed).toInt());

  ///
  /// Returns a new [EtDatetime] instance with [duration] added to current instance.
  ///
  /// ```
  /// var today = new EtDatetime.now();
  /// var fiftyDaysFromNow = today.add(new Duration(days: 50));
  /// ```
  ///
  /// Notice that the duration being added is actually 50 * 24 * 60 * 60
  /// seconds. If the resulting `EtDatetime` has a different daylight saving offset
  /// than `this`, then the result won't have the same time-of-day as `this`, and
  /// may not even hit the calendar date 50 days later.
  ///
  /// Be careful when working with dates in local time.
  ///
  EtDatetime add(Duration duration) {
    return EtDatetime.fromMillisecondsSinceEpoch(
        moment + duration.inMilliseconds);
  }

  ///
  /// Returns a new [EtDatetime] instance with [duration] subtracted from current instance.
  ///
  /// ```
  /// EtDatetime today = new EtDatetime.now();
  /// EtDatetime fiftyDaysAgo = today.subtract(new Duration(days: 50));
  /// ```
  ///
  /// Notice that the duration being subtracted is actually 50 * 24 * 60 * 60
  /// seconds. If the resulting `EtDatetime` has a different daylight saving offset
  /// than `this`, then the result won't have the same time-of-day as `this`, and
  /// may not even hit the calendar date 50 days earlier.
  ///
  /// Be careful when working with dates in local time.
  ///
  EtDatetime subtract(Duration duration) {
    return EtDatetime.fromMillisecondsSinceEpoch(
        moment - duration.inMilliseconds);
  }

  ///
  /// Returns true if current instance occurs before the [other].
  ///
  /// ```
  /// var now = new EtDatetime.now();
  /// var earlier = now.subtract(const Duration(seconds: 5));
  /// assert(earlier.isBefore(now));
  /// assert(!now.isBefore(now));
  /// ```
  ///
  bool isBefore(EtDatetime other) =>
      fixed < other.fixed && moment < other.moment;

  ///
  /// Returns true if current instance occurs after [other].
  ///
  /// ```
  /// var now = new EtDatetime.now();
  /// var later = now.add(const Duration(seconds: 5));
  /// assert(later.isAfter(now));
  /// assert(!now.isBefore(now));
  /// ```
  ///
  bool isAfter(EtDatetime other) =>
      fixed > other.fixed && moment > other.moment;

  ///
  /// Returns true if current instance occurs at the same moment as [other].
  ///
  /// ```
  /// var now = new EtDatetime.now();
  /// var later = now.add(const Duration(seconds: 5));
  /// assert(!later.isAtSameMomentAs(now));
  /// assert(now.isAtSameMomentAs(now));
  /// ```
  ///
  bool isAtSameMomentAs(EtDatetime other) =>
      fixed == other.fixed && moment == other.moment;

  ///
  /// Compares this EtDatetime object to [other],
  /// returning zero if the values are equal.
  ///
  /// Returns a negative value if this EtDatetime [isBefore] [other]. It returns 0
  /// if it [isAtSameMomentAs] [other], and returns a positive value otherwise
  /// (when this [isAfter] [other]).
  ///
  int compareTo(EtDatetime other) {
    if (this.isBefore(other))
      return -1;
    else if (this.isAtSameMomentAs(other))
      return 0;
    else
      return 1;
  }

  ///
  /// Stream of [moment] delayed with 1 second.
  ///
  /// Can be used to create realtime clock or time counter.
  ///
  Stream<int> clock() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String _sixDigits(int n) {
    assert(n < -9999 || n > 9999);
    int absN = n.abs();
    String sign = n < 0 ? "-" : "+";
    if (absN >= 100000) return "$sign$absN";
    return "${sign}0$absN";
  }

  static String _threeDigits(int n) {
    if (n >= 100) return "$n";
    if (n >= 10) return "0$n";
    return "00$n";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  static final RegExp _parseFormat = RegExp(
      r'^([+-]?\d{4,6})-?(\d\d)-?(\d\d)' // Day part.
      r'(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?$' // Time part.
      r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$');

  @override
  List<Object> get props => null;

  @override
  bool get stringify => true;
}
