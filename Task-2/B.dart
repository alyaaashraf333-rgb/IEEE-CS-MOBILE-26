String getMiddle(String s) {
  int length = s.length;
  int middle = length ~/ 2;

  if (length % 2 == 0) {
  
    return s.substring(middle - 1, middle + 1);
  } else {
    
    return s.substring(middle, middle + 1);
  }
}

void main() {
  print(getMiddle("test"));     
  print(getMiddle("testing")); 
  print(getMiddle("middle"));   
  print(getMiddle("A"));        
}
