///
part of ethiopiancalendar;


abstract class Calendar extends Equatable {
  @override
  List<Object> get props => [];

//  // Getters
    int get year;

  int get month;

  String get monthGeez;

  int get day;

  String get dayGeez;

  int get hour;

  int get minute;

  int get second;

  int get millisecond;

  String toString();
  String toJson();
  String toIso8601String();
  
}