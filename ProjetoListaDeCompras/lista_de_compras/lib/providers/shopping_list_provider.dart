import 'package:flutter/foundation.dart';

import '../models/shopping_item.dart';

class ShoppingListProvider extends ChangeNotifier {
  final List<ShoppingItem> _items = [];
  int _nextId = 0;

  // A lista não pode ser alterada diretamente pelas telas.
  List<ShoppingItem> get items => List.unmodifiable(_items);
  int get purchasedCount => _items.where((item) => item.isPurchased).length;
  int get pendingCount => _items.length - purchasedCount;

  void adicionar(String name) {
    final cleanedName = name.trim();
    // Mantém a regra mesmo quando a inclusão não vem do campo da tela.
    if (cleanedName.isEmpty || RegExp(r'[0-9-]').hasMatch(cleanedName)) return;

    _items.add(ShoppingItem(id: _nextId++, name: cleanedName));
    notifyListeners();
  }

  void alternarStatus(int id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final item = _items[index];
    _items[index] = item.copyWith(isPurchased: !item.isPurchased);
    notifyListeners();
  }

  void remover(int id) {
    final exists = _items.any((item) => item.id == id);
    if (!exists) return;

    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
