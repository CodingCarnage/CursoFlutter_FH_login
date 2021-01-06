bool isNumeric(String value) {
  if (value.isEmpty)
    return false;

  final num tryParseValue = num.tryParse(value);

  return (tryParseValue == null) ? false : true;
}