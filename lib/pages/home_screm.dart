import 'package:flutter/material.dart';

class Home_screm extends StatefulWidget {
  const Home_screm({Key? key}) : super(key: key);

  @override
  State<Home_screm> createState() => _Home_scremState();
}

class _Home_scremState extends State<Home_screm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Color de fondo deseado
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen de portada con botón en el centro
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/0.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    child: Text('Bienvenidos'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Título
              Text(
                'Bienvenido a la Tienda de Zapatos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Párrafos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'Encuentra los mejores zapatos de Nike, Adidas, Puma y más.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Explora nuestra colección exclusiva para encontrar el estilo perfecto para ti.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Carrusel de imágenes
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('images/0.jpg'),  // Imagen 1 del carrusel
                    Image.asset('images/0.jpg'),  // Imagen 2 del carrusel
                    Image.asset('images/0.jpg'),  // Imagen 3 del carrusel
                    // Agrega más imágenes según sea necesario
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Título de la segunda sección
              Text(
                'Descubre Nuestra Colección',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Párrafo de la segunda sección
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Explora nuestras categorías de zapatos de Nike, Adidas, Puma, y más.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              // Galería de tarjetas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildImageCard(
                      'images/0.jpg',
                      'Nike Air Max',
                      'Zapatillas deportivas de última tecnología.',
                    ),
                    SizedBox(height: 10),
                    _buildImageCard(
                      'images/0.jpg',
                      'Adidas Ultraboost',
                      'Comodidad y estilo en cada paso.',
                    ),
                    SizedBox(height: 10),
                    _buildImageCard(
                      'images/0.jpg',
                      'Puma RS-X',
                      'Diseño retro con tecnología moderna.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath, String title, String description) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
