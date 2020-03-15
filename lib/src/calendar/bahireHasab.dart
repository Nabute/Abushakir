///
part of ethiopiancalendar;

class BahireHasab extends Equatable {
  int _year;

  @override
  List<Object> get props => [];

  BahireHasab({int year = -1}) {
    year < 0
        ? this._year = EthiopianCalendar.now().getYear()
        : this._year = year;
  }

  /// Getting the evangelist of the given year, if year is not provided
  /// it will take the current year.
  String getEvangelist({bool returnName = false}) {
    int evangelist;
    int ameteAlem = getAmeteAlem();
    evangelist = ameteAlem % 4;
    if (returnName) {
      return _evangelists[evangelist];
    }
    return evangelist.toString();
  }

  /// Getting the total sum of year from the beggining of numbering till
  /// the given year, if year is not provided
  /// it will take the current year.
  int getAmeteAlem() => _ameteFida + this._year;

  /// Get year's first day or መስከርም 1
  String getMeskeremOne({bool returnName = false}) {
    int ameteAlem = getAmeteAlem();
    int rabeet = ameteAlem ~/ 4;
    int result = (ameteAlem + rabeet) % 7;
    if (returnName) return _weekdays[result];
    return result.toString();
  }

  /// A variable that helps to get Abekte and Metke'e
  int getWenber() {
    int ameteAlem = getAmeteAlem();
    return (ameteAlem % 19) - 1;
  }

  /// Abekte
  int getAbekte() {
    int wenber = getWenber();
    return (wenber * _tinteAbekte) % 30;
  }

  /// Metkih
  int getMetkih() {
    int wenber = getWenber();
    return (wenber * _tinteMetkih) % 30;
  }

  /// All Ethiopian Orthodox church Fasting(s) and Holiday(s).

  int yebealeMetkihWer() {
    int metkih = getMetkih();
    if (metkih > 14) {
      return 1; // መስከረም
    } else
      return 2; // ጥቅምት
  }

  /**
   * This function returns the date Tsome Nenewe will be at.
   * to get this date we need to get Mebaja Hamer(beggining)
   *
   * MebajaHamer = Metikih + Ye'elet Tewsak
   *
   * There are a few rules or theorems about this idea
   * 1:=
   */
  Map<String, dynamic> getNenewe() {}
  Map<String, dynamic> getAbiyTsom() {}
  Map<String, dynamic> getDebreZeyit() {}
  Map<String, dynamic> getHosaena() {}
  Map<String, dynamic> getSiklet() {}
  Map<String, dynamic> getTinsae() {}
  Map<String, dynamic> getRikbeKahinat() {}
  Map<String, dynamic> getErget() {}
  Map<String, dynamic> getPeraklitos() {}
  Map<String, dynamic> getTsomeHawariat() {}
  Map<String, dynamic> getTsomeDihinet() {}


}
