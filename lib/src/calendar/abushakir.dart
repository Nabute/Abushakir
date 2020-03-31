///
part of abushakir;

abstract class EDT extends Equatable {
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

  bool isBefore(EtDatetime other);

  bool isAfter(EtDatetime other);

  bool isAtSameMomentAs(EtDatetime other);

  int compareTo(EtDatetime other);

  EtDatetime add(Duration duration);

  EtDatetime subtract(Duration duration);
}

abstract class Calendar extends Equatable {
  @override
  List<Object> get props => [];

  monthDays();
  yearDays();


}
