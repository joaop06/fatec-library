import 'add_book.dart';
import '../helper/database.dart';
import 'package:flutter/material.dart';
import 'package:fatec_library/components/book.dart';

class BookDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recuperando o livro passado como argumento
    final book = ModalRoute.of(context)!.settings.arguments as Book;

    // Função para retornar o ícone relacionado ao gênero
    IconData _getGenreIcon(String genre) {
      switch (genre) {
        case 'Ficção':
          return Icons.menu_book;
        case 'Não Ficção':
          return Icons.lightbulb;
        case 'Fantasia':
          return Icons.auto_awesome;
        case 'Romance':
          return Icons.favorite;
        case 'Suspense':
          return Icons.theaters;
        case 'Terror':
          return Icons.warning;
        case 'Histórico':
          return Icons.history_edu;
        case 'Ciência':
          return Icons.science;
        case 'Biografia':
          return Icons.person;
        default:
          return Icons.book;
      }
    }

    // Função para excluir o livro
    void _deleteBook(BuildContext context, int id) async {
      await DatabaseHelper.instance.deleteBook(id);
      Navigator.pushNamed(
          context, '/books'); // Voltar para a lista após exclusão
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Livro excluído com sucesso!')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/books'),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destaque para o gênero do livro
            Row(
              children: [
                Icon(
                  _getGenreIcon(book.genre),
                  size: 50,
                  color: Colors.blue,
                ),
                const SizedBox(width: 16),
                Text(
                  book.genre,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Exibição das informações do livro
            const Text(
              'Título:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(book.title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text(
              'Autor:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(book.author, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text(
              'Descrição:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(book.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text(
              'Ano de Publicação:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('${book.year}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            // Botão de excluir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _deleteBook(context, book.id!),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Excluir',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
