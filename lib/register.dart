import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tienda/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/0.jpg'),
            ),
            SizedBox(height: 10),
            Offstage(
              offstage: error.isEmpty,
              child: Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                    onSaved: (value) => email = value!,
                    validator: (value) =>
                        value!.isEmpty ? 'Por favor ingrese su email' : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Por favor ingrese su contraseña' : null,
                    onSaved: (value) => password = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        UserCredential? credentials =
                            await crearUsuario(email, password);
                        if (credentials != null && credentials.user != null) {
                          // Verificar si el correo está verificado
                          await credentials.user!.sendEmailVerification();
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text('Registrarse'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text('Ir a Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> crearUsuario(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          error = 'El correo ya está en uso';
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          error = 'La contraseña es demasiado débil';
        });
      } else {
        setState(() {
          error = 'Error de autenticación: ${e.message}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error desconocido: $e';
      });
    }
    return null;
  }
}
