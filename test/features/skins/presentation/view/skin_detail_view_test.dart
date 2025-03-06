import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/presentation/view/skin_detail_view.dart';

void main() {
  testWidgets('Category and platform chips are rendered properly',
      (WidgetTester tester) async {
    // Create a SkinEntity object with valid data
    const skinEntity = SkinEntity(
      skinId: '1',
      skinName: 'Test Skin',
      skinImagePath: 'test_image_path.jpg',
      skinPrice: 9.99,
      skinDescription: 'This is a test skin description',
      category: {'categoryName': 'Test Category'},
      skinPlatform: {'platformName': 'Test Platform'},
    );

    // Wrap the SkinDetailView widget with a MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: SkinDetailView(
          game: skinEntity,
          platformName: 'Test Platform',
          categoryName: 'Test Category',
        ),
      ),
    );

    // Check if the category and platform chips are present in the widget tree
    expect(find.text('Test Category'), findsOneWidget);
    expect(find.text('Test Platform'), findsOneWidget);
  });

  testWidgets('Product price is rendered properly',
      (WidgetTester tester) async {
    // Create a SkinEntity object with valid data
    const skinEntity = SkinEntity(
      skinId: '1',
      skinName: 'Test Skin',
      skinImagePath: 'test_image_path.jpg',
      skinPrice: 9.99,
      skinDescription: 'This is a test skin description',
      category: {'categoryName': 'Test Category'},
      skinPlatform: {'platformName': 'Test Platform'},
    );

    // Wrap the SkinDetailView widget with a MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: SkinDetailView(
          game: skinEntity,
          platformName: 'Test Platform',
          categoryName: 'Test Category',
        ),
      ),
    );

    // Check if the product price is present in the widget tree
    expect(find.text('\$9.99'), findsOneWidget);
  });

  testWidgets('Product name is rendered properly', (WidgetTester tester) async {
    // Create a SkinEntity object with valid data
    const skinEntity = SkinEntity(
      skinId: '1',
      skinName: 'Test Skin',
      skinImagePath: 'test_image_path.jpg',
      skinPrice: 9.99,
      skinDescription: 'This is a test skin description',
      category: {'categoryName': 'Test Category'},
      skinPlatform: {'platformName': 'Test Platform'},
    );

    // Wrap the SkinDetailView widget with a MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: SkinDetailView(
          game: skinEntity,
          platformName: 'Test Platform',
          categoryName: 'Test Category',
        ),
      ),
    );

    // Check if the product name is present in the widget tree
    expect(find.text('Test Skin'), findsOneWidget);
  });
}
