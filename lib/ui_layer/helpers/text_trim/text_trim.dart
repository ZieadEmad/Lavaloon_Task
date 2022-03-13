String textTrim(int maxLenght, String text) {
  if (text == null) {
    return '---';
  }
  if (text.length > maxLenght) {
    return text.replaceRange(maxLenght, text.length, '...');
  } else {
    return text;
  }
}
