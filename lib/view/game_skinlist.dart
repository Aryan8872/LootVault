import 'package:flutter/material.dart';

class GameSkinsList extends StatelessWidget {
  final List<GameSkinItem> skins;

  const GameSkinsList({
    super.key,
    required this.skins,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.black, // Dark background like Play Store
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suggested for You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100, // Fixed height for the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: skins.length,
              itemBuilder: (context, index) {
                final skin = skins[index];
                return GameSkinCard(skin: skin);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GameSkinCard extends StatelessWidget {
  final GameSkinItem skin;

  const GameSkinCard({
    super.key,
    required this.skin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              skin.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 64,
                  height: 64,
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  skin.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      skin.game,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      ' • ',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      skin.category,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '\$${skin.price}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    if (skin.rating != null) ...[
                      const SizedBox(width: 12),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        skin.rating!,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameSkinItem {
  final String name;
  final String game;
  final String category;
  final String imageUrl;
  final String price;
  final String? rating;

  GameSkinItem({
    required this.name,
    required this.game,
    required this.category,
    required this.imageUrl,
    required this.price,
    this.rating,
  });
}

// Example usage:
class ExampleScreen extends StatelessWidget {
  ExampleScreen({super.key});

  final List<GameSkinItem> sampleSkins = [
    GameSkinItem(
      name: 'Dragon Lore AWP',
      game: 'CS:GO',
      category: 'Sniper Rifle',
      imageUrl: 'https://example.com/awp-dragon-lore.jpg',
      price: '1,499.99',
      rating: '4.9',
    ),
    GameSkinItem(
      name: 'Butterfly Knife | Fade',
      game: 'CS:GO',
      category: 'Knife',
      imageUrl: 'https://example.com/butterfly-fade.jpg',
      price: '899.99',
      rating: '4.8',
    ),
    GameSkinItem(
      name: 'AK-47 | Asiimov',
      game: 'CS:GO',
      category: 'Rifle',
      imageUrl: 'https://example.com/ak-asiimov.jpg',
      price: '299.99',
      rating: '4.7',
    ),
    GameSkinItem(
      name: 'Karambit | Crimson Web',
      game: 'CS:GO',
      category: 'Knife',
      imageUrl: 'https://example.com/karambit-crimson.jpg',
      price: '799.99',
      rating: '4.9',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameSkinsList(skins: sampleSkins),
    );
  }
}