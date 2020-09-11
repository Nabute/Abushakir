//

part of abushakir;

class BealNameException implements Exception {
  @override
  String toString() =>
      'Holiday is not a movable one. Please provide holidays between ነነዌ and ጾመ ድህነት';
}

class MonthNumberException implements Exception {
  String message() => 'Month number should be between 1 and 13.';
}

class WeekdayNumberException implements Exception {
  String message() => 'Weekday number should be between 0 and 6.';
}

class EthiopicNumberException implements Exception {
  final message;

  EthiopicNumberException([this.message]);

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
