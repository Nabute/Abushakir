//

part of ethiopiancalendar;


class BealNameException implements Exception {
  @override
  String toString() => 'Holiday is not a movable one. Please provide holidays between ነነዌ and ጾመ ድህነት';
}