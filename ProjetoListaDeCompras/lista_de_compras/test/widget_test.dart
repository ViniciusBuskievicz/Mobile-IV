// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_compras/main.dart';

void main() {
  testWidgets('campo remove números e hífen da entrada', (tester) async {
    await tester.pumpWidget(const ListaDeComprasApp());

    await tester.enterText(find.byKey(const Key('item-input')), 'Arroz 123-kg');

    final textField = tester.widget<TextField>(
      find.byKey(const Key('item-input')),
    );
    expect(textField.controller!.text, 'Arroz kg');

    await tester.tap(find.byKey(const Key('add-item-button')));
    await tester.pumpAndSettle();
    expect(find.text('Arroz kg'), findsOneWidget);
  });

  testWidgets('adiciona item e compartilha estado com o resumo', (
    tester,
  ) async {
    await tester.pumpWidget(const ListaDeComprasApp());

    await tester.enterText(find.byKey(const Key('item-input')), 'Leite');
    await tester.tap(find.byKey(const Key('add-item-button')));
    await tester.pumpAndSettle();

    expect(find.text('Leite'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();

    expect(find.text('1 / 1 itens concluídos'), findsOneWidget);

    await tester.tap(find.text('Minha lista'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Remover Leite'));
    await tester.pumpAndSettle();

    expect(find.text('Leite'), findsNothing);
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();
    expect(find.text('0 / 0 itens concluídos'), findsOneWidget);
  });
}
