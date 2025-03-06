import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_bloc.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_event.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_state.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        elevation: 0,
      ),
      body: BlocProvider.value(
        value: getIt<SearchBloc>(),
        child: const DiscoverContent(),
      ),
    );
  }
}

class DiscoverContent extends StatelessWidget {
  const DiscoverContent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    double? minPrice;
    double? maxPrice;

    void triggerSearch() {
      context.read<SearchBloc>().add(SearchQueryChanged(
            query: searchController.text,
            minPrice: minPrice,
            maxPrice: maxPrice,
            sortBy: 'gamePrice', // Default to 'gamePrice'
            order: 'asc', // Default to 'asc'
            type: 'both', // Default to 'both'
          ));
    }

    void showFilterDialog(BuildContext context) {
      final TextEditingController minPriceController = TextEditingController(
        text: minPrice?.toString() ?? '',
      );
      final TextEditingController maxPriceController = TextEditingController(
        text: maxPrice?.toString() ?? '',
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Filter Options'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text('Price Range'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minPriceController,
                          decoration: const InputDecoration(
                            labelText: 'Min',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: maxPriceController,
                          decoration: const InputDecoration(
                            labelText: 'Max',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  minPrice = double.tryParse(minPriceController.text);
                  maxPrice = double.tryParse(maxPriceController.text);
                  triggerSearch();
                  Navigator.pop(context);
                },
                child: const Text('APPLY'),
              ),
            ],
          );
        },
      ).then((_) {
        minPriceController.dispose();
        maxPriceController.dispose();
      });
    }

    return Column(
      children: [
        // Search Bar Area
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Row(
            children: [
              // Search Field
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    ),
                    onSubmitted: (_) => triggerSearch(),
                  ),
                ),
              ),
              // Filter Button
              Container(
                margin: const EdgeInsets.only(left: 8),
                height: 48,
                width: 48,
                child: Material(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => showFilterDialog(context),
                    child: const Icon(Icons.filter_list),
                  ),
                ),
              ),
              // Search Button
              Container(
                margin: const EdgeInsets.only(left: 8),
                height: 48,
                width: 100,
                child: ElevatedButton(
                  onPressed: triggerSearch,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        ),

        // Content Area
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (!state.isLoading &&
                  (state.games.isNotEmpty || state.skins.isNotEmpty)) {
                return ListView(
                  children: [
                    // Games Section
                    if (state.games.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          'Games',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      LimitedBox(
                        maxHeight: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.games.length,
                          itemBuilder: (context, index) {
                            final game = state.games[index];
                            return _GameCard(game: game);
                          },
                        ),
                      ),
                    ],

                    // Skins Section
                    if (state.skins.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(
                          'Skins',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      LimitedBox(
                        maxHeight: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.skins.length,
                          itemBuilder: (context, index) {
                            final skin = state.skins[index];
                            return _SkinCard(skin: skin);
                          },
                        ),
                      ),
                    ],
                  ],
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'No games or skins found.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _GameCard extends StatelessWidget {
  final GameEntity game;

  const _GameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  '${ApiEndpoints.ImagebaseUrl}${game.gameImagePath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            game.gameName,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            game.gameDescription,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SkinCard extends StatelessWidget {
  final SkinEntity skin;

  const _SkinCard({required this.skin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  '${ApiEndpoints.ImagebaseUrl}${skin.skinImagePath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            skin.skinName,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            skin.skinDescription,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
