bool isEmpty(String string) => (string == null || string.isEmpty);

bool isNotEmpty(String string) => (string != null && string.isNotEmpty);

String reverse(String s) => String.fromCharCodes(s.runes.toList().reversed);

String removeLastCharacter(String string) {
  if (isEmpty(string)) {
    return string;
  }
  return substring(string, 0, string.length - 1);
}

String substring(String string, int start, [int end]) {
  //this has to recalculated because of the possible difference in byte length of runes vs string
  final endDif = string.length - (end ?? string.length);
  final runes = string.runes.toList();
  return String.fromCharCodes(runes.sublist(start, runes.length - endDif));
}

String removeFirstCharacter(String string) {
  if (isEmpty(string)) {
    return string;
  }
  return substring(string, 1, string.length);
}

String capitalize(String string) => isNotEmpty(string) ? string[0].toUpperCase() + string.substring(1) : string;

bool isDigit(String string) {
  if (string == null || string.length != 1) {
    return false;
  }

  return int.tryParse(string) != null;
}
