extension HrkString on String {
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    String capitalizedString = substring(0, 1).toUpperCase();
    if (length > 1) {
      capitalizedString += substring(1).toLowerCase();
    }
    return capitalizedString;
  }
}
