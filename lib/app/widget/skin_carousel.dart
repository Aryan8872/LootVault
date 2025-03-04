import 'package:flutter/material.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

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
                          child: SkinCard(skin: skins[columnIndex * 3 + i]),
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
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'http://192.168.1.64:3000/public/uploads/${skin.skinImagePath}',
              width: 88,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  skin.skinName, // API skin name
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${skin.skinPlatform['platformName']} • ${skin.category['categoryName']}', // API platform & category
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${skin.skinPrice}', // API price
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
