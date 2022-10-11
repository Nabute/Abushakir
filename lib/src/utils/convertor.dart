///
part of abushakir;

//geezNumbers

List<int> _divide(int denominator, int numinator) {
  return [numinator ~/ denominator, numinator % denominator];
}

String? _convert_1_2_10_to_ethiopic(int num) {
  if (num < 1) {
    throw new EthiopicNumberException(
        "Zero (0) and Negative numbers doesn't exsit in Ethiopic numerals");
  }
  return geezNumbers[num];
}

String? _convert_11_2_100_to_ethiopic(int num) {
  if (num == 100) {
    return geezNumbers[num];
  } else {
    var result = _divide(10, num);
    return result[1] > 0
        ? "${geezNumbers[result[0] * 10]}${geezNumbers[result[1]]}"
        : "${geezNumbers[result[0] * 10]}";
  }
}

String _convert_101_2_1000_to_ethiopic(int num) {
  var result = _divide(100, num);
  if (result[1] == 0) {
    return "${geezNumbers[result[0]]}${geezNumbers[100]}";
  }
  var left = result[0] == 1
      ? "${geezNumbers[100]}"
      : "${geezNumbers[result[0]]}${geezNumbers[100]}";

  var right = result[1] <= 10
      ? _convert_1_2_10_to_ethiopic(result[1])
      : _convert_11_2_100_to_ethiopic(result[1]);

  return "${left}${right}";
}

String? ConvertToEthiopic(int num) {
  if (num.runtimeType != int) {
    throw new TypeError();
  }

  if (num < 1) {
    throw new EthiopicNumberException(
        "Zero (0) and Negative numbers doesn't exsit in Ethiopic numerals");
  }

  if (num > 0 && num <= 10) {
    return _convert_1_2_10_to_ethiopic(num);
  }

  if (num > 10 && num <= 100) {
    return _convert_11_2_100_to_ethiopic(num);
  }

  if (num > 100 && num <= 1000) {
    return _convert_101_2_1000_to_ethiopic(num);
  }

  if (num > 1000 && num <= 10000) {
    var result = _divide(100, num);
    if (result[1] == 0) {
      return result[0] < 11
          ? "${geezNumbers[result[0]]}${geezNumbers[100]}"
          : "${_convert_11_2_100_to_ethiopic(result[0])}${geezNumbers[100]}";
    }
    var left = _convert_11_2_100_to_ethiopic(result[0]);
    var right = result[1] < 11
        ? _convert_1_2_10_to_ethiopic(result[1])
        : _convert_11_2_100_to_ethiopic(result[1]);

    return "${left}${geezNumbers[100]}${right}";
  }
}
