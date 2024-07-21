String capitalizeFirstLetter(String? s) {
  if (s == null && s!.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}
