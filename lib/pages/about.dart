import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de nosotros'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
            ],
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
              ),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
