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

/// Weekday's Tewsak (corresponding numbers)
List<Map<String, dynamic>> _yeeletTewsak = [
  {"key": "አርብ", "value": 2},
  {"key": "ሐሙስ", "value": 3},
  {"key": "ረቡዕ", "value": 4},
  {"key": "ማግሰኞ", "value": 5},
  {"key": "ሰኞ", "value": 6},
  {"key": "እሁድ", "value": 7},
  {"key": "ቅዳሜ", "value": 8},
];

/// Holiday's Tewsak (corresponding numbers)
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
  "፴"
];

// Month constants that are returned by the [month] getter.
const List<String?> _months = [
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

const int _ethiopicEpoch = 2796;
const int _unixEpoch = 719163;

const int dayMilliSec = 86400000;
const int hourMilliSec = 3600000;
const int minMilliSec = 60000;
const int secMilliSec = 1000;

const Map<int, String> geezNumbers = {
  1: '፩',
  2: '፪',
  3: '፫',
  4: '፬',
  5: '፭',
  6: '፮',
  7: '፯',
  8: '፰',
  9: '፱',
  10: '፲',
  20: '፳',
  30: '፴',
  40: '፵',
  50: '፶',
  60: '፷',
  70: '፸',
  80: '፹',
  90: '፺',
  100: '፻',
  10000: '፼',
};
