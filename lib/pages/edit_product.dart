import 'package:flutter/material.dart';
import 'package:tienda/pages/firebase_services.dart'; // Importar el archivo de servicios de Firebase

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> producto;

  const EditProductPage({Key? key, required this.producto}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _categoriaController = TextEditingController();
  TextEditingController _precioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.producto["nombre"] ?? '';
    _descripcionController.text = widget.producto["descripcion"] ?? '';
    _categoriaController.text = widget.producto["categoria"] ?? '';
    _precioController.text = (widget.producto["precio"] as num?)?.toString() ?? '';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _categoriaController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _guardarEdicion(context);
                  },
                  child: Text('Guardar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _mostrarDialogoEliminar(context);
                  },
                  style: ElevatedButton.styleFrom(shadowColor: Colors.red),
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarEdicion(BuildContext context) async {
    final String id = widget.producto["id"].toString();
    final String nombre = _nombreController.text.trim();
    final String descripcion = _descripcionController.text.trim();
    final String categoria = _categoriaController.text.trim();
    final double precio = double.tryParse(_precioController.text.trim()) ?? 0.0;

    final Map<String, dynamic> productoActualizado = {
      "nombre": nombre,
      "descripcion": descripcion,
      "categoria": categoria,
      "precio": precio,
    };

    try {
      await updateProducto(id, productoActualizado); // Llamar a la función de actualización
      print('Producto actualizado: $id');
      Navigator.pop(context); // Volver a la pantalla anterior
    } catch (e) {
      print("Error al actualizar producto: $e");
      // Manejar el error según sea necesario
    }
  }

  Future<void> _mostrarDialogoEliminar(BuildContext context) async {
    final String id = widget.producto["id"].toString();

    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Producto'),
        content: Text('¿Está seguro de que desea eliminar este producto?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await deleteProducto(id); // Llamar a la función de eliminación
                print('Producto eliminado: $id');
                Navigator.of(context).pop(true);
                Navigator.pop(context); // Volver a la pantalla anterior
              } catch (e) {
                print("Error al eliminar producto: $e");
                // Manejar el error según sea necesario
              }
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
