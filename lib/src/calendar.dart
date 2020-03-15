///
part of ethiopiancalendar;


abstract class Calendar extends Equatable {
  @override
  List<Object> get props => [];

//  // Getters
  int getDay();

  int getYear();

  int getMonth();

  int getHour();

  int getMinute();

  int getSecond();

  int getMilliSecond();

//  String getDay();
//  String getTime();

  String toString();

// Setters
}