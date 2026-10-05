void adicionarItem(String item, List<String> listDeCompras) {
  listDeCompras.add(item);
  print("Item '$item' adicionado à lista de compras.");
}

void removerItem(String item, List<String> listDeCompras) {
  listDeCompras.remove(item);
  print("Item '$item' removido da lista de compras.");
}

void listarItens(List<String> listDeCompras) {
  print("Itens na lista de compras:");
  for (var item in listDeCompras) {
    print("- $item");
  }
}


void main() {
  List<String> listDeCompras = [];

  adicionarItem("Maçã", listDeCompras);
  adicionarItem("Banana", listDeCompras);
  adicionarItem("Laranja", listDeCompras);

  listarItens(listDeCompras);

  removerItem("Banana", listDeCompras);

  listarItens(listDeCompras);
}