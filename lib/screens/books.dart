import './add_book.dart';
import '../components/book.dart';
import '../helper/database.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late Future<List<Book>> _books;

  @override
  void initState() {
    super.initState();
    _books = DatabaseHelper.instance.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros Cadastrados'),
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder<List<Book>>(
        future: _books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar livros.'));
          }

          final books = snapshot.data ?? [];
          return books.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Nenhum livro cadastrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Card(
                      child: ListTile(
                        onTap: () => {
                          Navigator.pushNamed(context, '/book-details',
                              arguments: book)
                        },
                        title: Text('Título: ${book.title}'),
                        subtitle: Text('Autor: ${book.author}'),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
