
class ProfileCompleteValidator {
  bool validate(dynamic response) {
    if (response == null) return false;
    if (response['headline'] != null && response['headline'].isNotEmpty) {
      return true;
    }
    return false;
  }
}
