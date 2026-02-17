bool tidyNumber(int n) {
  String numStr = n.toString();

  for (int i = 1; i < numStr.length; i++) {
    if (numStr[i].compareTo(numStr[i - 1]) < 0) {
      return false;
    }
  }

  return true;
}
