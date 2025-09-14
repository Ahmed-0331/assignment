
//Problem 1 Code

class Book {
  String title;
  String author;
  double price;
  // Constructor
  Book(this.title, this.author, this.price);
  // Method: Calculate discounted price
  double discountedPrice(double discountPercent) {
    return price - (price * discountPercent / 100);
  }
  // Method: Print book details
  void displayDetails(double discountPercent) {
    print("Book Title: $title");
    print("Author: $author");
    print("Original Price: \$${price.toStringAsFixed(2)}");
    print("Discounted Price (${discountPercent}% off): \"
    "${discountedPrice(discountPercent).toStringAsFixed(2)}");


    print("--------------------------------------------------");
  }
}
void main() {
  // Create two Book objects
  Book book1 = Book("The Alchemist", "Paulo Coelho", 500);
  Book book2 = Book("Atomic Habits", "James Clear", 800);
  // Print their details with discounts
  book1.displayDetails(10); // 10% discount
  book2.displayDetails(20); // 20% discount
}

//Problem 2 Code

class Employee {
  String name;
  double salary;
  Employee(this.name, this.salary);
}
class Manager extends Employee {
  String department;
  Manager(String name, double salary, this.department) : super(name, salary);
  void displayInfo() {
    print("Manager Name: $name");
    print("Salary: \$${salary.toStringAsFixed(2)}");
    print("Department: $department");


    print("--------------------------------------------------");
  }
}
class Developer extends Employee {
  String programmingLanguage;
  Developer(String name, double salary, this.programmingLanguage)
      : super(name, salary);
  void displayInfo() {
    print("Developer Name: $name");
    print("Salary: \$${salary.toStringAsFixed(2)}");
    print("Programming Language: $programmingLanguage");


    print("--------------------------------------------------");
  }
}
void main() {
  // Create one Manager and one Developer
  Manager manager = Manager("Alice", 75000, "Human Resources");
  Developer developer = Developer("Bob", 60000, "Dart/Flutter");
  // Display their details
  manager.displayInfo();
  developer.displayInfo();
}

//Problem 3 Code

// Abstract class Appliance
abstract class Appliance {
  void turnOn();
  void turnOff();
}
// Fan subclass
class Fan extends Appliance {
  @override
  void turnOn() {
    print("Fan is now running...");
  }
  @override
  void turnOff() {
    print("Fan is switched off.");
  }
}
// Light subclass
class Light extends Appliance {
  @override
  void turnOn() {
    print("Light is now switched on.");
  }

  @override
  void turnOff() {
    print("Light is switched off.");
  }
}
void main() {
  // Create one Fan and one Light object
  Fan fan = Fan();
  Light light = Light();

  // Call their methods
  fan.turnOn();
  fan.turnOff();

  light.turnOn();
  light.turnOff();
}

