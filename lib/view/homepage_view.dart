import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
        title: const Text('Search Bar Sample'),
      ),
      body: Padding(
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

            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              // color: Colors.red,
              child: LayoutBuilder(
                // Use LayoutBuilder to get the parent's constraints

                builder: (BuildContext context, BoxConstraints constraints) {
                  double parentWidth =
                      constraints.maxWidth; // Get the parent's width

                  double parentHeight = constraints.maxHeight;

                  return ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {

                      // item card code
                      return Container(
                        width:
                            parentWidth * 0.4, // Set width to 30% of the parent
                        margin: const EdgeInsets.only(right: 17),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // color: Colors.blue,
                        ),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  height: parentHeight * 0.76,
                                  child: Image.asset(
                                    './assets/images/fb_image.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(6, 4, 0, 0),
                                child: Text("CSGO",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(6, 3, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Ensures the Row takes only the space needed
                                  children: [
                                   
                                 
                                    Text(
                                      "4.7",
                                      style: TextStyle(fontSize: 15.5),
                                    ),
                                       SizedBox(
                                        width:
                                            4), 
                                     Icon(
                                      Icons
                                          .star, 
                                      size: 18, // Adjust size to match text
                                      color:
                                          Colors.amber, // Optional: Add color
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      );
                    },
                  );
                },
              ),
            )

            // *********************************************************GIFT CARD SECTION**************************************

            //skins and game items
          ]),
        ),
      ),
    );
  }
}
