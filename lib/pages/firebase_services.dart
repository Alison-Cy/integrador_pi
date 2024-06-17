import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
Future<List<Map<String, dynamic>>> getProducto() async {
  List<Map<String, dynamic>> productos = [];
  CollectionReference collectionReferenceProductos = db.collection("productos");
  QuerySnapshot querySnapshotProductos = await collectionReferenceProductos.get();
  querySnapshotProductos.docs.forEach((documento) {
    productos.add(documento.data() as Map<String, dynamic>);
  });
  return productos;
}