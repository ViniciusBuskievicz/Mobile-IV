import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/shopping_item.dart';
import '../providers/shopping_list_provider.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _adicionarItem() {
    context.read<ShoppingListProvider>().adicionar(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'O que Comprar?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('item-input'),
                  controller: _controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[0-9-]')),
                  ],
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _adicionarItem(),
                  decoration: const InputDecoration(
                    hintText: 'Ex.: leite, pão, frutas',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                key: const Key('add-item-button'),
                tooltip: 'Adicionar item',
                onPressed: _adicionarItem,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(fixedSize: const Size(56, 56)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Consumer<ShoppingListProvider>(
              builder: (context, shoppingList, _) {
                if (shoppingList.items.isEmpty) {
                  return const _EmptyList();
                }

                return ListView.separated(
                  itemCount: shoppingList.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final item = shoppingList.items[index];
                    return _ShoppingItemTile(item: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoppingItemTile extends StatelessWidget {
  const _ShoppingItemTile({required this.item});

  final ShoppingItem item;

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.read<ShoppingListProvider>();

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => shoppingList.remover(item.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(Icons.delete_outline, color: Color.fromARGB(255, 255, 255, 255)),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: CheckboxListTile(
          value: item.isPurchased,
          onChanged: (_) => shoppingList.alternarStatus(item.id),
          title: Text(
            item.name,
            style: TextStyle(
              decoration: item.isPurchased ? TextDecoration.lineThrough : null,
              color: item.isPurchased
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : null,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          secondary: IconButton(
            tooltip: 'Remover ${item.name}',
            onPressed: () => shoppingList.remover(item.id),
            icon: const Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Sua lista está vazia',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Adicione o primeiro item acima.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
