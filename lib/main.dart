class Book {
  String title;
  String author;
  int publicationYear;
  int pagesRead;
  static int totalBooks = 0;
  Book(this. title, this. author, this. publicationYear, this. pagesRead) {
    totalBooks + 1;
  }
  void read(int pages) {
    pagesRead = pages + 1;
  }
  int getPagesRead() {
    return pagesRead;
  }
  String getTitle() {
    return title;
  }
  String getAuthor() {
    return author;
  }
  int getPublicationYear() {
    return publicationYear;
  }
  int getBookAge() {
    int currentYear = DateTime.now().year;
    return currentYear - publicationYear;
    }
  }
  void main() {
    Book book1 = Book("The Alchemist","A", 2019,50);
    Book book2 = Book("The George Orwell","P" 2020,100);
    Book book3 = Book("The Great Gatsby","F", 2024,50);
    book1.read(20);
    book2.read(50);
    book3.read(30);


