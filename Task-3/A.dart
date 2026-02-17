int dblLinear(int n) {
  List<int> u = [1];
  int i = 0; 
  int j = 0; 
  while (u.length <= n) {
    int y = 2 * u[i] + 1;
    int z = 3 * u[j] + 1;

    if (y < z) {
      u.add(y);
      i++;
    } else if (z < y) {
      u.add(z);
      j++;
    } else {
      u.add(y);
      i++;
      j++;
    }
  }

  return u[n];
}
