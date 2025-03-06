import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/presentation/view/game_detail_view.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for TokenSharedPrefs
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

// Mock class for CartBloc
class MockCartBloc extends Mock implements CartBloc {}

void main() {
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late MockCartBloc mockCartBloc;

  setUp(() {
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    mockCartBloc = MockCartBloc();

    // Initialize dependency injection
    getIt.allowReassignment = true;
    getIt.registerSingleton<TokenSharedPrefs>(mockTokenSharedPrefs);
    getIt.registerSingleton<CartBloc>(mockCartBloc);
  });

  group('GameDetailView Tests', () {
    testWidgets('should render GameDetailView correctly', (tester) async {
      // Arrange
      const game = GameEntity(
        gameId: '1',
        gameName: 'Test Game',
        gameImagePath: 'test_image_path',
        gamePrice: 19.99,
        gameDescription: 'This is a test game.',
        category: {'categoryName': 'Test Category'},
        gamePlatform: {'platformName': 'Test Platform'},
      );

      when(() => mockTokenSharedPrefs.getUserData())
          .thenAnswer((_) async => const Right({'userId': '1'}));

      // Act
      await tester.pumpWidget(
        BlocProvider<CartBloc>(
          create: (_) => mockCartBloc,
          child: MaterialApp(
            home: GameDetailView(
              game: game,
              platformName: 'Test Platform',
              categoryName: 'Test Category',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Game'), findsNWidgets(2)); // Game name in AppBar and body
      expect(find.text('\$19.99'), findsOneWidget); // Game price
      expect(find.text('This is a test game.'), findsOneWidget); // Game description
      expect(find.text('Test Category'), findsOneWidget); // Category
      expect(find.text('Test Platform'), findsOneWidget); // Platform
      expect(find.text('Add to Cart'), findsOneWidget); // Add to Cart button
    });

    testWidgets('should render game detail text correctly', (tester) async {
      // Arrange
      const game = GameEntity(
        gameId: '1',
        gameName: 'Test Game',
        gameImagePath: 'test_image_path',
        gamePrice: 19.99,
        gameDescription: 'This is a test game.',
        category: {'categoryName': 'Test Category'},
        gamePlatform: {'platformName': 'Test Platform'},
      );

      when(() => mockTokenSharedPrefs.getUserData())
          .thenAnswer((_) async => const Right({'userId': '1'}));

      // Act
      await tester.pumpWidget(
        BlocProvider<CartBloc>(
          create: (_) => mockCartBloc,
          child: MaterialApp(
            home: GameDetailView(
              game: game,
              platformName: 'Test Platform',
              categoryName: 'Test Category',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Game'), findsNWidgets(2)); // Game name in AppBar and body
      expect(find.text('\$19.99'), findsOneWidget); // Game price
      expect(find.text('This is a test game.'), findsOneWidget); // Game description
      expect(find.text('Test Category'), findsOneWidget); // Category
      expect(find.text('Test Platform'), findsOneWidget); // Platform
    });

    testWidgets('should call AddToCartEvent when Add to Cart button is pressed',
        (tester) async {
      // Arrange
      const game = GameEntity(
        gameId: '1',
        gameName: 'Test Game',
        gameImagePath: 'test_image_path',
        gamePrice: 19.99,
        gameDescription: 'This is a test game.',
        category: {'categoryName': 'Test Category'},
        gamePlatform: {'platformName': 'Test Platform'},
      );

      when(() => mockTokenSharedPrefs.getUserData())
          .thenAnswer((_) async => const Right({'userId': '1'}));

      // Act
      await tester.pumpWidget(
        BlocProvider<CartBloc>(
          create: (_) => mockCartBloc,
          child: MaterialApp(
            home: GameDetailView(
              game: game,
              platformName: 'Test Platform',
              categoryName: 'Test Category',
            ),
          ),
        ),
      );

      // Scroll to the button if necessary
      await tester.scrollUntilVisible(find.text('Add to Cart'), 1000);

      // Tap the Add to Cart button
      await tester.tap(find.text('Add to Cart'));
      await tester.pumpAndSettle();

      // Assert
      verify(() => mockCartBloc.add(
            const AddToCartEvent(
              userId: '1',
              productId: '1',
              productName: 'Test Game',
              productPrice: 19.99,
              productImage: 'test_image_path',
              quantity: 1,
            ),
          )).called(1);
    });
  });
}