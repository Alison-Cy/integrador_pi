import 'package:flutter/material.dart';
import 'package:tienda/login.dart';
import 'package:tienda/pages/home_screm.dart';
import 'package:tienda/register.dart';
import 'package:tienda/pages/about.dart';
import 'package:tienda/pages/products.dart';// Importar tu pantalla de inicio personalizada

class TabBarContentView extends StatelessWidget {
  final TabController tabController;

  const TabBarContentView({required this.tabController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        Home_screm(),                       // Pestaña 0 (Home)
        Login(),                            // Pestaña 1 (Login)
        Register(),                         // Pestaña 2 (Register)
        Products(),                         // Pestaña 3 (Products)
        About(),                            // Pestaña 4 (About)
      ],
    );
  }
}
