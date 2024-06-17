import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda/login.dart';
// import 'package:tienda/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  
  late String email , password;
  // late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('register'),
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
              backgroundImage: const AssetImage('images/0.jpg'),
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
          butonCrearUsuario(),
          TextButton(
            onPressed: () {
              // Acción al presionar el botón de registrarse
            },
            child: Text('Registrarse'),
          ),
          ElevatedButton(
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

  Widget butonCrearUsuario() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          UserCredential? credentials = await crear(email, password);
          if (credentials != null && credentials.user != null) {
            // Verificar si el correo está verificado
            await credentials.user!.sendEmailVerification();
            Navigator.of(context).pop();
          } 
          // else {
          //   setState(() {
          //     error = 'Usuario o contraseña incorrectos';
          //   });
          // }
        }
      },
      child: Text('Ingresar'),
    );
  }

  Future<UserCredential?> crear(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          error = 'el correo ya esta en uso';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          error = 'Contraseña debil';
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