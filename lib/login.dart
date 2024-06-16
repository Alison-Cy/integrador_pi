import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar '),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Opción uno'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Opción dos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('images/0.jpg'), // Coloca la imagen de perfil
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de ingresar
                    },
                    child: Text('Ingresar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Acción al presionar el botón de registrarse
                    },
                    child: Text('Registrarse'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
