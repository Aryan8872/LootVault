import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loot_vault/widgets/horizontal_productcard_list.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final PageController pageController;

  late final heroSliderTimer ;

  Timer getTimer(){
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if(pageNo == heroSlider.length-1){
        pageNo=0;
      }
      pageController.animateToPage(pageNo, duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
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

    int pageNo = 0;

    @override
  void initState() {

    super.initState();
    pageController = PageController(
      initialPage:heroSlider.length~/2,
      viewportFraction: 0.85
    );
    pageNo=heroSlider.length~/2;
    heroSliderTimer =getTimer();              

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
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1),
      appBar: AppBar(
        title: Text(
          "LOOTVAULT",
          style: GoogleFonts.poppins(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
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
                      builder: (context, child)  {
                      return child!;
                    },
                    child:GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:  Text("page no $index"),backgroundColor: Colors.green,));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset("./assets/images/cod.jpg",fit: BoxFit.cover,)
                          ),
                      ),
                    ) ,
                    );

                  },
                  
                  itemCount: heroSlider.length, 
                  
                  ),
                ),
              ),

              // Buttons for sliderr

              const SizedBox(height: 12,),
              Row(
              
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(heroSlider.length, (index) => 
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child:  Icon(Icons.circle,size: 12,
                  color: pageNo == index? Colors.indigoAccent:Colors.grey,
                  )
                  )
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

              SizedBox(
                height: 10,
              ),

              //***************************************BUY GAMES CARDS*****************************************************************

              HorizontalProductCard(
                cardData: giftcardData,
                itemName: "csgo",
                price: "2000",
                rating: "4.6",
              ),

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
      'name': 'Google',
      'description': 'Google LLC \u2022 Communication \u2022 Tools',
      'rating': '4.3',
      'size': '75 MB',
      'icon': 'https://www.gstatic.com/images/branding/product/1x/google_g_64dp.png',
    },
    {
      'name': 'Google Pay',
      'description': 'Google LLC \u2022 Finance \u2022 Digital wallets',
      'rating': '4.6',
      'size': '83 MB',
      'icon': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Google_Pay_Logo.svg/512px-Google_Pay_Logo.svg.png',
    },
    {
      'name': 'Discord',
      'description': 'Discord Inc \u2022 Communication \u2022 Chat',
      'rating': '4.6',
      'size': '33 MB',
      'icon': 'https://upload.wikimedia.org/wikipedia/commons/9/98/Discord_logo.svg',
    },
  ];

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

  AppCard({required this.app});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Responsive width
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                app['icon']!,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  // Display a placeholder image if the image fails to load
                  return Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    app['name']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    app['description']!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        app['rating']!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        app['size']!,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
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
