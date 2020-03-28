# Abushakir (ባሕረ ሃሳብ)

<!--- These are examples. See https://shields.io for others or to customize this set of shields. You might want to include dependencies, project status and licence info here --->
<!---![GitHub repo size](https://img.shields.io/github/repo-size/Nabute/Abushakir)--->
<!---![GitHub contributors](https://img.shields.io/github/contributors/Nabute/Abushakir)--->
<!---![GitHub stars](https://img.shields.io/github/stars/Nabute/Abushakir?style=social)--->
<!---![GitHub forks](https://img.shields.io/github/forks/Nabute/Abushakir?style=social)--->
<!---![Twitter Follow](https://img.shields.io/twitter/follow/danny_nigusse?style=social)--->

Abushakir is a package that allows developers to implement ethiopian calendar system in their application(s)`.

This package is implemented using the [UNIX EPOCH](https://en.wikipedia.org/wiki/Unix_time) which means it's not a conversion of any other calendar system into
ethiopian, for instance, Gregorian Calendar into Ethiopian.

## Prerequisites

Before you begin, ensure you have met the following requirements:
<!--- These are just example requirements. Add, duplicate or remove as required --->
* ```equatable= ^1.1.0```

## Installing <Abushakir>

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

// Ethiopain Date and Time
EtDatetime aMoment = EtDatetime.parse("2011-13-06 02:15:22");
print("Year: ${aMoment.year}");
print("Month: ${aMoment.month}");
print("Day: ${aMoment.day}");
print("Hour: ${aMoment.hour}");
print("Minutes: ${aMoment.minute}");
print("Seconds: ${aMoment.second}");
print("MilliSeconds: ${aMoment.millisecond}");
print("To String: ${aMoment.toString()}");
print("To JSON: ${aMoment.toJson()}");
print("To ISO8601String Format: ${aMoment.toIso8601String()}");
print("The Month is ${aMoment.monthGeez}");

/// OUTPUT
/*
* Year: 2011
* Month: 13
* Day: 6
* Hour: 14
* Minutes: 15
* Seconds: 22
* MilliSeconds: MilliSeconds: 0
* To String: 2011-13-06 14:15:22.000
* To JSON: {"year":"2011","month":"13","date":"06","hour":"14","min":"15","sec":"22","ms":"000"}
* To ISO8601String Format: 2011-13-06T14:15:22.000
The Month is ጷጉሜን
*/

/// Ethiopian Calendar
ETC et = new ETC(year: aMoment.year, month: aMoment.month);

/// OUTPUT
/*
*Days in the month 13 of 2011:= ([2011, 13, 1, 4], [2011, 13, 2, 5], [2011, 13, 3, 6], ..., [2011, 13, 5, 1], [2011, 13, 6, 2])
*/
```

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
* [@Nahom](https://github.com/icnahom) 🐛

<!---You might want to consider using something like the [All Contributors](https://github.com/all-contributors/all-contributors) specification and its [emoji key](https://allcontributors.org/docs/en/emoji-key).--->

## Contact

If you want to contact me you can reach me at <daniel@ibrave.dev>.

## License
<!--- If you're not sure which open license to use see https://choosealicense.com/--->

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
