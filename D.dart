import 'dart:io';

void main(){
    stdout.writeln("enter a number:");
    String? input = stdin.readLineSync();
    if(input != null){
        String reversedInput = input.split(" ").reversed.join(" ");
        if(input == reversedInput){
            print("$input input is a palindrome.");
        } else {
            print("$input  is not a palindrome.");
        }
    }else{
        print("No input provided.");
    }
}