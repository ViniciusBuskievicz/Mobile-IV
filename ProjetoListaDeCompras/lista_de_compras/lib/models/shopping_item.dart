class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.name,
    this.isPurchased = false,
  });

  final int id;
  final String name;
  final bool isPurchased;

  // Cria uma nova versão do item sem alterar a instância atual.
  ShoppingItem copyWith({bool? isPurchased}) {
    return ShoppingItem(
      id: id,
      name: name,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }
}
