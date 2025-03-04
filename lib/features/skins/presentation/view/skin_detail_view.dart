// features/games/presentation/view/game_detail_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class SkinDetailView extends StatelessWidget {
  final SkinEntity game;
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

  SkinDetailView({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.skinName),
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
                'http://192.168.1.64:3000/public/uploads/${game.skinImagePath}',
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              game.skinName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Price
            Text(
              '\$${game.skinPrice}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            // Category and Platform
            Row(
              children: [
                _buildDetailChip(
                  label: game.category['categoryName'] ?? 'N/A',
                  icon: Icons.category,
                ),
                const SizedBox(width: 10),
                _buildDetailChip(
                  label: game.skinPlatform['platformName'] ?? 'N/A',
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
              game.skinDescription,
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
                      final gameid = game.skinId;
                      final userId = userData['userId'];

                      context.read<CartBloc>().add(
                            AddToCartEvent(
                              userId: userId!,
                              productId: gameid!,
                              productName: game.skinName,
                              productPrice: game.skinPrice.toDouble(),
                              productImage: game.skinImagePath,
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