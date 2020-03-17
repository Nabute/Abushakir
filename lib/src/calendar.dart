///
part of ethiopiancalendar;


abstract class Calendar extends Equatable {
  @override
  List<Object> get props => [];

//  // Getters
  external int get day;

  int get year;

  int get month;

  int get hour;

  int get minute;

  int get second;

  int get millisecond;

//  String getDay();
//  String getTime();

  String toString();

// Setters
}