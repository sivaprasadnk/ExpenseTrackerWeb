extension StringExtension on String {
  String initCap() {
    // return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
