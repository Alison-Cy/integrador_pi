import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final TabController tabController;
  final Function(int) navigateToPage;

  const AppDrawer({
    required this.tabController,
    required this.navigateToPage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                navigateToPage(0); // Navega a la primera pestaña (Home)
              },
              child: Text(
                'RedShop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Login'),
            onTap: () {
              Navigator.pop(context);
              navigateToPage(1); // Navega a la pestaña de Login
            },
          ),
          ListTile(
            title: Text('Register'),
            onTap: () {
              Navigator.pop(context);
              navigateToPage(2); // Navega a la pestaña de Register
            },
          ),
          ListTile(
            title: Text('Productos'),
            onTap: () {
              Navigator.pop(context);
              navigateToPage(3); // Navega a la pestaña de Productos
            },
          ),
          ListTile(
            title: Text('Acerca de nosotros'),
            onTap: () {
              Navigator.pop(context);
              navigateToPage(4); // Navega a la pestaña de Acerca de nosotros
            },
          ),
        ],
      ),
    );
  }
}