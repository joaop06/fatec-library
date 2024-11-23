import './screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fatec_library/screens/books.dart';
import 'package:fatec_library/screens/add_book.dart';
import 'package:fatec_library/screens/book_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fatec Library',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: DashboardScreen(),
        initialRoute: '/dashboard',
        routes: {
          '/books': (context) => BooksScreen(),
          '/add-book': (context) => AddBookScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/book-details': (context) => BookDetailsScreen(),
        });
  }
}
