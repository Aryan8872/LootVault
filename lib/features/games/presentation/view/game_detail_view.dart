// features/games/presentation/view/game_detail_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';

class GameDetailView extends StatelessWidget {
  final GameEntity game;
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

  GameDetailView({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.gameName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'http://192.168.1.64:3000/public/uploads/${game.gameImagePath}',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Text(
              game.gameName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${game.gamePrice}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.green,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Description: ${game.gameDescription}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final userDataResult = await tokenSharedPrefs.getUserData();
                  userDataResult.fold(
                    (failure) =>
                        print('Failed to get user data: ${failure.message}'),
                    (userData) {
                      final gameid = game.gameId;
                      final userId = userData['userId'];

                      context.read<CartBloc>().add(
                            AddToCartEvent(
                              userId: userId!,
                              productId: gameid!,
                              productName: game.gameName,
                              productPrice: game.gamePrice.toDouble(),
                              productImage: game.gameImagePath,
                              quantity: 1,
                            ),
                          );
                    },
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
