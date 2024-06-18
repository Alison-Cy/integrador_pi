import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tienda/login.dart';
import 'package:tienda/pages/about.dart';
import 'package:tienda/pages/products.dart';
import 'package:tienda/pages/edit_product.dart';
import 'package:tienda/pages/agregar.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  late Future<List<Map<String, dynamic>>> _productosFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    try {
      final QuerySnapshot querySnapshotProductos =
          await FirebaseFirestore.instance.collection("productos").get();
      setState(() {
        _productosFuture = Future.value(querySnapshotProductos.docs
            .map((documento) => documento.data() as Map<String, dynamic>)
            .toList());
      });
    } catch (e) {
      print("Error al obtener productos: $e");
      setState(() {
        _productosFuture = Future.value([]); // Asignar lista vacía en caso de error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Administración'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Ver Productos'),
                value: 'viewProducts',
              ),
              PopupMenuItem(
                child: Text('Agregar Producto'),
                value: 'addProduct',
              ),
              PopupMenuItem(
                child: Text('Acerca de nosotros'),
                value: 'aboutUs',
              ),
              PopupMenuItem(
                child: Text('Cerrar sesión'),
                value: 'logout',
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'viewProducts':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Products()),
                  );
                  break;
                case 'addProduct':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Agregar()),
                  ).then((value) {
                    if (value != null && value) {
                      _cargarProductos(); // Actualizar productos después de agregar
                    }
                  });
                  break;
                case 'aboutUs':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                  break;
                case 'logout':
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                  break;
                default:
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.blue, // Color de fondo
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _productosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay productos disponibles'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final producto = snapshot.data![index];
                  return Dismissible(
                    key: Key(producto['id'].toString()),
                    background: Container(color: Colors.red),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      bool confirmado = await _mostrarDialogoEliminarProducto(
                        context,
                        producto['id'].toString(),
                      );
                      return confirmado;
                    },
                    child: ListTile(
                      title: Text(producto["nombre"] ?? 'Sin nombre'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(producto["descripcion"] ?? 'Sin descripción'),
                          Text('Categoría: ${producto["categoria"] ?? 'Sin categoría'}'),
                          Text(
                            'Precio: \$${(producto["precio"] as num?)?.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProductPage(producto: producto),
                                ),
                              ).then((value) {
                                if (value != null && value) {
                                  _cargarProductos(); // Actualizar productos después de editar
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _mostrarDialogoEliminarProducto(context, producto['id'].toString());
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Agregar()),
          ).then((value) {
            if (value != null && value) {
              _cargarProductos(); // Actualizar productos después de agregar
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<bool> _mostrarDialogoEliminarProducto(
    BuildContext context,
    String id,
  ) async {
    bool confirmado = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Producto'),
          content: Text('¿Está seguro de que desea eliminar este producto?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                await deleteProducto(id);
                Navigator.of(context).pop(true);
                _cargarProductos(); // Actualizar productos después de eliminar
              },
            ),
          ],
        );
      },
    ).then((value) {
      confirmado = value ?? false;
    });
    return confirmado;
  }

  Future<void> deleteProducto(String uid) async {
    try {
      await FirebaseFirestore.instance.collection("productos").doc(uid).delete();
      print('Producto eliminado: $uid');
    } catch (e) {
      print("Error al eliminar producto: $e");
    }
  }
}
