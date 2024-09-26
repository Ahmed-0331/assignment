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
    int currentYear = DateTime. now(). year;
    {Override public int getYearDifference(int publicationYear) { return currentYear - publicationYear; }
    }
  }
  void main() {
    Book book1 = Book("The Alchemist", "Paulo Coelho", 1988, 0);
    Book book2 = Book("1984", "George Orwell", 1949, 0);
    Book book3 = Book("The Great Gatsby", "F. Scott Fitzgerald", 1925, 0);
    book1.read(100);
    book2.read(50);
    book3.read(150);


