String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
