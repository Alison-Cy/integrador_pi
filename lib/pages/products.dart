import 'package:flutter/material.dart';
import 'package:tienda/pages/about.dart'; // Asegúrate de ajustar la ruta correcta si es necesario

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Color de fondo deseado
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Explora nuestra colección de zapatos',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Encuentra los últimos modelos de Nike, Adidas, Puma y Reebok para todos los estilos y ocasiones.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Número de columnas en la cuadrícula
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildCard('Nike Air Max', 'Zapatillas deportivas Nike Air Max', 'images/0.jpg'),
                    _buildCard('Adidas Ultraboost', 'Zapatillas deportivas Adidas Ultraboost', 'images/0.jpg'),
                    _buildCard('Puma RS-X', 'Zapatillas deportivas Puma RS-X', 'images/0.jpg'),
                    _buildCard('Reebok Classic', 'Zapatillas deportivas Reebok Classic', 'images/0.jpg'),
                    _buildCard('Nike Air Force 1', 'Zapatillas deportivas Nike Air Force 1', 'images/0.jpg'),
                    _buildCard('Adidas Superstar', 'Zapatillas deportivas Adidas Superstar', 'images/0.jpg'),
                    _buildCard('Puma Suede', 'Zapatillas deportivas Puma Suede', 'images/0.jpg'),
                    _buildCard('Reebok Nano X', 'Zapatillas deportivas Reebok Nano X', 'images/0.jpg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String description, String imagePath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
