import 'dart:io';
void main(){
  stdout.Writeln("enter a number: ");
  int number = int.parse(stdin.readLineSync()!);
  print("the divisors of $number are:");
  for(int i =1; i<=number; i++){
    if(number%i == 0){
      print(i);
    }
  }
}