import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/presentation/view/skin_detail_view.dart';

class SkinCarousel extends StatelessWidget {
  final List<SkinEntity> skins; // Receive skins from API

  const SkinCarousel({super.key, required this.skins});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (skins.length / 3).ceil(),
            itemBuilder: (context, columnIndex) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.67,
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      if (columnIndex * 3 + i < skins.length)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: SkinCard(skin: skins[columnIndex * 3 + i]),
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SkinCard extends StatelessWidget {
  final SkinEntity skin;

  const SkinCard({super.key, required this.skin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: getIt<CartBloc>(),
                child: SkinDetailView(game: skin),
              ),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://192.168.1.64:3000/public/uploads/${skin.skinImagePath}',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    skin.skinName, // API skin name
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '${skin.skinPlatform['platformName'] ?? 'Unknown'} • ${skin.category['categoryName'] ?? 'Unknown'}', // API platform & category
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '\$${skin.skinPrice}', // API price
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}