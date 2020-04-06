///
part of abushakir;

/**
 * An instant in time, such as July 20, 1969, 8:18pm GMT.
 *
 * DateTimes can represent time values that are at a distance of at most
 * 100,000,000 days from epoch (1970-01-01): -271821-04-20 to 275760-09-13.
 *
 * Create a EtDatetime object by using one of the constructors
 * or by parsing a correctly formatted string,
 * which complies with a subset of ISO 8601.
 * Note that hours are specified between 0 and 23,
 * as in a 24-hour clock.
 * For example:
 *
 * ```
 * var now = new EtDatetime.now();
 * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");  // 8:18pm
 * ```
 *
 * An EtDatetime object is anchored either in the UTC time zone
 * or in the local time zone of the current computer
 * when the object is created.
 *
 * Once created, neither the value nor the time zone
 * of an EtDatetime object may be changed.
 *
 * You can use properties to get
 * the individual units of am EtDatetime object.
 *
 * ```
 * assert(berlinWallFell.month == 11);
 * assert(moonLanding.hour == 20);
 * ```
 *
 * For convenience and readability,
 * the EtDatetime class provides a constant for each day and month
 * name - for example, [august] and [friday].
 * You can use these constants to improve code readability:
 *
 * ```
 * assert(berlinWallFell.weekday == EtDatetime.thursday);
 * ```
 *
 * Day and month values begin at 1, and the week starts on Monday.
 * That is, the constants [january] and [monday] are both 1.
 *
 * ## Comparing EtDatetime objects
 *
 * The EtDatetime class contains several handy methods,
 * such as [isAfter], [isBefore], and [isAtSameMomentAs],
 * for comparing EtDatetime objects.
 *
 * ```
 * assert(berlinWallFell.isAfter(moonLanding) == true);
 * assert(berlinWallFell.isBefore(moonLanding) == false);
 * ```
 *
 * ## Using EtDatetime with Duration
 *
 * Use the [add] and [subtract] methods with a [Duration] object
 * to create a new EtDatetime object based on another.
 * For example, to find the date that is sixty days (24 * 60 hours) after today,
 * write:
 *
 * ```
 * var now = new EtDatetime.now();
 * var sixtyDaysFromNow = now.add(new Duration(days: 60));
 * ```
 *
 * To find out how much time is between two EtDatetime objects use
 * [difference], which returns a [Duration] object:
 *
 * ```
 * var difference = berlinWallFell.difference(moonLanding);
 * assert(difference.inDays == 7416);
 * ```
 *
 * The difference between two dates in different time zones
 * is just the number of nanoseconds between the two points in time.
 * It doesn't take calendar days into account.
 * That means that the difference between two midnights in local time may be
 * less than 24 hours times the number of days between them,
 * if there is a daylight saving change in between.
 * If the difference above is calculated using Australian local time, the
 * difference is 7415 days and 23 hours, which is only 7415 whole days as
 * reported by `inDays`.
 *
 * ## Other resources
 *
 * See [Duration] to represent a span of time.
 * See [Stopwatch] to measure timespans.
 *
 * The EtDatetime class does not provide internationalization.
 * To internationalize your code, use
 * the [intl](https://pub.dev/packages/intl) package.
 *
 */
class EtDatetime extends EDT {
  /**
   * A [millisecondsSinceEpoch] of this DateTime.
   */
  int moment;

  /**
   * Fixed date—elapsed days since the onset of Monday, January 1, 1 (Gregorian)
   */
  final int fixed;

  /**
   * Constructs an [EtDatetime] instance.
   *
   * For example,
   * to create a new EtDatetime object representing the 7th of September 2012,
   * 5:30pm
   *
   * ```
   * var dentistAppointment = new EtDatetime(year: 2012, month: 1, day: 7, hour: 17, minute: 30);
   * ```
   */
  EtDatetime(
      {@required int year,
      int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0})
      : fixed = _fixedFromEthiopic(year, month, day),
        moment = _dateToEpoch(year, month, day, hour, minute, second, millisecond) {
    if (fixed == null) throw ArgumentError();
  }

