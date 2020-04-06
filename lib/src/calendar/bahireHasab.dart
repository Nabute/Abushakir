///
part of abushakir;

class BahireHasab extends Equatable {
  int _year;

  BahireHasab({int year = -1}) {
    year < 0 ? this._year = EtDatetime.now().year : this._year = year;
  }

  /// Getting the evangelist of the given year, if year is not provided
  /// it will take the current year.
  String getEvangelist({bool returnName = false}) {
    int evangelist;
    evangelist = ameteAlem % 4;
    if (returnName) {
      return _evangelists[evangelist];
    }
    return evangelist.toString();
  }

  /// Getting the total sum of year from the beginning of numbering till
  /// the given year, if year is not provided
  /// it will take the current year.
  int get ameteAlem => _ameteFida + this._year;

  /// Get year's first day or መስከርም 1
  String getMeskeremOne({bool returnName = false}) {
    int rabeet = ameteAlem ~/ 4;
    int result = (ameteAlem + rabeet) % 7;
    if (returnName) return _weekdays[result];
    return result.toString();
  }

  /// A variable that helps to get Abekte and Metke'e
  int get wenber => (ameteAlem % 19) - 1;

  /// Abekte
  int get abekte => (wenber * _tinteAbekte) % 30;

  /// Metkih
  int get metkih => wenber == 0 ? 30 : (wenber * _tinteMetkih) % 30;

  /// All Ethiopian Orthodox church Fasting(s) and Holiday(s).

  int yebealeMetkihWer() {
    if (metkih > 14) {
      return 1; // መስከረም
    } else
      return 2; // ጥቅምት
  }

  /*
   * This function returns the date Tsome Nenewe will be at.
   * to get this date we need to get Mebaja Hamer(beginning)
   *
   * MebajaHamer = Metikih + Ye'elet Tewsak
   *
   * There are a few rules or theorems about this idea
   * 1:=
   */
  Map<String, dynamic> get nenewe {
    String meskerem1 = getMeskeremOne(returnName: true);
    int month = yebealeMetkihWer();
    int date;
    int dayTewsak;
    _yeeletTewsak.forEach((el) => {
          if (el['key'] ==
              _weekdays[(_weekdays.indexOf(meskerem1) + metkih - 1) % 7])
            dayTewsak = el['value']
        });
    String monthName = dayTewsak + metkih > 30 ? 'የካቲት' : 'ጥር';
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
    date = metkih + dayTewsak;
    return {"month": monthName, "date": date % 30 == 0 ? 30 : date % 30};
  }

  List get allAtswamat {
    Map<String, dynamic> mebajaHamer = nenewe;
    List result = List();
    int m = nenewe['date'];
    _yebealTewsak.forEach((beal, numOfDays) {
      result.add({
        "beal": beal,
        "day": {
          "month": _months[_months.indexOf(mebajaHamer['month']) +
              (mebajaHamer['date'] + numOfDays) ~/ 30],
          "date": (mebajaHamer['date'] + numOfDays) % 30 == 0
              ? 30
              : (mebajaHamer['date'] + numOfDays) % 30
        }
      });
    });
    return result;
  }

  bool isMovableHoliday(String holidayName) {
    if (_yebealTewsak.keys.contains(holidayName)) {
      return true;
    } else
      throw BealNameException;
  }

  Map<String, dynamic> getSingleBealOrTsom(String name) {
    try {
      bool status = isMovableHoliday(name);
      if (status) {
        Map<String, dynamic> mebajaHamer = nenewe;
        int target = _yebealTewsak[name];
        Map<String, dynamic> a = {
          "month": _months[_months.indexOf(mebajaHamer['month']) +
              ((mebajaHamer['date'] + target) ~/ 30)],
          "date": (mebajaHamer['date'] + target) % 30 == 0
              ? 30
              : (mebajaHamer['date'] + target) % 30
        };
        return a;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // OVERRIDES
  @override
  List<Object> get props => [_year];

  @override
  bool get stringify => true;
}
