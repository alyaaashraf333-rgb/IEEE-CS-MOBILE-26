void main(){
    string name="alyaa";
    string lastNmae = "Ashraf";
    string fullName = name + " " + lastNmae;
    int length = fullName.length;
    String sub = fullName.substring(0, 5);
    string upperCaseName = fullNametoUpperCase();
    string lowerCaseName = fullName.toLowerCase();
    print("Full name: $fullName");
    print("Length of full name: $length");
    print("Substring of full name: $sub");
    print("Uppercase name: $upperCaseName");
    print("Lowercase name: $lowerCaseName");    
}
