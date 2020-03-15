///
part of ethiopiancalendar;


class EthiopianCalendar extends Calendar {
  @override
  List<Object> get props => [];

  int moment;

  // Constructors
  EthiopianCalendar({int year, int month, int day});

  EthiopianCalendar.now() {
    this.moment = DateTime.now().millisecondsSinceEpoch;
  }

//  var moonLanding = EthiopianCalendar.parse("1969-07-20 20:18:04Z");  // 8:18pm
  static EthiopianCalendar parse(String formattedString) {
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
      return EthiopianCalendar._withValue(value);
    } else {
      throw FormatException("Invalid date format", formattedString);
    }
  }

  static EthiopianCalendar tryParse(String formattedString) {
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  int getYear() {
    int yearRemainder = this.moment % yearMilliSec;
    int monthValue =
        initialMonth + yearRemainder ~/ monthMilliSec;
    return monthValue > _months.length
        ? initialYear + (this.moment ~/ yearMilliSec) + 1
        : initialYear + (this.moment ~/ yearMilliSec);
  }

  int getMonth() {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateValue =
        initialDate + monthRemainder ~/ dateMilliSec;

    if (((initialMonth + yearRemainder ~/ monthMilliSec) %
            _months.length) !=
        0) {
      return dateValue > 30
          ? (initialMonth + yearRemainder ~/ monthMilliSec) +
              1
          : initialMonth + yearRemainder ~/ monthMilliSec;
    }
    // else it is ጷጉሜን
    else {
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
            : initialMonth + yearRemainder ~/ monthMilliSec;
      }
    }
  }

  String getMonthName(){
    return _months[getMonth()];
  }

  int getDay() {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int month = this.getMonth();
    int date = monthRemainder ~/ dateMilliSec;

    // If it's NOT ጷጉሜን ( the last month of the year)
    if (month ~/ 13 == 0) {
      return (initialDate + date) % 30;
    } else {
      if (initialYear + (this.moment ~/ yearMilliSec) % 4 ==
          3) {
        return (initialDate + date) % 6;
      } else {
        return (initialDate + date) % 5;
      }
    }
  }

  String getDate(){
    return _dayNumbers[getDay()];
  }

  int getHour() {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    return dateRemainder ~/ hourMilliSec;
  }

  int getMinute() {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    int hourRemainder = dateRemainder % hourMilliSec;
    return hourRemainder ~/ minMilliSec;
  }

  int getSecond() {
    int yearRemainder = this.moment % yearMilliSec;
    int monthRemainder = yearRemainder % monthMilliSec;
    int dateRemainder = monthRemainder % dateMilliSec;
    int hourRemainder = dateRemainder % hourMilliSec;
    int minuteRemainder = hourRemainder % minMilliSec;
    return minuteRemainder ~/ secMilliSec;
  }

  int getMilliSecond() {
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
            hourMilliSec * (hour - initialHour) +
            millisecondsPerMinute * minute +
            millisecondsPerSecond * second +
            millisecond)
        .abs();
  }

  EthiopianCalendar._withValue(this.moment) {

    if (DateTime.now().millisecondsSinceEpoch.abs() >
            _maxMillisecondsSinceEpoch ||
        (DateTime.now().millisecondsSinceEpoch.abs() ==
            _maxMillisecondsSinceEpoch)) {
      throw ArgumentError(
          "Calendar is outside valid range: ${DateTime.now().millisecondsSinceEpoch}");
    }
  }

  String toString() {
    String y = _fourDigits(this.getYear());
    String m = _twoDigits(this.getMonth());
    String d = _twoDigits(this.getDay());
    String h = _twoDigits(this.getHour());
    String min = _twoDigits(this.getMinute());
    String sec = _twoDigits(this.getSecond());
    String ms = _threeDigits(this.getMilliSecond());
    return "$y-$m-$d $h:$min:$sec.$ms";
  }

  String toJson() {
    return json.encode({
      "year": _fourDigits(this.getYear()),
      "month": _twoDigits(this.getMonth()),
      "date": _twoDigits(this.getDay()),
      "hour": _twoDigits(this.getHour()),
      "min": _twoDigits(this.getMinute()),
      "sec": _twoDigits(this.getSecond()),
      "ms": _threeDigits(this.getMilliSecond()),
    });
  }

  String toIso8601String() {
    int year = this.getYear();
    int month = this.getMonth();
    int day = this.getDay();
    int hour = this.getHour();
    int minute = this.getMinute();
    int second = this.getSecond();
    int millisecond = this.getMilliSecond();

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
      r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$'); // Timezone part.

}
