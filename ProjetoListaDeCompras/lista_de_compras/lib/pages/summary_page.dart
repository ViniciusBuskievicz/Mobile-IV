import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_list_provider.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingListProvider>(
      builder: (context, shoppingList, _) {
        final total = shoppingList.items.length;
        final progress = total == 0 ? 0.0 : shoppingList.purchasedCount / total;

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Andamento da compra',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(value: progress, minHeight: 10),
            ),
            const SizedBox(height: 10),
            Text('${shoppingList.purchasedCount} / $total itens concluídos'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _CountTile(
                    label: 'Pendentes',
                    count: shoppingList.pendingCount,
                    icon: Icons.radio_button_unchecked,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CountTile(
                    label: 'Comprados',
                    count: shoppingList.purchasedCount,
                    icon: Icons.check_circle_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (total == 0) ...[
              const SizedBox(height: 24),
              const Text(
                'Adicione itens na lista para acompanhar sua compra.',
              ),
            ],
          ],
        );
      },
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });

  final String label;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 16),
          Text('$count', style: Theme.of(context).textTheme.headlineMedium),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
