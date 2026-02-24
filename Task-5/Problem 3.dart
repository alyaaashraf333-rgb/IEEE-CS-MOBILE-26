// StudentEvent Interface
abstract class StudentEvent {
  double calcGPA();
  void printInfo();
}

// FullName Class
class FullName {
  String firstName;
  String middleName;
  String lastName;

  FullName(this.firstName, this.middleName, this.lastName);

  String get fullName => "$firstName $middleName $lastName";
}

// Superclass Student
class Student {
  int regNumber;
  FullName fullName;
  List<int> marks;

  Student(this.regNumber, this.fullName, this.marks);
}

// Undergraduate Class
class Undergraduate extends Student implements StudentEvent {
  Undergraduate(int regNumber, FullName fullName, List<int> marks)
    : super(regNumber, fullName, marks);

  @override
  double calcGPA() {
    double totalPoints = 0;

    for (var mark in marks) {
      if (mark >= 90) {
        totalPoints += 12;
      } else if (mark >= 85) {
        totalPoints += 11.5;
      } else if (mark >= 80) {
        totalPoints += 11;
      } else if (mark >= 75) {
        totalPoints += 10;
      } else if (mark >= 70) {
        totalPoints += 9;
      } else if (mark >= 65) {
        totalPoints += 8;
      } else if (mark >= 60) {
        totalPoints += 7;
      } else if (mark >= 56) {
        totalPoints += 6;
      } else if (mark >= 53) {
        totalPoints += 5;
      } else if (mark >= 50) {
        totalPoints += 4;
      } else {
        totalPoints += 0;
      }
    }

    return (totalPoints / marks.length) / 3;
  }

  @override
  void printInfo() {
    print("Undergraduate Student");
    print("ID: $regNumber");
    print("Name: ${fullName.fullName}");
    print("Marks: $marks");
    print("GPA: ${calcGPA().toStringAsFixed(2)}");
  }
}

// Postgraduate Class
class Postgraduate extends Student implements StudentEvent {
  Postgraduate(int regNumber, FullName fullName, List<int> marks)
    : super(regNumber, fullName, marks);

  @override
  double calcGPA() {
    double totalPoints = 0;

    for (var mark in marks) {
      if (mark >= 90) {
        totalPoints += 12;
      } else if (mark >= 85) {
        totalPoints += 11;
      } else if (mark >= 80) {
        totalPoints += 10;
      } else if (mark >= 75) {
        totalPoints += 9;
      } else if (mark >= 70) {
        totalPoints += 8;
      } else if (mark >= 65) {
        totalPoints += 7;
      } else if (mark >= 60) {
        totalPoints += 6;
      } else {
        totalPoints += 0;
      }
    }

    return (totalPoints / marks.length) / 3;
  }

  @override
  void printInfo() {
    print("Postgraduate Student");
    print("ID: $regNumber");
    print("Name: ${fullName.fullName}");
    print("Marks: $marks");
    print("GPA: ${calcGPA().toStringAsFixed(2)}");
  }
}

void main() {
  var name1 = FullName("Alyaa", "Ashraf", "Elnagar");
  var undergrad = Undergraduate(1001, name1, [95, 88, 76]);

  var name2 = FullName("Sara", "Mohamed", "Ali");
  var postgrad = Postgraduate(2001, name2, [85, 78, 92]);

  undergrad.printInfo();
  print("----------------------");
  postgrad.printInfo();
}
