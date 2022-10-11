// Copyright 2020 GC (2012 ETC) Nabute and Nahom. All rights reserved.
// Use of this source code is governed by MIT license, which can be found
// in the LICENSE file.

part of abushakir;

///
///
/// "Bahire Hasab /'bəhrɛ həsəb'/  " simply means "An age with a descriptive
/// and chronological number". In some books it can also be found as
/// "Hasabe Bahir", in a sense giving time an analogy, resembling a sea.
///
/// As the different documents explain, a sea is a never-ending, constant
/// flow of water from its source to limits incomprehensible to the senses of
/// man. As is time.
///
/// There are 8 Rules or you can call them conventions too. These are:
///
///  1. When calculating [wenber]which is remainder of
///   [ameteAlem] by 19, subtract 1 (ONE) from the remainder as of
///  the story in ancient calculation "አንዱን ለዘመኑ ሰጠው".
///
///  2. If [metkih] > 14, then month of [metkih]
///   will be at the FIRST month of the year. which is መስከረም.
///
///  3. If [metkih] <= 14, then month of [metkih]
///   will be at the SECOND month of the year. which is ጥቅምት.
///
///  4. If month of [metkih] is መስከረም (the FIRST month), then
///   Nineveh or [nenewe] will be in ጥር (the FIFTH month).
///
///  5. If month of [metkih] is ጥቅምት (the FIRST month), then
///  Nineveh or [nenewe] will be in የካቲት (the SIXTH month).
///
///  6. If the summation of [metkih] and the corresponding
///   number of the weekday that [metkih] is on, is greater than
///   30 (> 30) then Nineveh or [nenewe] will be in የካቲት
///   (the SIXTH month).
///
///  7. If the value of [wenber] == 0, the corresponding value
///   of the 30th weekday for መስከረም (the first month) will be the value of
///   MEBAJA HAMER which is technically [metkih] + weekday
///   corresponding value or number.
///
///  8. If the value of [wenber] == 0, then Nineveh or
///  [nenewe] will be in የካቲት (the SIXTH month)
///
///
class BahireHasab extends Equatable {
  int? _year;

  BahireHasab({int year = -1}) {
    year < 0 ? _year = EtDatetime.now().year : _year = year;
  }

  ///
  /// Getting the evangelist of the given year, if year is not provided
  /// it will take the current year and the years before christ ( አመተ ፍዳ )
  /// and get the age of earth, since creation day of Adam and Eve and, divide
  /// it by 4 and then
  ///
  /// * if Remainder == 0 => the year will be assigned to apostle JOHN
  ///
  /// * if Remainder == 1 => the year will be assigned to apostle MATHEW
  ///
  /// * if Remainder == 2 => the year will be assigned to apostle MARK
  ///
  /// *if Remainder == 3 => the year will be assigned to apostle LUKE
  ///
  /// LUKE is when the leap year occurs.
  ///
  /// ```
  ///
  /// // const List<String> evangelists = ["ዮሐንስ", "ማቴዎስ", "ማርቆስ", "ሉቃስ"];
  ///
  /// BahireHasab bh = BahireHasab(year: 2011);
  /// bh.getEvangelist(returnName: true)
  ///
  /// ```
  ///
  /// if returnName is not provided or is false, as the default, this function
  /// will return index of the apostle from evangelists list.
  ///
  ///

  String getEvangelist({bool returnName = false}) {
    int evangelist;
    evangelist = ameteAlem % 4;
    if (returnName) {
      return _evangelists[evangelist];
    }
    return evangelist.toString();
  }

  ///
  /// Amete alem (አመተ ዓለም) is the total years from the creation day. In
  /// Ethiopian calendar the day of Adam and Eve creation is believed to be 5500 years
  /// before Christ which is referred as Year of Agony or ( አመተ ፍዳ ). And
  /// this function is used to calculate the number of years from the
  /// creation day till the given year, or current year if year parameter is not
  /// provided.
  ///
  ///
  int get ameteAlem => _ameteFida + this._year!;

  ///
  /// Get year's first weekday of current year or the very first weekday that the
  /// current year is going to be start from. It returns the name of the weekday if
  /// returnName=true otherwise it will return the index of the weekday
  /// from list of weekdays.
  ///
  ///
  String getMeskeremOne({bool returnName = false}) {
    int rabeet = ameteAlem ~/ 4;
    int result = (ameteAlem + rabeet) % 7;
    if (returnName) return _weekdays[result];
    return result.toString();
  }

