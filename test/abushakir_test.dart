import 'package:test/test.dart';

import 'package:abushakir/abushakir.dart';

void main() {
  group('Parameterized Constructors :', () {
    late EtDatetime ec;

    setUp(() {
      ec = EtDatetime(year: 2012, month: 07, day: 07);
    });

    test('Testing Year on Parameterized Constructor', () {
      expect(ec.year, 2012);
    });

    test('Testing Month on Parameterized Constructor', () {
      expect(ec.month, 07);
    });

    test('Testing Day on Parameterized Constructor', () {
      expect(ec.day, 07);
    });

    test('Testing Date on Parameterized Constructor', () {
      expect(ec.dayGeez, "፯");
    });
  });

  group('Parameterized Constructors (year only) :', () {
    late EtDatetime ec;

    setUp(() {
      ec = EtDatetime(year: 2010);
    });

    test('Testing Year on Parameterized Constructor', () {
      expect(ec.year, 2010);
    });

    test('Testing Month on Parameterized Constructor', () {
      expect(ec.month, 01);
    });

    test('Testing Day on Parameterized Constructor', () {
      expect(ec.day, 01);
    });
  });

  group('Named Constructors (.parse) :', () {
    late EtDatetime ec;

    setUp(() {
      ec = EtDatetime.parse("2012-07-07 15:12:17.500");
    });

    test('Should Print the parsed Date and Time', () {
      expect(ec.toString(), "2012-07-07 15:12:17.500");
    });

    test('Testing Year on Named Constructor', () {
      expect(ec.year, 2012);
    });

    test('Testing Month on Named Constructor', () {
      expect(ec.month, 07);
    });

    test('Testing Day on Named Constructor', () {
      expect(ec.day, 07);
    });

    test('Testing Date with Named Constructor', () {
      expect(ec.dayGeez, "፯");
    });

    test('Testing Hour on Named Constructor', () {
      expect(ec.hour, 15);
    });

    test('Testing Minute on Named Constructor', () {
      expect(ec.minute, 12);
    });

    test('Testing Second on Named Constructor', () {
      expect(ec.second, 17);
    });

    test('Testing Millisecond on Named Constructor', () {
      expect(ec.millisecond, 500);
    });
  });

  group('Named Constructors (.now) :', () {
    late EtDatetime ec;

    setUp(() {
      ec = EtDatetime.now();
    });
    test('Testing Minute on .now() Named Constructor', () {
      expect(ec.minute, DateTime.now().minute);
    });

    test('Testing Second on .now() Named Constructor', () {
      expect(ec.second, DateTime.now().second);
    });
  });

  group('Named Constructors (.fromMillisecondsSinceEpoch) :', () {
    late EtDatetime ec;

    // 1585731446021 == 2012-07-23 08:57:26.021
    setUp(() {
      ec = EtDatetime.fromMillisecondsSinceEpoch(1585731446021);
    });

    test('Should Print the parsed Date and Time', () {
      expect(ec.toString(), "2012-07-23 08:57:26.021");
    });

    test('Testing Year on Named Constructor', () {
      expect(ec.year, 2012);
    });

    test('Testing Month on Named Constructor', () {
      expect(ec.month, 07);
    });

    test('Testing Day on Named Constructor', () {
      expect(ec.day, 23);
    });

    test('Testing Date with Named Constructor', () {
      expect(ec.dayGeez, "፳፫");
    });

    test('Testing Hour on Named Constructor', () {
      expect(ec.hour, 08);
    });

    test('Testing Minute on Named Constructor', () {
      expect(ec.minute, 57);
    });

    test('Testing Second on Named Constructor', () {
      expect(ec.second, 26);
    });

    test('Testing Millisecond on Named Constructor', () {
      expect(ec.millisecond, 021);
    });
  });

  group('Named Constructors (.now) :', () {
    late EtDatetime ec;

    setUp(() {
      ec = EtDatetime.now();
    });
    test('Testing Minute on .now() Named Constructor', () {
      expect(ec.minute, DateTime.now().minute);
    });

    test('Testing Second on .now() Named Constructor', () {
      expect(ec.second, DateTime.now().second);
    });
  });

  group('Testing functions', () {
    late EtDatetime ec;
    setUp(() {
      // TODO: check if all constructors return same epoch.
//      ec = EtDatetime.now();
      ec = EtDatetime(year: 2012);
    });
    // 1585742246021 == 2012-07-23 11:57:26.021
    test('Testing isAfter()', () {
      print(ec.date);
      expect(ec.isAfter(EtDatetime(year: 2011)), true);
    });
    test('Testing isBefore()', () {
      expect(ec.isBefore(EtDatetime(year: 2080)), true);
    });
    test('Testing isAfter()', () {
      expect(
          ec.isAtSameMomentAs(EtDatetime(
              year: ec.year,
              month: ec.month,
              day: ec.day,
              hour: ec.hour,
              minute: ec.minute,
              second: ec.second,
              millisecond: ec.millisecond)),
          true);
    });
  });
  group('BahireHasab :', () {
    late BahireHasab bh;

    setUp(() {
      bh = BahireHasab(year: 2011);
    });

    test('Testing Abekte', () {
      expect(bh.abekte, 25);
    });

    test('Testing Metkih', () {
      expect(bh.metkih, 5);
    });

    test('Testing Nenewe', () {
      expect(bh.nenewe, {'month': 'የካቲት', 'date': 11});
    });

    // getSingleBealOrTsom
    test("Testing 'ነነዌ' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ነነዌ"), {'month': 'የካቲት', 'date': 11});
    });
    test("Testing 'ዓቢይ ጾም' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ዓቢይ ጾም"), {'month': 'የካቲት', 'date': 25});
    });

    test("Testing 'ደብረ ዘይት' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ደብረ ዘይት"), {'month': 'መጋቢት', 'date': 22});
    });

    test("Testing 'ሆሣዕና' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ሆሣዕና"), {'month': 'ሚያዝያ', 'date': 13});
    });

    test("Testing 'ስቅለት' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ስቅለት"), {'month': 'ሚያዝያ', 'date': 18});
    });

    test("Testing 'ትንሳኤ' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ትንሳኤ"), {'month': 'ሚያዝያ', 'date': 20});
    });

    test("Testing 'ርክበ ካህናት' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ርክበ ካህናት"), {'month': 'ግንቦት', 'date': 14});
    });

    test("Testing 'ዕርገት' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ዕርገት"), {'month': 'ግንቦት', 'date': 29});
    });

    test("Testing 'ጰራቅሊጦስ' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ጰራቅሊጦስ"), {'month': 'ሰኔ', 'date': 9});
    });

    test("Testing 'ጾመ ሐዋርያት' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ጾመ ሐዋርያት"), {'month': 'ሰኔ', 'date': 10});
    });

    test("Testing 'ጾመ ድህነት' on getSingleBealOrTsom", () {
      expect(bh.getSingleBealOrTsom("ጾመ ድህነት"), {'month': 'ሰኔ', 'date': 12});
    });
  });

  group('Number Convertor', () {
    late List<int> input;
    late List<String> output;
    setUp(() {
      input = [
        1,
        10,
        15,
        20,
        25,
        78,
        105,
        333,
        450,
        600,
        1000,
        1001,
        1010,
        1056,
        1200,
        2013,
        9999,
        10000
      ];
      output = [
        "፩",
        "፲",
        "፲፭",
        "፳",
        "፳፭",
        "፸፰",
        "፻፭",
        "፫፻፴፫",
        "፬፻፶",
        "፮፻",
        "፲፻",
        "፲፻፩",
        "፲፻፲",
        "፲፻፶፮",
        "፲፪፻",
        "፳፻፲፫",
        "፺፱፻፺፱",
        "፻፻"
      ];
    });
    test('Testing Convertor', () {
      for (var i = 0; i < input.length; i++) {
        expect(ConvertToEthiopic(input[i]), output[i]);
      }
    });
  });
}
