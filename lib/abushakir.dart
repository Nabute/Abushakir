// Copyright (c) 2012 ETC or 2020 GC, Nabute and Nahom. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

///
/// Abushakir (Ge'ez: Bahire Hasab) is an arabic word that can be defined as a time-tracking method,
/// devised by the 12th pope of Alexandria, Pope St. Dimitri. St.
///
/// This library can be imported as
///
/// ```
/// import 'package:abushakir/abushakir.dart';
/// ```
///
/// ## Ethiopian Date and Time
///
/// Use [EtDatetime] to represent moment in time.
/// You can also User [Duration] dart built it package to represent time span.
///
/// You can create EtDatetime object using one of the constructors or just by
/// parsing string with the correct format and also from UNIX timestamp.
///
/// ```
/// EtDatetime now = new EtDatetime.now();
/// EtDatetime covid19Confirmed = new EtDatetime(year: 2012, month: 7, day: 4);
///
/// EtDatetime emergencyLockdown = EtDatetime.parse("2012-07-26 23:00:00");
///
/// EtDatetime abushakirPublished = new EtDatetime.fromMillisecondsSinceEpoch(1586257594357)
/// ```
///
/// ## Ethiopian Calendar
///
/// Ethiopic year 1 E.E.3 starts on August 29, 8 C.E. (Julian), our R.D. 2796.
/// According to the definition of the "Ethiopic" calendar in Dershowitz and
/// Reingold's [Calendrical Calculations]
/// <https://www.amazon.com/Calendrical-Calculations-Nachum-Dershowitz/dp/0521702380>,
/// where it's the base calendar for
/// all computations.  See the book for algorithms for converting between
/// Ethiopic ordinals and many other calendar systems.
///
/// This calendar considers Monday as the beginning of the week. It does not do
/// any formatting, the base class, but any one who is working with this library
/// can use the output as the way they want to use.
///
/// You can create Ethiopian Calendar, ETC, object using one of the constructors
///
/// ```
/// ETC ethiopianCalendar = new ETC(year: 2012, month: 7, day: 4);
/// ETC today = ETC.today()
///
/// ```
///
///
/// ## Bahire Hasab
///
/// The words Bahire Hasab originate from the ancient language of Ge'ez,
/// ( Arabic: Abu Shakir) is a time-tracking method, devised by the 12th pope
/// of Alexandria, Pope St. Dimitri. This is the Ge'ez equivalent of Abushakir.
///
/// Bahire Hasab also helps man keep track of time, reminding him of the
/// Fasting seasons, prayer hours and Holidays.
///
/// You can create BahireHasab object using constructor
///
/// ```
/// BahireHasab someRandomYear = BahireHasab(year: 2011);
///
/// // Year parameter is optional. If year is not provided, it will assume the
/// current year.
///
/// BahireHasab thisYear = BahireHasab();
///
/// ```
///
library abushakir;

import 'dart:convert';
import 'package:equatable/equatable.dart';

part 'src/etDateTime.dart';

part 'src/calendar/bahireHasab.dart';

part 'src/utils/constants.dart';

part 'src/utils/calendar_exceptions.dart';

part 'src/utils/convertor.dart';

part 'src/calendar/calendar.dart';

part 'src/calendar/abushakir.dart';
