import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loot_vault/core/common/horizontal_productcard_list.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final PageController pageController;

  late final heroSliderTimer;

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

  final List heroSlider = [
    "./assets/images/giftcard1.jpg",
    "./assets/images/giftcard2.jpg",
    "./assets/images/giftcard3.jpg",
    "./assets/images/giftcard4.jpg",
    "./assets/images/giftcard5.jpg",
    "./assets/images/giftcard6.jpg",
    "./assets/images/giftcard7.jpg",
  ];

  final List<String> popularTags = [
    'Action Games',
    'RPG',
    'Adventure',
    'Strategy',
    'Sports'
  ];

  int pageNo = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: heroSlider.length ~/ 2, viewportFraction: 0.85);
    pageNo = heroSlider.length ~/ 2;
    heroSliderTimer = getTimer();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List popularGameData = [
    "call of duty",
    "gta 5",
    "last of us",
    "CSGO",
    "Valorant"
  ];

  final List giftcardData = [
    "./assets/images/giftcard1.jpg",
    "./assets/images/giftcard2.jpg",
    "./assets/images/giftcard3.jpg",
    "./assets/images/giftcard4.jpg",
    "./assets/images/giftcard5.jpg",
    "./assets/images/giftcard6.jpg",
    "./assets/images/giftcard7.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {});
          },
          indicatorColor: Colors.blue,
          backgroundColor: Colors.white,
          height: MediaQuery.of(context).size.height * 0.07,
          elevation: 8,
          shadowColor: Colors.black,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.forum),
              label: 'Forum',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "LOOTVAULT",
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(children: [
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
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
                    hintStyle: const MaterialStatePropertyAll(
                      TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          // isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              // isDark = !isDark;
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

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular Tags',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: popularTags
                            .map(
                              (tag) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: ActionChip(
                                  label: Text(tag),
                                  onPressed: () {
                                    // _searchController.text = tag;
                                    // Implement search functionality
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //***********************************************************HERO BAR*************************************************************

              SizedBox(
                height: 200,
                child: Container(
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
                              content: Text("page no $index"),
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
                                child: Image.asset(
                                  "./assets/images/cod.jpg",
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      );
                    },
                    itemCount: heroSlider.length,
                  ),
                ),
              ),

              // Buttons for sliderr

              const SizedBox(
                height: 12,
              ),
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
                        ))),
              ),

              const SizedBox(
                height: 30,
              ),

              //****************************************BUY GAMES HEADER SECTION*************************************************

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Buy Games",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                    onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        "/popular",
                      )
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //***************************************BUY GAMES CARDS*****************************************************************

              HorizontalProductCard(
                cardData: giftcardData,
                itemName: "csgo",
                price: "2000",
                rating: "4.6",
              ),

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    " Gift Cards",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                    onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        "/popular",
                      )
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              // *********************************************************GIFT CARD SECTION**************************************
              HorizontalProductCard(
                cardData: giftcardData,
                itemName: "csgo",
                price: "2000",
              ),

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    " Most Sold",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                    onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        "/popular",
                      )
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              HorizontalCardList()

              //skins and game items
            ]),
          ),
        ),
      ),
    );
  }
}

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
                    return const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
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
