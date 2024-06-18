import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Agregar extends StatefulWidget {
  const Agregar({Key? key}) : super(key: key);

  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  Future<void> _agregarProducto() async {
    try {
      await FirebaseFirestore.instance.collection("productos").add({
        "nombre": _nombreController.text,
        "descripcion": _descripcionController.text,
        "categoria": _categoriaController.text,
        "precio": double.parse(_precioController.text),
      });
      // Limpiar los campos después de agregar el producto
      _nombreController.clear();
      _descripcionController.clear();
      _categoriaController.clear();
      _precioController.clear();

      // Mostrar mensaje de éxito o navegar a la pantalla anterior
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado correctamente')),
      );

      // Notificar a la pantalla anterior para actualizar la lista de productos
      Navigator.of(context).pop(true);
    } catch (e) {
      print("Error al agregar producto: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar nuevo producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del producto'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción del producto'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: 'Categoría del producto'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: 'Precio del producto'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarProducto,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