  /**
   * Constructs an [EtDatetime] instance with current date and time.
   *
   * ```
   * var thisInstant = new EtDatetime.now();
   * ```
   */
  EtDatetime.now()
      : fixed = _fixedFromUnix(DateTime.now().millisecondsSinceEpoch),
        moment = DateTime.now().millisecondsSinceEpoch;

  /**
   * Constructs an [EtDatetime] instance
   * with the given [millisecondsSinceEpoch].
   *
   * ```
   * var thisInstant = new EtDatetime.fromMillisecondsSinceEpoch(1585742246021);
   * ```
   */
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
  /**
   * Constructs a new [EtDatetime] instance based on [formattedString].
   *
   * The [formattedString] must not be `null`.
   * Throws a [FormatException] if the input string cannot be parsed.
   *
   * The function parses a subset of ISO 8601
   * which includes the subset accepted by RFC 3339.
   *
   * The accepted inputs are currently:
   *
   * * A date: A signed four-to-six digit year, two digit month and
   *   two digit day, optionally separated by `-` characters.
   *   Examples: "19700101", "-0004-12-24", "81030-04-01".
   * * An optional time part, separated from the date by either `T` or a space.
   *   The time part is a two digit hour,
   *   then optionally a two digit minutes value,
   *   then optionally a two digit seconds value, and
   *   then optionally a '.' or ',' followed by at least a one digit
   *   second fraction.
   *   The minutes and seconds may be separated from the previous parts by a
   *   ':'.
   *   Examples: "12", "12:30:24.124", "12:30:24,124", "123010.50".
   *
   * Examples of accepted strings:
   *
   * * `"2012-02-27 13:27:00"`
   * * `"2012-02-27 13:27:00.123456789z"`
   * * `"2012-02-27 13:27:00,123456789z"`
   * * `"20120227 13:27:00"`
   * * `"20120227T132700"`
   * * `"20120227"`
   * * `"+20120227"`
   * * `"2012-02-27T14Z"`
   * * `"2012-02-27T14+00:00"`
   * * `"-123450101 00:00:00 Z"`: in the year -12345.
   * * `"2002-02-27T14:00:00-0500"`: Same as `"2002-02-27T19:00:00Z"`
   */
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
      int millisecond = milliAndMicroseconds ~/ Duration.microsecondsPerMillisecond;
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
      int value = _dateToEpoch(years, month, day, hour, minute, second, millisecond);
      int fixedValue = _fixedFromEthiopic(years, month, day);
      if (value == null) {
        throw FormatException("Time out of range", formattedString);
      }
      return EtDatetime._withValue(value, fixedValue);
    } else {
      throw FormatException("Invalid date format", formattedString);
    }
  }

  /**
   * Constructs a new [EtDatetime] instance based on [formattedString].
   *
   * Works like [parse] except that this function returns `null`
   * where [parse] would throw a [FormatException].
   */
  static EtDatetime tryParse(String formattedString) {
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  /**
   * The year.
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.year == 1969);
   * ```
   */
  int get year => ((4 * (fixed - ethiopicEpoch) + 1463) ~/ 1461);

  /**
   * The month [1..12].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.month == 7);
   * assert(moonLanding.month == EtDatetime.july);
   * ```
   */
  int get month => (((fixed - _fixedFromEthiopic(year, 1, 1)) ~/ 30) + 1);

  String get monthGeez => _months[(month - 1) % 13];

  /**
   * The day of the month [1..31].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.day == 20);
   * ```
   */
  int get day => fixed + 1 - _fixedFromEthiopic(year, month, 1);

  /**
   * The day of the month in Ge'ez ['፩'..'፴'].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.dayGeez == '፳');
   * ```
   */
  String get dayGeez => _dayNumbers[(day - 1) % 30];

  Map<String, int> get date => {"year": year, "month": month, "day": day};

  Map<String, int> get time => {"h": hour, "m": minute, "s": second};

/**
   * The hour of the day, expressed as in a 24-hour clock [0..23].
   *
   * ```
   * var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.hour == 20);
   * ```
   */
  int get hour => (moment ~/ hourMilliSec) % 24;

/**
   * The minute [0...59].
   *
   * ```
   * var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.minute == 18);
   * ```
   */
  int get minute => (moment ~/ minMilliSec) % 60;

/**
   * The second [0...59].
   *
   * ```
   * var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.second == 4);
   * ```
   */
  int get second => (moment ~/ secMilliSec) % 60;

/**
   * The millisecond [0...999].
   *
   * ```
   * var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.millisecond == 0);
   * ```
   */
  int get millisecond => moment % 1000;

  int get yearFirstDay => _yearFirstDay();

  /*
   * Returns the first day of the month
   */
  int get weekday => (yearFirstDay + ((month - 1) * 2)) % 7;

  /*
   * Returns true if [this._year] is leap year or
   * returns false.
  */
  bool get isLeap => year % 4 == 3;

  /*
   * Returns the first day of the year
   */
  int _yearFirstDay() {
    int ameteAlem = _ameteFida + year;
    int rabeet = ameteAlem ~/ 4;
    return (ameteAlem + rabeet) % 7;
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

  /// Converts the given broken down date to [millisecondsSinceEpoch].
  static int _dateToEpoch(
      int year, int month, int date, int hour, int minute, int second, int millisecond) {
    return ((_fixedFromEthiopic(year, month, date) - unixEpoch) * dayMilliSec) +
        (hour * hourMilliSec) +
        (minute * minMilliSec) +
        (second * secMilliSec) +
        millisecond;
  }

  static int _fixedFromUnix(int ms) => (unixEpoch + (ms ~/ 86400000));

  static int _fixedFromEthiopic(int year, int month, int day) {
    return (ethiopicEpoch - 1 + 365 * (year - 1) + (year ~/ 4) + 30 * (month - 1) + day);
  }

/**
   * Constructs a new [EtDatetime] instance with the given values.
   *
   */
  EtDatetime._withValue(this.moment, this.fixed) {
    if (DateTime.now().millisecondsSinceEpoch.abs() > _maxMillisecondsSinceEpoch ||
        (DateTime.now().millisecondsSinceEpoch.abs() == _maxMillisecondsSinceEpoch)) {
      throw ArgumentError(
          "Calendar is outside valid range: ${DateTime.now().millisecondsSinceEpoch}");
    }
  }

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

  /**
   * Returns an ISO-8601 full-precision extended format representation.
   *
   * The format is `yyyy-MM-ddTHH:mm:ss.mmm`
   * where:
   *
   * * `yyyy` is a, possibly negative, four digit representation of the year,
   *   if the year is in the range -9999 to 9999,
   *   otherwise it is a signed six digit representation of the year.
   * * `MM` is the month in the range 01 to 12,
   * * `dd` is the day of the month in the range 01 to 31,
   * * `HH` are hours in the range 00 to 23,
   * * `mm` are minutes in the range 00 to 59,
   * * `ss` are seconds in the range 00 to 59 (no leap seconds),
   * * `mmm` are milliseconds in the range 000 to 999, and
   *
   * The resulting string can be parsed back using [parse].
   */
  String toIso8601String() {
    String y = (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    String m = _twoDigits(month);
    String d = _twoDigits(day);
    String h = _twoDigits(hour);
    String min = _twoDigits(minute);
    String sec = _twoDigits(second);
    String ms = _threeDigits(millisecond);
    return "$y-$m-${d}T$h:$min:$sec.$ms";
  }

  static final RegExp _parseFormat = RegExp(r'^([+-]?\d{4,6})-?(\d\d)-?(\d\d)' // Day part.
      r'(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?$' // Time part.
      r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$');

  /**
   * Returns a [Duration] with the difference between [this] and [other].
   *
   * ```
   * var berlinWallFell = new EtDatetime(1989, EtDatetime.november, 9);
   * var dDay = new EtDatetime(1944, EtDatetime.june, 6);
   *
   * Duration difference = berlinWallFell.difference(dDay);
   * assert(difference.inDays == 16592);
   * ```
   *
   * The difference is measured in seconds and fractions of seconds.
   * The difference above counts the number of fractional seconds between
   * midnight at the beginning of those dates.
   *
   * ```
   * var berlinWallFell = new EtDatetime(1989, EtDatetime.november, 9);
   * var dDay = new EtDatetime(1944, EtDatetime.june, 6);
   * Duration difference = berlinWallFell.difference(dDay);
   * assert(difference.inDays == 16592);
   * ```
   * will fail because the difference is actually 16591 days and 23 hours, and
   * [Duration.inDays] only returns the number of whole days.
   */
  Duration difference(EtDatetime date) => Duration(days: (moment - date.moment).toInt());

  /**
   * Returns a new [EtDatetime] instance with [duration] added to [this].
   *
   * ```
   * var today = new EtDatetime.now();
   * var fiftyDaysFromNow = today.add(new Duration(days: 50));
   * ```
   *
   * Notice that the duration being added is actually 50 * 24 * 60 * 60
   * seconds. If the resulting `EtDatetime` has a different daylight saving offset
   * than `this`, then the result won't have the same time-of-day as `this`, and
   * may not even hit the calendar date 50 days later.
   *
   * Be careful when working with dates in local time.
   */
  EtDatetime add(Duration duration) {
    return EtDatetime.fromMillisecondsSinceEpoch(moment + duration.inMilliseconds);
  }

/**
   * Returns a new [EtDatetime] instance with [duration] subtracted from [this].
   *
   * ```
   * EtDatetime today = new EtDatetime.now();
   * EtDatetime fiftyDaysAgo = today.subtract(new Duration(days: 50));
   * ```
   *
   * Notice that the duration being subtracted is actually 50 * 24 * 60 * 60
   * seconds. If the resulting `EtDatetime` has a different daylight saving offset
   * than `this`, then the result won't have the same time-of-day as `this`, and
   * may not even hit the calendar date 50 days earlier.
   *
   * Be careful when working with dates in local time.
   */
  EtDatetime subtract(Duration duration) {
    return EtDatetime.fromMillisecondsSinceEpoch(moment - duration.inMilliseconds);
  }

/**
   * Returns true if [this] occurs before [other].
   *
   * ```
   * var now = new EtDatetime.now();
   * var earlier = now.subtract(const Duration(seconds: 5));
   * assert(earlier.isBefore(now));
   * assert(!now.isBefore(now));
   * ```
   */
  bool isBefore(EtDatetime other) => fixed < other.fixed && moment < other.moment;

  /**
   * Returns true if [this] occurs after [other].
   *
   * ```
   * var now = new EtDatetime.now();
   * var later = now.add(const Duration(seconds: 5));
   * assert(later.isAfter(now));
   * assert(!now.isBefore(now));
   * ```
   */
  bool isAfter(EtDatetime other) => fixed > other.fixed && moment > other.moment;

/**
   * Returns true if [this] occurs at the same moment as [other].
   *
   * ```
   * var now = new EtDatetime.now();
   * var later = now.add(const Duration(seconds: 5));
   * assert(!later.isAtSameMomentAs(now));
   * assert(now.isAtSameMomentAs(now));
   * ```
   */
  bool isAtSameMomentAs(EtDatetime other) => fixed == other.fixed && moment == other.moment;

/**
   * Compares this EtDatetime object to [other],
   * returning zero if the values are equal.
   *
   * Returns a negative value if this EtDatetime [isBefore] [other]. It returns 0
   * if it [isAtSameMomentAs] [other], and returns a positive value otherwise
   * (when this [isAfter] [other]).
   */
  int compareTo(EtDatetime other) {
    if (this.isBefore(other))
      return -1;
    else if (this.isAtSameMomentAs(other))
      return 0;
    else
      return 1;
  }

  Stream<int> clock() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }

  // OVERRIDES
  @override
  List<Object> get props => null;

  @override
  bool get stringify => true;
}
