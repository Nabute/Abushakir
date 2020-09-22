# Abushakir (ባሕረ ሃሳብ) 
[![GitHub stars](https://img.shields.io/github/stars/Nabute/Abushakir?style=social)](https://github.com/Nabute/Abushakir/stargazers)       [![GitHub forks](https://img.shields.io/github/forks/Nabute/Abushakir?style=social)](https://github.com/Nabute/Abushakir/network)
[![GitHub license](https://img.shields.io/github/license/Nabute/Abushakir)](https://github.com/Nabute/Abushakir/blob/master/LICENSE)

The words Bahire Hasab originate from the ancient language of Ge'ez, ( Arabic: Abu Shakir) is a
time-tracking method, devised by the 12th pope of Alexandria, Pope St. Dimitri.

## What does it mean?

"Bahire Hasab /'bəhrɛ həsəb'/  " simply means "An age with a descriptive and chronological number". In some books it can also be found as "Hasabe Bahir", in a sense giving time an analogy, resembling a sea.

This package allows developers to implement Ethiopian Calendar and Datetime System in their application(s)`.

This package is implemented using the [UNIX EPOCH](https://en.wikipedia.org/wiki/Unix_time) which
means it's not a conversion of any other calendar system into Ethiopian, for instance, Gregorian Calendar.

Unix Epoch is measured using milliseconds since 01 Jan, 1970 UTC. In unix epoch leap seconds are ignored.

## Documentation
[Abushakir](https://pub.dev/documentation/abushakir/latest/)

## Demo
[Ethiopian calendar](https://github.com/Nabute/ethiopian_calendar)

## Prerequisites

Before you begin, ensure you have met the following requirements:

* ```equatable= ^1.1.0```


## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  abushakir: "^0.1.4"
```

In your library add the following import:

```dart
import 'package:abushakir/abushakir.dart';
```
## Example

```dart
   /**
   * Ethiopian Datetime Module [EtDatetime]
   */
  EtDatetime now = new EtDatetime.now(); // => 2012-07-28 17:18:31.466
  print(now.date); // => {year: 2012, month: 7, day: 28}
  print(now.time); // => {h: 17, m: 18, s: 31}

  EtDatetime covidFirstConfirmed = new EtDatetime(year: 2012, month: 7, day: 4);
  EtDatetime covidFirstConfirmedEpoch =
      new EtDatetime.fromMillisecondsSinceEpoch(covidFirstConfirmed.moment);

  EtDatetime covidFirstDeath = EtDatetime.parse("2012-07-26 23:00:00");

  /// Comparison of two EtDatetime Instances
  Duration daysWithOutDeath = covidFirstConfirmed.difference(covidFirstDeath);

  assert(daysWithOutDeath.inDays == -22, true); // 22 days

  assert(covidFirstDeath.isAfter(covidFirstConfirmed), true);

  assert(covidFirstDeath.isBefore(now), true);

  assert(covidFirstConfirmed.isAtSameMomentAs(covidFirstConfirmedEpoch), true);

  /**
   * Ethiopian Calendar Module [ETC]
   */
  ETC ethiopianCalendar = new ETC(year: 2012, month: 7, day: 4);

  ///
  print(ethiopianCalendar.monthDays(geezDay: true, weekDayName:true)); // Iterable Object of the given month
  print(ethiopianCalendar.monthDays().toList()[0]); // => [2012, 7, ፩, አርብ]
  // [year, month, dateNumber, dateNameIndex], Monday as First weekday

  print(ethiopianCalendar.nextMonth); // => ETC instance of nextMonth, same year
  print(ethiopianCalendar.prevYear); // => ETC instance of prevYear, same month

  /**
   * Bahire Hasab Module [BahireHasab]
   */
  BahireHasab bh = BahireHasab(year: 2011);
//  BahireHasab bh = BahireHasab(); // Get's the current year

  print(bh.getEvangelist(returnName: true)); // => ሉቃስ

  print(bh.getSingleBealOrTsom("ትንሳኤ")); // {month: ሚያዝያ, date: 20}

  bh.allAtswamat; // => List of All fasting and Movable holidays

  /**
   * Arabic or English number (1,2,3...) to Ethiopic or GE'EZ (፩, ፪, ፫...) number Converter
   */

  var input= [1, 10, 15, 20, 25, 78, 105, 333, 450, 600, 1000, 1001, 1010, 1056, 1200, 2013, 9999, 10000];

  for (var arabic in input) {
     print(ConvertToEthiopic(arabic)); // [፩, ፲, ፲፭, ፳, ፳፭, ፸፰, ፻፭, ፫፻፴፫, ፬፻፶, ፮፻, ፲፻, ፲፻፩, ፲፻፲, ፲፻፶፮, ፲፪፻, ፳፻፲፫, ፺፱፻፺፱, ፻፻]
  }

   /*
   * Conversion from any calendar (in this case, Gregorian) into Ethiopian Calendar.
   */
    DateTime gregorian1 = new DateTime.now();
    EtDatetime ethiopian1 = new EtDatetime.fromMillisecondsSinceEpoch(gregorian1.millisecondsSinceEpoch);

    print("Gregorian := ${gregorian1.toString()} is equivalent to Ethiopian ${ethiopian1.toString()}");
    // Gregorian := 2020-09-22 23:36:37.042962 is equivalent to Ethiopian 2013-01-12 20:36:37.042
    /*
    * Conversion from Ethiopian Calendar into any calendar (in this case, Gregorian).
    */
    EtDatetime ethiopian = new EtDatetime.now();
    DateTime gregorian = new DateTime.fromMillisecondsSinceEpoch(ethiopian.moment);

    print("Ethiopian ${ethiopian.toString()} is equivalent to Gregorian := ${gregorian.toString()}");
    // Ethiopian 2013-01-12 20:36:37.044 is equivalent to Gregorian := 2020-09-22 23:36:37.044

    print("Ethiopian EPOCH := ${ethiopian.moment}"); // Ethiopian EPOCH := 1600806997044
    print("Gregorian EPOCH := ${gregorian.millisecondsSinceEpoch}"); // Gregorian EPOCH := 1600806997044

```
For further implementation example see [this flutter application](https://github.com/Nabute/ethiopian_calendar)


## Contributors

Thanks to the following people who have contributed to this project:

* [@Nabute](https://github.com/Nabute) 📖
* [@Nahom](https://github.com/icnahom) 📖

<!---You might want to consider using something like the [All Contributors](https://github.com/all-contributors/all-contributors) specification and its [emoji key](https://allcontributors.org/docs/en/emoji-key).--->

## Contact

If you want to contact me you can reach me at <daniel@ibrave.dev>.

## License
<!--- If you're not sure which open license to use see https://choosealicense.com/--->

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
