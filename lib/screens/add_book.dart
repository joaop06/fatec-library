import '../helper/database.dart';
import 'package:flutter/material.dart';
import 'package:fatec_library/components/book.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedGenre; // Para armazenar o gênero selecionado

  // Lista de gêneros prefixados
  final List<String> _genres = [
    'Ficção',
    'Não Ficção',
    'Fantasia',
    'Romance',
    'Suspense',
    'Terror',
    'Histórico',
    'Ciência',
    'Biografia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Livro'),
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/books'),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Campo de Título
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o título.';
                    }
                    return null;
                  },
                ),
                // Campo de Autor
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(labelText: 'Autor'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o autor.';
                    }
                    return null;
                  },
                ),
                // Campo de Gênero (Dropdown)
                DropdownButtonFormField<String>(
                  value: _selectedGenre,
                  items: _genres.map((String genre) {
                    return DropdownMenuItem<String>(
                      value: genre,
                      child: Text(genre),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Gênero'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione um gênero.';
                    }
                    return null;
                  },
                ),
                // Campo de Ano de Publicação
                TextFormField(
                  controller: _yearController,
                  decoration:
                      const InputDecoration(labelText: 'Ano de Publicação'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o ano de publicação.';
                    }
                    return null;
                  },
                ),
                // Campo de Descrição
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final book = Book(
                        title: _titleController.text,
                        author: _authorController.text,
                        genre: _selectedGenre ?? 'Outro', // Define o gênero
                        year: int.parse(_yearController.text),
                        description: _descriptionController.text,
                      );
                      DatabaseHelper.instance.insertBook(book);
                      Navigator.pushNamed(context, '/books');
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
