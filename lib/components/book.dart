class Book {
  int? id;
  String title;
  String author;
  String genre;
  int year;
  String description;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.year,
    required this.description,
  });

  // Convertendo de Map para Book
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      genre: map['genre'],
      year: map['year'],
      description: map['description'],
    );
  }

  // Convertendo de Book para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'year': year,
      'description': description,
    };
  }
}
