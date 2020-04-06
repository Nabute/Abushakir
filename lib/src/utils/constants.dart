///
part of abushakir;

/// The 4 Evangelist(s)
const List<String> _evangelists = ["ዮሐንስ", "ማቴዎስ", "ማርቆስ", "ሉቃስ"];

/// Before Christ (BC)
const int _ameteFida = 5500;

/// ancient values
const int _tinteAbekte = 11;
const int _tinteMetkih = 19;

/// weekdays
const List<String> _weekdays = [
  "ሰኞ",
  "ማግሰኞ",
  "ረቡዕ",
  "ሐሙስ",
  "አርብ",
  "ቅዳሜ",
  "እሁድ",
];

/// Weekday's Tewsak
List<Map<String, dynamic>> _yeeletTewsak = [
  {"key": "አርብ", "value": 2},
  {"key": "ሐሙስ", "value": 3},
  {"key": "ረቡዕ", "value": 4},
  {"key": "ማግሰኞ", "value": 5},
  {"key": "ሰኞ", "value": 6},
  {"key": "እሁድ", "value": 7},
  {"key": "ቅዳሜ", "value": 8},
];

/// Holiday's Tewsak
Map<String, int> _yebealTewsak = {
  "ነነዌ": 0,
  "ዓቢይ ጾም": 14,
  "ደብረ ዘይት": 41,
  "ሆሣዕና": 62,
  "ስቅለት": 67,
  "ትንሳኤ": 69,
  "ርክበ ካህናት": 93,
  "ዕርገት": 108,
  "ጰራቅሊጦስ": 118,
  "ጾመ ሐዋርያት": 119,
  "ጾመ ድህነት": 121,
};



List<Map<String, dynamic>> _yatswamatTewsak = [
  {"tsom": "ነነዌ", "tewsak": 0},
  {"tsom": "ዓቢይ ጾም", "tewsak": 14},
  {"tsom": "ደብረ ዘይት", "tewsak": 11},
  {"tsom": "ሆሣዕና", "tewsak": 2},
  {"tsom": "ስቅለት", "tewsak": 7},
  {"tsom": "ትንሳኤ", "tewsak": 9},
  {"tsom": "ርክበ ካህናት", "tewsak": 3},
  {"tsom": "ዕርገት", "tewsak": 18},
  {"tsom": "ጰራቅሊጦስ", "tewsak": 28},
  {"tsom": "ጾመ ሐዋርያት", "tewsak": 29},
  {"tsom": "ጾመ ድህነት", "tewsak": 1},
];

const List<String> _dayNumbers = [
  "፩",
  "፪",
  "፫",
  "፬",
  "፭",
  "፮",
  "፯",
  "፰",
  "፱",
  "፲",
  "፲፩",
  "፲፪",
  "፲፫",
  "፲፬",
  "፲፭",
  "፲፮",
  "፲፯",
  "፲፰",
  "፲፱",
  "፳",
  "፳፩",
  "፳፪",
  "፳፫",
  "፳፬",
  "፳፭",
  "፳፮",
  "፳፯",
  "፳፰",
  "፳፱",
  "፴",
];

// Month constants that are returned by the [month] getter.
const List<String> _months = [
  "መስከረም",
  "ጥቅምት",
  "ኅዳር",
  "ታኅሳስ",
  "ጥር",
  "የካቲት",
  "መጋቢት",
  "ሚያዝያ",
  "ግንቦት",
  "ሰኔ",
  "ኃምሌ",
  "ነሐሴ",
  "ጷጉሜን"
];

const int _maxMillisecondsSinceEpoch = 8640000000000000;

const int ethiopicEpoch = 2796;
const int unixEpoch = 719163;

const int initialYear = 1962;
const int initialMonth = 4;
const int initialDate = 23; // was 23 initially, changed it for testing
const int initialHour = 9; // after mid night, Ethiopian mid night, 09:00

/// Testing with ethiopian  648000 is the difference in milliSecondsPerYear
const int yearMilliSec = 31556952000; // 366 days: 31622400
const int monthMilliSec = 2592000000;
const int dayMilliSec = 86400000;
const int hourMilliSec = 3600000;
const int minMilliSec = 60000;
const int secMilliSec = 1000;
const int epochOffset = 2527200;
const int biginningEpoch = 61925806800 + epochOffset;

const int millisecondsPerSecond = 1000;
const int secondsPerMinute = 60;
const int minutesPerHour = 60;
const int hoursPerDay = 24;

int millisecondsPerMonth(int month, int year) {
  if (month % 13 == 0) {
    return millisecondsPerDay * 30;
  } else {
    if (year % 4 == 3) {
      return millisecondsPerDay * 6;
    } else {
      return millisecondsPerDay * 5;
    }
  }
}

int millisecondsPerYear(int year, int month, int day) {
  final currentDay = DateTime(year, month, day);
  final initialDay = DateTime(initialYear, initialMonth, initialDate);
  final difference = initialDay.difference(currentDay);
  return difference.abs().inMilliseconds;
}

const int millisecondsPerMinute = millisecondsPerSecond * secondsPerMinute;
const int millisecondsPerHour = millisecondsPerMinute * minutesPerHour;
const int millisecondsPerDay = millisecondsPerHour * hoursPerDay;

const int secondsPerHour = secondsPerMinute * minutesPerHour;
const int secondsPerDay = secondsPerHour * hoursPerDay;
const int minutesPerDay = minutesPerHour * hoursPerDay;
