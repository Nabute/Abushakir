///
part of ethiopiancalendar;

<<<<<<< HEAD

class EthiopianCalendar extends Calendar {
=======
class EtDatetime extends EDT {
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
  @override
  List<Object> get props => [];

  int moment;

  // Constructors
<<<<<<< HEAD
  EthiopianCalendar({int year, int month, int day});

  EthiopianCalendar.now() {
    this.moment = DateTime.now().millisecondsSinceEpoch;
  }

//  var moonLanding = EthiopianCalendar.parse("1969-07-20 20:18:04Z");  // 8:18pm
  static EthiopianCalendar parse(String formattedString) {
=======
  EtDatetime(
      {@required int year,
      int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0})
      : this.moment =
            _dateToEpoch(year, month, day, hour, minute, second, millisecond) {
    if (moment == null) throw new ArgumentError();
  }

  EtDatetime.now() {
    this.moment = DateTime.now().millisecondsSinceEpoch;
  }

  EtDatetime.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch)
      : this._withValue(
            millisecondsSinceEpoch * Duration.microsecondsPerMillisecond);

//  var moonLanding = EthiopianCalendar.parse("1969-07-20 20:18:04Z");  // 8:18pm
  static EtDatetime parse(String formattedString) {
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
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

      if (value == null) {
        throw FormatException("Time out of range", formattedString);
      }
<<<<<<< HEAD
      return EthiopianCalendar._withValue(value);
=======
      return EtDatetime._withValue(value);
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
    } else {
      throw FormatException("Invalid date format", formattedString);
    }
  }

<<<<<<< HEAD
  static EthiopianCalendar tryParse(String formattedString) {
=======
  static EtDatetime tryParse(String formattedString) {
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  int get year {
    int yearRemainder = this.moment % yearMilliSec;
<<<<<<< HEAD
    int monthValue =
        initialMonth + yearRemainder ~/ monthMilliSec;
=======
    int monthValue = initialMonth + yearRemainder ~/ monthMilliSec;
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
    return monthValue > _months.length
        ? initialYear + (this.moment ~/ yearMilliSec) + 1
        : initialYear + (this.moment ~/ yearMilliSec);
  }

  int get month {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
<<<<<<< HEAD
    int dateValue =
        initialDate + monthRemainder ~/ dateMilliSec;

    if (((initialMonth + yearRemainder ~/ monthMilliSec) %
            _months.length) !=
        0) {
      return dateValue > 30
          ? (initialMonth + yearRemainder ~/ monthMilliSec) +
              1
=======
    int dateValue = initialDate + monthRemainder ~/ dateMilliSec;

    if (((initialMonth + yearRemainder ~/ monthMilliSec) % _months.length) !=
        0) {
      return dateValue > 30
          ? (initialMonth + yearRemainder ~/ monthMilliSec) + 1
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
          : initialMonth + yearRemainder ~/ monthMilliSec;
    }
    // else it is ጷጉሜን
    else {
<<<<<<< HEAD
      if (initialYear + (this.moment ~/ yearMilliSec) % 4 ==
          3) {
        return dateValue > 6
            ? (initialMonth +
                    yearRemainder ~/ monthMilliSec) +
                1
            : initialMonth + yearRemainder ~/ monthMilliSec;
      } else {
        return dateValue > 5
            ? (initialMonth +
                    yearRemainder ~/ monthMilliSec) +
                1
=======
      if (initialYear + (this.moment ~/ yearMilliSec) % 4 == 3) {
        return dateValue > 6
            ? (initialMonth + yearRemainder ~/ monthMilliSec) + 1
            : initialMonth + yearRemainder ~/ monthMilliSec;
      } else {
        return dateValue > 5
            ? (initialMonth + yearRemainder ~/ monthMilliSec) + 1
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
            : initialMonth + yearRemainder ~/ monthMilliSec;
      }
    }
  }

<<<<<<< HEAD
  String get monthName {
    return _months[month-1];
=======
  String get monthGeez {
    return _months[month - 1];
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
  }

  int get day {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int month = this.month;
    int date = monthRemainder ~/ dateMilliSec;

    // If it's NOT ጷጉሜን ( the last month of the year)
    if (month ~/ 13 == 0) {
<<<<<<< HEAD
      return (initialDate + date) % 30;
    } else {
      if (initialYear + (this.moment ~/ yearMilliSec) % 4 ==
          3) {
        return (initialDate + date) % 6;
      } else {
        return (initialDate + date) % 5;
=======
      return (initialDate + date) % 30 | 30;
    } else {
      if (year % 4 == 3) {
        int a = (initialDate + date) % 6 | 6;
//        return (initialDate + date) % 6;
        return a;
      } else {
        return (initialDate + date) % 5 | 5;
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
      }
    }
  }

<<<<<<< HEAD
  String get date{
    return _dayNumbers[this.day];
=======
  String get dayGeez {
    print(day);
    return _dayNumbers[day - 1 < 30 ? day - 1 : 0];
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
  }

  int get hour {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    return dateRemainder ~/ hourMilliSec;
  }

  int get minute {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    int hourRemainder = dateRemainder % hourMilliSec;
    return hourRemainder ~/ minMilliSec;
  }

  int get second {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    int hourRemainder = dateRemainder % hourMilliSec;
    int minuteRemainder = hourRemainder % minMilliSec;
    return minuteRemainder ~/ secMilliSec;
  }

  int get millisecond {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    int hourRemainder = dateRemainder % hourMilliSec;
    int minuteRemainder = hourRemainder % minMilliSec;
    return minuteRemainder % secMilliSec;
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
    if (n >= 100) return "${n}";
    if (n >= 10) return "0${n}";
    return "00${n}";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  static int _dateToEpoch(int year, int month, int date, int hour, int minute,
      int second, int millisecond) {
//    Calendar.millisecondsPerYear(year, month, day) +
    return (yearMilliSec * (year - initialYear) +
            monthMilliSec * (month - initialMonth) +
            dateMilliSec * (date - initialDate) +
<<<<<<< HEAD
            hourMilliSec * (hour - initialHour) +
=======
            hourMilliSec * hour +
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
            millisecondsPerMinute * minute +
            millisecondsPerSecond * second +
            millisecond)
        .abs();
  }

<<<<<<< HEAD
  EthiopianCalendar._withValue(this.moment) {

=======
  EtDatetime._withValue(this.moment) {
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
    if (DateTime.now().millisecondsSinceEpoch.abs() >
            _maxMillisecondsSinceEpoch ||
        (DateTime.now().millisecondsSinceEpoch.abs() ==
            _maxMillisecondsSinceEpoch)) {
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

  static final RegExp _parseFormat = RegExp(
      r'^([+-]?\d{4,6})-?(\d\d)-?(\d\d)' // Day part.
      r'(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?$' // Time part.
      r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$');

<<<<<<< HEAD
  EthiopianCalendar nextMonth(){}
  EthiopianCalendar previousMonth(){}


  EthiopianCalendar nextYear(){}
  EthiopianCalendar previousYear(){}


=======
//  EthiopianCalendar add(Duration duration) {}
//  EthiopianCalendar subtract(Duration duration) {}
  EtDatetime difference(EtDatetime date) {}
>>>>>>> 389a48ea2ec48c17ae6d51738005810bfa076d7f
}
