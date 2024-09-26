import "book";
void main() {
  Book book1 = Book("The Alchemist", "A", 2019, 50);
  Book book2 = Book("The George Orwell", "P", 2020, 100);
  Book book3 = Book("The Great Gatsby", "F", 2024, 50);
  book1.read(20);
  book2.read(50);
  book3.read(30);
}