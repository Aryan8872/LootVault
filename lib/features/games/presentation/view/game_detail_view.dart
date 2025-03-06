  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:loot_vault/app/di/di.dart';
  import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
  import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
  import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
  import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
  import 'package:loot_vault/features/games/domain/entity/game_entity.dart';

  class GameDetailView extends StatelessWidget {
    final GameEntity game;
    final String? platformName;
    final String? categoryName;
    final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

    GameDetailView(
        {super.key, required this.game, this.platformName, this.categoryName});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(game.gameName),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'http://192.168.1.64:3000/public/uploads/${game.gameImagePath}',
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder.png', 
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Product Name
              Text(
                game.gameName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Price
              Text(
                '\$${game.gamePrice}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // Category and Platform (if available in game entity)
              Row(
                children: [
                  if (game.category != null)
                    _buildDetailChip(
                      label: (categoryName != null && categoryName!.isNotEmpty)
                          ? categoryName!
                          : game.category?['categoryName']?.toString() ?? 'N/A',
                      icon: Icons.category,
                    ),
                  const SizedBox(width: 10),
                  if (game.gamePlatform != null)
                    _buildDetailChip(
                      label: (platformName != null && platformName!.isNotEmpty)
                          ? platformName!
                          : game.gamePlatform?['platformName']?.toString() ??
                              'N/A',
                      icon: Icons.videogame_asset,
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Description
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                game.gameDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final userDataResult = await tokenSharedPrefs.getUserData();
                    userDataResult.fold(
                      (failure) =>
                          print('Failed to get user data: ${failure.message}'),
                      (userData) {
                        final gameId = game.gameId;
                        if (gameId == null) {
                          showMySnackBar(
                            context: context,
                            message: "Error: Product ID is missing",
                          );
                          return;
                        }

                        final userId = userData['userId'];
                        if (userId == null) {
                          showMySnackBar(
                            context: context,
                            message: "Error: User ID is missing",
                          );
                          return;
                        }

                        final imagePath = game.gameImagePath ?? '';

                        context.read<CartBloc>().add(
                              AddToCartEvent(
                                userId: userId,
                                productId: gameId,
                                productName: game.gameName,
                                productPrice: game.gamePrice.toDouble(),
                                productImage: imagePath,
                                quantity: 1,
                              ),
                            );

                        showMySnackBar(
                          context: context,
                          message: "Successfully added to cart",
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Helper method to build a detail chip
    Widget _buildDetailChip({required String label, required IconData icon}) {
      return Chip(
        label: Text(label),
        avatar: Icon(icon, size: 18),
        backgroundColor: Colors.blue.withOpacity(0.1),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      );
    }
  }
