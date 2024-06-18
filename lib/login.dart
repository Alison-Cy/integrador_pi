import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda/admin.dart';
import 'package:tienda/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('Inicio de Sesión'),
      //   // Añadir título en la AppBar
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: Text('Opción uno'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Opción dos'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ingresa tus credenciales',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/0.jpg'),
            ),
            Offstage(
              offstage: error == '',
              child: Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  formulario(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formulario() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          builEmail(),
          builPassword(),
          SizedBox(height: 20),
          butonLogin(),
          nuevoAqui(),
        ],
      ),
    );
  }

  Widget builEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        icon: Icon(Icons.email),
      ),
      onSaved: (String? value) {
        email = value!;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese su email';
        }
        return null;
      },
    );
  }

  Widget builPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        icon: Icon(Icons.lock),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        return null;
      },
      onSaved: (String? value) {
        password = value!;
      },
    );
  }

  Widget butonLogin() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          UserCredential? credentials = await login(email, password);
          if (credentials != null && credentials.user != null) {
            // Verificar si el correo está verificado
            if (credentials.user!.emailVerified) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Admin()),
                (Route<dynamic> route) => false,
              );
            } else {
              setState(() {
                error = 'Verifica tu correo antes de acceder';
              });
            }
          }
        }
      },
      child: Text('Ingresar'),
    );
  }

  Widget nuevoAqui() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Nuevo aquí? '),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text('Registrarse'),
        ),
      ],
    );
  }

  Future<UserCredential?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          error = 'Usuario no encontrado';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          error = 'Contraseña incorrecta';
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
