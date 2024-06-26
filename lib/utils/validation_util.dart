class ValidationUtil {
  static bool validateEmail(String email) {
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);
  }
}
