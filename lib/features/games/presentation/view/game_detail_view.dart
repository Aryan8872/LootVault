import 'package:flutter/material.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';

class GameDetailView extends StatelessWidget {
  final GameEntity game;

  const GameDetailView({super.key, required this.game});

  void _checkout(BuildContext context) {
    // Implement your checkout logic here
    // For example, add the product to a cart or proceed to payment
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${game.gameName} added to cart!')),
    );
  }

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
              'Description: ${game.gameDescription}', // Assuming you have a description field
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => _checkout(context),
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}