class StringHandler {
  static String capitalizeFirstLetterOfWord(String text) {
    String convertedText =
        "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
    return convertedText;
  }
}