  ///
  /// A variable that helps to get Abekte and Metkih
  ///
  int get wenber => ((ameteAlem % 19) - 1) < 0 ? 0 : (ameteAlem % 19) - 1;

  ///
  /// Abekte means the difference between solar and lunar years. The
  /// initial or the first or the ancient value of Abekte is 11.
  ///
  int get abekte => (wenber * _tinteAbekte) % 30;

  ///
  /// Metkih the name of feast and Hebrew New Year in which the shofar is
  /// announced. It usually destined on the Seventh month of the first day
  /// of the moon.
  ///
  int get metkih => wenber == 0 ? 30 : (wenber * _tinteMetkih) % 30;

  ///
  /// This function returns the month index value assuming መስከረም with index
  /// value of 0 which are
  ///
  /// if [metkih] > 14 => መስከረም
  /// else => ጥቅምት
  ///
  /// according to rule #2 and #3 from the rules mentioned above.
  ///
  int yebealeMetkihWer() {
    if (metkih > 14) {
      return 1;
    } else {
      return 2;
    }
  }

  ///
  /// This function returns the date Tsome Nenewe or Nineveh will be at.
  /// to get this date we need to get Mebaja Hamer(beginning)
  ///
  ///```
  ///
  /// MebajaHamer = Metikih + Ye'elet Tewsak // የእለት ተውሳክ
  ///```
  ///
  Map<String, dynamic> get nenewe {
    String meskerem1 = getMeskeremOne(returnName: true);
    int month = yebealeMetkihWer();
    int date;
    int? dayTewsak;
    _yeeletTewsak.forEach((el) => {
          if (el['key'] ==
              _weekdays[(_weekdays.indexOf(meskerem1) + metkih - 1) % 7])
            dayTewsak = el['value']
        });
    String monthName = dayTewsak! + metkih > 30 ? 'የካቲት' : 'ጥር';
    if (month == 2) {
      // ጥቅምት
      monthName = 'የካቲት';
      String tikimt1 = _weekdays[(_weekdays.indexOf(meskerem1) + 2) % 7];
      String metkihElet =
          _weekdays[(_weekdays.indexOf(tikimt1) + metkih - 1) % 7];
      _yeeletTewsak.forEach((el) => {
            if (el['key'] == _weekdays[_weekdays.indexOf(metkihElet)])
              dayTewsak = el['value']
          });
    }
    date = metkih + dayTewsak!;
    return {"month": monthName, "date": date % 30 == 0 ? 30 : date % 30};
  }

  ///
  /// This function returns an [List] of [Map] object. which is structured in
  /// the form of
  ///
  /// ```
  ///
  /// {beal: ትንሳኤ, day: {month: ሚያዝያ, date: 20}}
  ///
  /// ```
  ///
  List get allAtswamat {
    Map<String, dynamic> mebajaHamer = nenewe;
    List result = [];
    _yebealTewsak.forEach((beal, numOfDays) {
      result.add({
        "beal": beal,
        "day": {
          "month": _months[_months.indexOf(mebajaHamer['month']) +
              (mebajaHamer['date'] + numOfDays) ~/ 30 as int],
          "date": (mebajaHamer['date'] + numOfDays) % 30 == 0
              ? 30
              : (mebajaHamer['date'] + numOfDays) % 30
        }
      });
    });
    return result;
  }

  ///
  /// Checks whether the given holiday is movable or not.
  /// returns true if movable else return false.
  ///
  bool isMovableHoliday(String holidayName) {
    if (_yebealTewsak.keys.contains(holidayName)) {
      return true;
    } else {
      throw BealNameException;
    }
  }

  ///
  /// A function to compute the month and day of the given feast of the
  /// fasting or feasting (Holiday). It returns [Map] object with the form of
  ///
  /// ```
  ///
  /// {month: ሚያዝያ, date: 20}
  ///
  /// ```
  ///
  Map<String, dynamic>? getSingleBealOrTsom(String name) {
    Map<String, dynamic>? a;
    try {
      bool status = isMovableHoliday(name);
      if (status) {
        Map<String, dynamic> mebajaHamer = nenewe;
        int? target = _yebealTewsak[name];
        a = {
          "month": _months[_months.indexOf(mebajaHamer['month']) +
              ((mebajaHamer['date'] + target) ~/ 30) as int],
          "date": (mebajaHamer['date'] + target) % 30 == 0
              ? 30
              : (mebajaHamer['date'] + target) % 30
        };
      }
    } catch (e) {
      print(e.toString());
    }
    return a;
  }

  // OVERRIDES
  @override
  List<Object?> get props => [_year];

  @override
  bool get stringify => true;
}
