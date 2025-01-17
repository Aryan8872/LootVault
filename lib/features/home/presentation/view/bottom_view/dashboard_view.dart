import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loot_vault/app/widget/horizontal_productcard_list.dart';
import 'package:loot_vault/app/widget/skin_carousel.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
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
    "https://i.pinimg.com/736x/40/dd/1f/40dd1ff8dd574aaaeb3e5e9eabffab9c.jpg",
    "https://i.pinimg.com/736x/7f/f0/18/7ff018e5d55e5d537d23ae652d586756.jpg",
    "https://i.pinimg.com/736x/62/2c/d7/622cd7673afb853f034ceaadd690c8b1.jpg",
    "https://i.pinimg.com/736x/33/45/e3/3345e363bc0079349e43fedd2ecf6c5d.jpg",
    "https://i.pinimg.com/736x/7c/02/15/7c0215275347ca42a7d208e3ae596b59.jpg",
    "https://i.pinimg.com/736x/d7/4f/f9/d74ff99b4deb5189b3ea809705912bd7.jpg",
    "https://i.pinimg.com/736x/1d/39/36/1d393626b103b734b93e960ac33dd6c7.jpg"
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
                                child: Image.network(
                                  heroSlider[index],
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
                  Text(
                    "Buy Games",
                    style:
                        Theme.of(context).textTheme.displayMedium!.copyWith(),
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
                cardData: popularGameData,
                itemName: "csgo",
                price: "2000",
                type: "game",
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Gift Cards",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith()),
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
                price: "1225",
                rating: "4.5",
                type: "giftcard",
              ),

              const SizedBox(
                height: 20,
              ),
              ////////////////////////////////////////////////////////skins///////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Game Skins",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith()),
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
                    child: Text(
                      "See all",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //////////////////////////////////////////////////////skins and game items
              const SkinCarousel(),

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Most Sold",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith()),
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
                    child: Text(
                      "See all",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                  )
                ],
              ),

              // most sold
              HorizontalCardList(),
            ]),
          ),
        ),
      ),
    );
  }
}

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
