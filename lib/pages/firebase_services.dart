// Servicio para operaciones CRUD de productos en Firestore

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Obtener todos los productos
Future<List<Map<String, dynamic>>> getProducto() async {
  List<Map<String, dynamic>> productos = [];
  QuerySnapshot querySnapshotProductos =
      await db.collection("productos").get();
  querySnapshotProductos.docs.forEach((documento) {
    productos.add(documento.data() as Map<String, dynamic>);
  });
  return productos;
}

// Agregar un nuevo producto
Future<void> addProducto(Map<String, dynamic> producto) async {
  await db.collection("productos").add(producto);
}

// Actualizar un producto existente
// Actualizar un producto existente
Future<void> updateProducto(String id, Map<String, dynamic> producto) async {
  await db.collection("productos").doc(id).update(producto);
}
// Eliminar un producto existente
Future<void> deleteProducto(String id) async {
  await db.collection("productos").doc(id).delete();
}
