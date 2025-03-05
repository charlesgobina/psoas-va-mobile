// rent extractor
int extractRent(String rent) {
  final regex = RegExp(r'\d+');
  final match = regex.firstMatch(rent);
  if (match != null) {
    return int.parse(match.group(0)!);
  }
  throw const FormatException('No rent found in the provided string');
}

// extraxt apartment size
double extractSize(String size) {
  final regex = RegExp(r'\d+');
  final match = regex.firstMatch(size);
  if (match != null) {
    return double.parse(match.group(0)!);
  }
  throw const FormatException('No size found in the provided string');
}

void main() {
  var size = extractSize('21,00');
  print(size); // 21.0
}