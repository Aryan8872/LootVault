import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loot_vault/widgets/horizontal_productcard_list.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1),
   
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(children: [
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    backgroundColor: const MaterialStatePropertyAll(Colors.white),
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
                          isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
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
              Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height * 0.23
                    : null,
                decoration: const BoxDecoration(),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(right: 6),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          './assets/images/fb_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: popularGameData.length,
                  scrollDirection: Axis.horizontal,
                ),
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
                        color: Colors.blue,
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
        
              SizedBox(
                height: 10,
              ),
        
              //***************************************BUY GAMES CARDS*****************************************************************
        
             
            HorizontalProductCard(cardData: giftcardData,itemName: "csgo",price: "2000",rating: "4.6",),
        
              SizedBox(
                height: 30,
              ),
        
        
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    " Gift Cards",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
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
        
              SizedBox(height: 10,),
        
        
             
        
              // *********************************************************GIFT CARD SECTION**************************************
            HorizontalProductCard(cardData: giftcardData,itemName: "csgo",price: "2000",),
        
              //skins and game items
            ]),
          ),
        ),
      ),
    );
  }
}
