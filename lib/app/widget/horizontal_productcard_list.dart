import 'package:flutter/material.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/presentation/view/game_detail_view.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    super.key,
    required this.cardData,
  });

  final List<GameEntity> cardData;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight;

    return SizedBox(
      height: screenHeight * (isLandscape ? 0.5 : 0.3),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentWidth = constraints.maxWidth;
          double parentHeight = constraints.maxHeight;

          return ListView.builder(
            itemCount: cardData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final game = cardData[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameDetailView(game: game),
                    ),
                  );
                },
                child: Container(
                
                  width: parentWidth * (isLandscape ? 0.30 : 0.37),
                  margin: EdgeInsets.only(right: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'http://192.168.1.64:3000/public/uploads/${game.gameImagePath}',
                            fit: BoxFit.cover,
                            height: parentHeight * 0.76, // Adjust height dynamically
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 2, 0, 0),
                        child: Text(
                          game.gameName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.attach_money_rounded,
                              color: Colors.green,
                              size: 16.6,
                            ),
                            Text(
                              game.gamePrice.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
