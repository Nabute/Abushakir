///
part of abushakir;

/**
 * An instant in time, such as July 20, 1969, 8:18pm GMT.
 *
 * DateTimes can represent time values that are at a distance of at most
 * 100,000,000 days from epoch (1970-01-01 UTC): -271821-04-20 to 275760-09-13.
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
   * 
   */
  int moment;
  /**
   * 
   */
  int fixed;

  /**
   * Constructs an [EtDatetime] instance specified in the local time zone.
   *
   * For example,
   * to create a new EtDatetime object representing the 7th of September 2017,
   * 5:30pm
   *
   * ```
   * var dentistAppointment = new EtDatetime(year: 2017, month: 9, day: 7, hour: 17, minute: 30);
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
   * Constructs a [EtDatetime] instance with current date and time in the
   * local time zone.
   *
   * ```
   * var thisInstant = new EtDatetime.now();
   * ```
   */
  EtDatetime.now()
      : fixed = _fixedFromUnix(DateTime.now().millisecondsSinceEpoch),
        moment = DateTime.now().millisecondsSinceEpoch;
  /**
   * Constructs a new [EtDatetime] instance
   * with the given [millisecondsSinceEpoch].
   *
   *
   * The constructed [EtDatetime] represents
   * 1970-01-01T00:00:00Z + [millisecondsSinceEpoch] ms in the given
   * time zone (local or UTC).
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
   * * An optional time-zone offset part,
   *   possibly separated from the previous by a space.
   *   The time zone is either 'z' or 'Z', or it is a signed two digit hour
   *   part and an optional two digit minute part. The sign must be either
   *   "+" or "-", and can not be omitted.
   *   The minutes may be separated from the hours by a ':'.
   *   Examples: "Z", "-10", "+01:30", "+1130".
   *
   * This includes the output of both [toString] and [toIso8601String], which
   * will be parsed back into a `EtDatetime` object with the same time as the
   * original.
   *
   * The result is always in either local time or UTC.
   * If a time zone offset other than UTC is specified,
   * the time is converted to the equivalent UTC time.
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
   * Constructs a new [EtDatetime] instance with the given value.
   *
   * If [isUtc] is false then the date is in the local time zone.
   */

  EtDatetime._withValue(this.moment, this.fixed) {
    if (DateTime.now().millisecondsSinceEpoch.abs() > _maxMillisecondsSinceEpoch ||
        (DateTime.now().millisecondsSinceEpoch.abs() == _maxMillisecondsSinceEpoch)) {
      throw ArgumentError(
          "Calendar is outside valid range: ${DateTime.now().millisecondsSinceEpoch}");
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

  String get dayGeez => _dayNumbers[(day - 1) % 30];

  Map<String, int> get date => {"year": year, "month": month, "day": day};

  Map<String, int> get time => {"h": hour, "m": minute, "s": second};
  /**
   * The hour of the day, expressed as in a 24-hour clock [0..23].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.hour == 20);
   * ```
   */
  int get hour {
    var yearRemainder = moment % yearMilliSec;
    var dateRemainder = yearRemainder % (dayMilliSec);
    return (dateRemainder ~/ hourMilliSec) % 24; // Since Ethiopia is GMT+3
  }

  /**
   * The minute [0...59].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.minute == 18);
   * ```
   */
  int get minute {
    var yearRemainder = moment % yearMilliSec;
    var dateRemainder = yearRemainder % (dayMilliSec);
    var hourRemainder = dateRemainder % hourMilliSec;
    return (hourRemainder ~/ minMilliSec) % 60;
  }

/**
   * The second [0...59].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.second == 4);
   * ```
   */
  int get second {
    var yearRemainder = moment % yearMilliSec;
    var dateRemainder = yearRemainder % (dayMilliSec);
    var hourRemainder = dateRemainder % hourMilliSec;
    var minuteRemainder = hourRemainder % minMilliSec;
    return (minuteRemainder ~/ secMilliSec) % 60;
  }

/**
   * The microsecond [0...999].
   *
   * ```
   * var moonLanding = EtDatetime.parse("1969-07-20 20:18:04Z");
   * assert(moonLanding.microsecond == 0);
   * ```
   */
  int get millisecond {
    var yearRemainder = moment % yearMilliSec;
    var dateRemainder = yearRemainder % (dayMilliSec);
    var hourRemainder = dateRemainder % hourMilliSec;
    var minuteRemainder = hourRemainder % minMilliSec;
    return minuteRemainder % secMilliSec;
  }

/*
   * Returns the first day of the year
   */
  int _yearFirstDay() {
    int ameteAlem = _ameteFida + year;
    int rabeet = ameteAlem ~/ 4;
    return (ameteAlem + rabeet) % 7;
  }

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

  /// Returns the time as value millisecond, or
  /// null if the values are out of range.
  static int _dateToEpoch(
      int year, int month, int date, int hour, int minute, int second, int millisecond) {
    return ((yearMilliSec * (year - 1)).abs() +
            (monthMilliSec * (month - 1)).abs() +
            (dayMilliSec * date).abs() +
            (hourMilliSec * (hour + 3)).abs() + // since ethiopia is GMT+3
            (millisecondsPerMinute * minute).abs() +
            (millisecondsPerSecond * second).abs() +
            millisecond.abs()) -
        (biginningEpoch * 1000);
  }

  static int _fixedFromUnix(int ms) => (unixEpoch + (ms ~/ 86400000));

  static int _fixedFromEthiopic(int year, int month, int day) {
    return (ethiopicEpoch - 1 + 365 * (year - 1) + (year ~/ 4) + 30 * (month - 1) + day);
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
   * The format is `yyyy-MM-ddTHH:mm:ss.mmmuuuZ` for UTC time, and
   * `yyyy-MM-ddTHH:mm:ss.mmmuuu` (no trailing "Z") for local/non-UTC time,
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
   * * `uuu` are microseconds in the range 001 to 999. If [microsecond] equals
   *   0, then this part is omitted.
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

  Duration difference(EtDatetime date) => Duration(days: (moment - date.moment).toInt());

  EtDatetime add(Duration duration) {
    return EtDatetime.fromMillisecondsSinceEpoch(moment + duration.inMilliseconds);
  }

  EtDatetime subtract(Duration duration) {
    return EtDatetime.fromMillisecondsSinceEpoch(moment - duration.inMilliseconds);
  }

  bool isBefore(EtDatetime other) => fixed < other.fixed && moment < other.moment;

  bool isAfter(EtDatetime other) => fixed > other.fixed && moment > other.moment;

  bool isAtSameMomentAs(EtDatetime other) => fixed == other.fixed && moment == other.moment;

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
