import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tienda/home.dart';
import 'package:tienda/login.dart';
import 'package:tienda/register.dart';
import 'package:tienda/pages/about.dart';
import 'package:tienda/pages/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RedShop',
      
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/products': (context) => Products(),
        '/about': (context) => About(),
      },
    );
  }
}
