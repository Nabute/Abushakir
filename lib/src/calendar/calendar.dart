///
part of abushakir;

class ETC implements Calendar {
  EtDatetime _date;

  ETC({@required int year, int month = 1, int day = 1}) {
    _date = new EtDatetime(year: year, month: month, day: day);
  }

  ETC.today() {
    _date = new EtDatetime.now();
  }

  int get year => _date.year;

  int get month => _date.month;

  String get monthName => _date.monthGeez;

  int get day => _date.day;

  /*
   * Returning Next month.
   */
  ETC get nextYear => new ETC(year: _date.year + 1, month: _date.month);

  /*
   * Returning previous month.
   */
  ETC get prevYear => new ETC(year: _date.year - 1, month: _date.month);

  /*
   * Returning Next month.
   */
  ETC get nextMonth => new ETC(
      year: _date.year,
      month: _date.month + 1);

  /*
   * Returning previous month.
   */
  ETC get prevMonth => new ETC(
      year: _date.month == 1 ? _date.year - 1 : _date.year,
      month: _date.month - 1 == 0 ? 13 : _date.month - 1);

  /*
   * Returns month range and monthStartDay as an array.
   */
  List<int> _monthRange() {
    if (_date.month <= 1 && _date.month >= 13) throw MonthNumberException;
    return [_date.weekday, _date.month == 13 ? _date.isLeap ? 6 : 5 : 30];
  }

  /*
   * Returns list of weekdays with their respective date
   */
  @override
  Iterable<List<int>> monthDays() sync* {
    int monthBeginning = _monthRange()[0];
    int daysInMonth = _monthRange()[1];
    for (int i = 0; i < daysInMonth; i++) {
      yield [_date.year, _date.month, i + 1, monthBeginning];
      monthBeginning = (monthBeginning + 1) % 7;
    }
  }

  Iterable<List<int>> _monthDays(int year, int month) sync* {
    EtDatetime yr = new EtDatetime(year: year, month: month);
    int monthBeginning = yr.weekday;
    int daysInMonth = yr.month == 13 ? yr.isLeap ? 6 : 5 : 30;
    for (int i = 0; i < daysInMonth; i++) {
      yield [year, month, i + 1, monthBeginning];
      monthBeginning = (monthBeginning + 1) % 7;
    }
  }

  @override
  Iterable<Iterable<List<int>>> yearDays() sync* {
    for (int i = 0; i < _months.length; i++) {
      yield _monthDays(_date.year, i + 1);
    }
  }

  // OVERRIDES
  @override
  List<Object> get props => null;

  @override
  bool get stringify => true;
}
