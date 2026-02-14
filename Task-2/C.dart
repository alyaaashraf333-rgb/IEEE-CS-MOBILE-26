int quadrant(int x, int y) {
  if(x > 0 && y>0)
    return 1;
  else if(x<0 && y>0)
    return 2;
  else if(x<0 && y<0)
    return 3;
  else if(x>0 && y<0)
    return 4;
  else
    return 0;
  
}
void main() {
  print(quadrant(1, 1));   
  print(quadrant(-1, 1));  
  print(quadrant(-1, -1));
  print(quadrant(1, -1));  
  print(quadrant(0, 0));  
}