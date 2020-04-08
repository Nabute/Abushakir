# Abushakir (ባሕረ ሃሳብ)

The words Bahire Hasab originate from the ancient language of Ge'ez, ( Arabic: Abu Shakir) is a
time-tracking method, devised by the 12th pope of Alexandria, Pope St. Dimitri.

## What does it mean?

"Bahire Hasab /'bəhrɛ həsəb'/  " simply means "An age with a descriptive and chronological number". In some books it can also be found as "Hasabe Bahir", in a sense giving time an analogy, resembling a sea.

This package allows developers to implement Ethiopian Calendar and Datetime System in their application(s)`.

This package is implemented using the [UNIX EPOCH](https://en.wikipedia.org/wiki/Unix_time) which
means it's not a conversion of any other calendar system into Ethiopian, for instance, Gregorian Calendar.

Unix Epoch is measured using milliseconds since 01 Jan, 1970 UTC. In unix epoch leap seconds are ignored.

## Prerequisites

Before you begin, ensure you have met the following requirements:
<!--- These are just example requirements. Add, duplicate or remove as required --->
* ```equatable= ^1.1.0```



## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  abushakir: "^0.0.1"
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
  print(ethiopianCalendar.monthDays()); // Iterable Object of the given month
  print(ethiopianCalendar.monthDays().toList()[0]); // => [2012, 7, 1, 1]
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
```
For further implementation example see [this flutter application](https://github.com/Nabute/ethiopian_calendar)

<!---Add run commands and examples you think users will find useful. Provide an options reference for bonus points!--->

## Contributing to <Abushakir>
<!--- If your README is long or you have some specific process or steps you want contributors to follow, consider creating a separate CONTRIBUTING.md file--->
To contribute to <Abushakir>, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin Abushakir/<location>`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

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
