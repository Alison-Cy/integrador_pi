import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Acerca de nosotros'),
      ),
      body: Container(
        width: double.infinity, // Ancho máximo disponible
        height: double.infinity, // Alto máximo disponible
        decoration: BoxDecoration(
          color: Colors.blue, // Color de fondo deseado
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(), // Desactiva el efecto de rebote
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'images/0.jpg', // Ruta de la imagen de Acerca de nosotros
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                _buildParagraph(
                  'Quiénes somos',
                  'Somos una empresa comprometida con la calidad y el servicio al cliente.',
                ),
                SizedBox(height: 16.0),
                _buildParagraph(
                  'Nuestra misión',
                  'Proporcionar productos innovadores que mejoren la vida de nuestros clientes.',
                  icon: Icons.access_alarm, // Asegúrate de que el icono coincida con tus necesidades
                ),
                SizedBox(height: 16.0),
                _buildParagraph(
                  'Nuestros valores',
                  'Integridad, calidad, y satisfacción del cliente son nuestros pilares fundamentales.',
                ),
                SizedBox(height: 16.0), // Espacio adicional al final
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String title, String subtitle, {IconData? icon}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del texto
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 18,
                color: Colors.white, // Color del icono
              ),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Color del texto
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
