import 'package:flutter/material.dart';
import 'package:tienda/pages/about.dart'; // Asegúrate de ajustar la ruta correcta si es necesario

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Productos'),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Home'),
      //       ),
      //       ListTile(
      //         title: Text('Productos'),
      //         onTap: () {
      //           Navigator.pop(context); // Cierra el Drawer
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Acerca de nosotros'),
      //         onTap: () {
      //           Navigator.pop(context); // Cierra el Drawer
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => About()), // Navega a la página de Acerca de nosotros
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2, // Número de columnas en la cuadrícula
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildCard('Producto 1', 'Descripción del producto 1', 'images/0.jpg'),
            _buildCard('Producto 2', 'Descripción del producto 2', 'images/0.jpg'),
            _buildCard('Producto 3', 'Descripción del producto 3', 'images/0.jpg'),
            _buildCard('Producto 4', 'Descripción del producto 4', 'images/0.jpg'),
            _buildCard('Producto 5', 'Descripción del producto 5', 'images/0.jpg'),
            _buildCard('Producto 6', 'Descripción del producto 6', 'images/0.jpg'),
          ],
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
