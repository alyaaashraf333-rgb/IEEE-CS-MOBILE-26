int potatoes(int p0, int w0, int p1) {
  double dry = w0 * (100 - p0) / 100;
  double w1 = dry * 100 / (100 - p1);
  return w1.floor();
}
