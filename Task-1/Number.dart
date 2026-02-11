void main(){
    string numberString = "123.45";
    double numberStringAsDouble = double.parse(numberString);
    int numberStringAsInt = numberStringAsDouble.toInt();
    print("the string $numberString as a double is $numberStringAsDouble and as an int is $numberStringAsInt");
}
