///
part of ethiopiancalendar;

/// Cycles [ዓውዳት]
const int _awdeElet = 7; // Day cycle
const int _awdeWerh = 30; // Month cycle
const double _awdeAmet = 365.25; // Year Cycle

const int _awdeTsehay = 28; // Sun's cycle
const int _awdeMahtem = 76; // Cycle of Seal
const int _awdeAbiyKemer = 532; // Greatlunar cycle

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

const int initialYear = 1962;
const int initialMonth = 4;
const int initialDate = 23;
const int initialHour = 21; // after mid night, Ethiopian mid night, 09:00

const int yearMilliSec = 31556952000;
const int monthMilliSec = 2592000000;
const int dateMilliSec = 86400000;
const int hourMilliSec = 3600000;
const int minMilliSec = 60000;
const int secMilliSec = 1000;
/// Testing with ethiopian  648000 is the difference in milliSecondsPerYear
//const int yearMilliSec = 31557600000;
//const int monthMilliSec = 1489536000;
//const int a12MonthMilSec = 2592000000;
//const int dateMilliSec = 86400000;
//const int hourMilliSec = 3600000;
//const int minMilliSec = 60000;
//const int secMilliSec = 1000;

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
