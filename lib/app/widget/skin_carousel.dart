import 'package:flutter/material.dart';

class SkinCarousel extends StatelessWidget {
  const SkinCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: (sampleSkins.length / 3).ceil(),
            itemBuilder: (context, columnIndex) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.67,
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      if (columnIndex * 3 + i < sampleSkins.length)
                        Expanded(
                          child: SkinCard(
                            skin: sampleSkins[columnIndex * 3 + i],
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

  static final List<SkinItem> sampleSkins = [
    SkinItem(
      name: 'Dragon Lore',
      game: 'CS:GO',
      category: 'AWP',
      imageUrl:
          'https://i.pinimg.com/736x/eb/2e/a0/eb2ea036577fe13aa4a17ad0400f1525.jpg',
    ),
    SkinItem(
      name: 'Butterfly Fade',
      game: 'CS:GO',
      category: 'Knife',
      imageUrl:
          'https://i.pinimg.com/736x/c8/fb/95/c8fb956a77ae19775b3016544c1b7700.jpg',
    ),
    SkinItem(
      name: 'Asiimov',
      game: 'CS:GO',
      category: 'AK-47',
      imageUrl:
          'https://i.pinimg.com/736x/7d/3f/01/7d3f0142063ba46750dc338ed4a591e0.jpg',
    ),
    SkinItem(
      name: 'Crimson Web',
      game: 'CS:GO',
      category: 'Karambit',
      imageUrl:
          'https://i.pinimg.com/736x/b7/5d/96/b75d967864f0cb8a60ad4e9e4e2e6812.jpg',
    ),
    SkinItem(
      name: 'Fire Serpent',
      game: 'CS:GO',
      category: 'AK-47',
      imageUrl:
          'https://i.pinimg.com/736x/ff/06/bc/ff06bc8bdc2d81389cabd86735d3cf6d.jpg',
    ),
    SkinItem(
      name: 'Howl',
      game: 'CS:GO',
      category: 'M4A4',
      imageUrl:
          'https://i.pinimg.com/736x/c1/65/17/c1651732d5b3a20e7a6ecefa200672f1.jpg',
    ),
    SkinItem(
      name: 'Glacier Web',
      game: 'COD',
      category: 'Karambit',
      imageUrl:
          'https://i.pinimg.com/474x/8d/13/e2/8d13e2693ef5cd6de632ab436a6d133f.jpg',
    ),
    SkinItem(
      name: 'Joker M4',
      game: 'CS:GO',
      category: 'AK-47',
      imageUrl:
          'https://i.pinimg.com/736x/b9/49/0d/b9490db55174c51cb1bd3416b794092d.jpg',
    ),
    SkinItem(
      name: 'Prelude to chaos',
      game: 'Valorant',
      category: 'M4A4',
      imageUrl:
          'https://i.pinimg.com/474x/e5/d9/92/e5d99296bc999aa6836b4a394622022b.jpg',
    ),
  ];
}

class SkinCard extends StatelessWidget {
  final SkinItem skin;

  const SkinCard({
    super.key,
    required this.skin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              skin.imageUrl,
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
                  skin.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${skin.game} • ${skin.category}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                if (skin.size != null || skin.rating != null)
                  Row(
                    children: [
                      if (skin.size != null)
                        Text(
                          skin.size!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      if (skin.size != null && skin.rating != null)
                        const SizedBox(width: 8),
                      if (skin.rating != null) ...[
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          skin.rating!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
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

class SkinItem {
  final String name;
  final String game;
  final String category;
  final String imageUrl;
  final String? size;
  final String? rating;

  SkinItem({
    required this.name,
    required this.game,
    required this.category,
    required this.imageUrl,
    this.size,
    this.rating,
  });
}
