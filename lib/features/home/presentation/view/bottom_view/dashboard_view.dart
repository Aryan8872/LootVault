import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/widget/horizontal_productcard_list.dart';
import 'package:loot_vault/app/widget/skin_carousel.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:loot_vault/features/skins/presentation/view_model/skin_bloc.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  late final PageController pageController;
  late final Timer heroSliderTimer;
  int pageNo = 0;

  final List<String> heroSlider = [
    "https://i.pinimg.com/736x/29/c5/48/29c548cfeadcd3dd44458d1ce5be3a0a.jpg",
    "https://xxboxnews.blob.core.windows.net/prod/sites/2/2021/11/Black-Friday-Hero-Image.jpg",
    "https://xxboxnews.blob.core.windows.net/prod/sites/2/2021/02/Xbox-Lunar-New-Year-16x9-NA.jpg",
    "https://media.rockstargames.com/rockstargames/img/global/news/upload/actual_1345843377.jpg",
    "https://2game.com/wp/wp-content/uploads/2022/06/TestBanner1.jpg",
    "https://i.ytimg.com/vi/ILDRSvXJIsM/maxresdefault.jpg",
    "https://www.pcworld.com/wp-content/uploads/2023/07/epic-games-sale-header-image.jpg?quality=50&strip=all&w=1024",
    "https://cdn.europosters.eu/image/hp/106405.jpg",
    "https://sm.ign.com/t/ign_in/screenshot/default/steam_kd57.1280.jpg",
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: heroSlider.length ~/ 2, viewportFraction: 0.85);
    pageNo = heroSlider.length ~/ 2;
    heroSliderTimer = getTimer();
  }

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == heroSlider.length - 1) {
        pageNo = 0;
      }
      pageController.animateToPage(pageNo,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNo++;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    heroSliderTimer.cancel();
    super.dispose();
  }

  Future<void> _onRefresh(BuildContext context) async {
    // Dispatch events to reload games and skins
    context.read<GameBloc>().add(LoadGames());
    context.read<SkinBloc>().add(Loadskins());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(context), // Refresh callback
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Search Bar
                SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      backgroundColor: const WidgetStatePropertyAll(Colors.white),
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      hintText: "Search",
                      hintStyle: const WidgetStatePropertyAll(
                        TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      trailing: <Widget>[
                        Tooltip(
                          message: 'Change brightness mode',
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                // Toggle brightness mode
                              });
                            },
                            icon: const Icon(Icons.wb_sunny_outlined),
                            selectedIcon: const Icon(Icons.brightness_2_outlined),
                          ),
                        ),
                      ],
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Hero Slider
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        pageNo = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: pageController,
                        builder: (context, child) {
                          return child!;
                        },
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Page no $index"),
                              backgroundColor: Colors.green,
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                heroSlider[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: heroSlider.length,
                  ),
                ),

                const SizedBox(height: 12),

                // Slider Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    heroSlider.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.circle,
                        size: 12,
                        color: pageNo == index
                            ? Colors.indigoAccent
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Buy Games Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " Buy Games",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/popular");
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Games List
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.games.isEmpty) {
                      return const Center(child: Text('No games available'));
                    }

                    return HorizontalProductCard(cardData: state.games);
                  },
                ),

                const SizedBox(height: 20),

                // Game Skins Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " Game Skins",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/popular");
                      },
                      child: Text(
                        "See all",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Skins Carousel
                BlocBuilder<SkinBloc, SkinState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.skins.isEmpty) {
                      return const Center(child: Text("No skins available"));
                    }

                    return SkinCarousel(skins: state.skins);
                  },
                ),

                const SizedBox(height: 20),

                // Most Sold Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " Most Sold",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/popular");
                      },
                      child: Text(
                        "See all",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                      ),
                    ),
                  ],
                ),

                // Most Sold List
                 HorizontalCardList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// HorizontalCardList and AppCard widgets remain unchanged
//////////////////////////////////////////////////////////////////most sold////////////////////////////////////////////////////////////////

class HorizontalCardList extends StatelessWidget {
  final List<Map<String, String>> appList = [
    {
      'name': 'Call of Duty',
      'description': 'Category \u2022 Game',
      'rating': '4.3',
      'icon':
          'https://i.pinimg.com/736x/9a/7f/df/9a7fdf2ede9e120a521e01ac102602da.jpg',
    },
    {
      'name': 'The Last Of Us Part II',
      'description': 'Catergory \u2022 Game',
      'rating': '4.6',
      'icon':
          'https://i.pinimg.com/736x/14/e6/d6/14e6d6eceefc5e649463c4e4289ac75b.jpg',
    },
    {
      'name': 'Ghost Of Tshushima',
      'description': 'Catergory \u2022 Game',
      'rating': '4.6',
      'icon':
          'https://i.pinimg.com/736x/aa/65/be/aa65be39f98195b92ee2239b97c9866e.jpg',
    },
  ];

  HorizontalCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: appList.map((app) => AppCard(app: app)).toList(),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Map<String, String> app;

  const AppCard({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Responsive width
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  app['icon']!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    app['name']!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat Bold'),
                  ),
                  Text(
                    app['description']!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'Montserrat Regular'),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        app['rating']!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                    ],
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
