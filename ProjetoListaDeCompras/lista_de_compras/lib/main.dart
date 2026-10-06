import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/shopping_list_page.dart';
import 'pages/summary_page.dart';
import 'providers/shopping_list_provider.dart';

void main() {
  runApp(const ListaDeComprasApp());
}

class ListaDeComprasApp extends StatelessWidget {
  const ListaDeComprasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShoppingListProvider(),
      child: MaterialApp(
        title: 'Lista Express',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 24, 92, 240)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 254, 254),
        ),
        home: const AppShell(),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _pages = [ShoppingListPage(), SummaryPage()];
  static const _titles = ['Minha lista', 'Resumo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            selectedIcon: Icon(Icons.shopping_basket),
            label: 'Minha lista',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Resumo',
          ),
        ],
      ),
    );
  }
}
