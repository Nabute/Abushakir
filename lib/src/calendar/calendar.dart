///
part of ethiopiancalendar;

class ETC implements Calendar {
  EtDatetime _date;

  ETC({@required int year, int month = 1, int day = 1}) {
    _date = new EtDatetime(year: year, month: month, day: day);
  }

  /*
   * Returning Next month.
   */
  EtDatetime get nextMonth => _date.month == 13
      ? EtDatetime(year: _date.year + 1, month: 1)
      : EtDatetime(year: _date.year, month: _date.month + 1);

  /*
   * Returning previous month.
   */
  EtDatetime get prevMonth => _date.month == 1
      ? EtDatetime(year: _date.year - 1, month: 12)
      : EtDatetime(year: _date.year, month: _date.month - 1);

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

  List<int> _yearMonthRange({@required EtDatetime aYear}) {
    return [aYear.weekday, aYear.month == 13 ? aYear.isLeap ? 6 : 5 : 30];
  }

  Iterable<List<int>> _monthDays(int year, int month) sync* {
    EtDatetime yr = new EtDatetime(year: year, month: month);
    List<int> result = _yearMonthRange(aYear: yr);
    print(result);
    int monthBeginning = result[0];
    int daysInMonth = result[1];
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
