import 'package:flutter/material.dart';
import 'package:tienda/login.dart';
import 'package:tienda/register.dart';
import 'package:tienda/pages/about.dart';
import 'package:tienda/pages/products.dart';
import 'package:tienda/witgets/app_drawer.dart';
import 'package:tienda/witgets/tab_bar_content_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RedShop'),
      ),
      drawer: AppDrawer(
        tabController: _tabController,
        navigateToPage: _navigateToPage,
      ),
      body: TabBarContentView(
        tabController: _tabController,
      ),
    );
  }
}
