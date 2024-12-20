import 'package:flutter/material.dart';
import 'package:loot_vault/view/discover_view.dart';
import 'package:loot_vault/view/forum_view.dart';
import 'package:loot_vault/view/homepage_view.dart';
import 'package:loot_vault/view/profile_view.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int pageIndex = 0;

  final List<Widget> pagesList = const [
    HomePageView(),
    DiscoverView(),
    ForumView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOOTVAULT",
        ),
        automaticallyImplyLeading: false,
      ),

      body: pagesList[pageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BottomNavigationBar(
          items: [
            _buildBarItem(Icons.home, "Home", 0),
            _buildBarItem(Icons.explore, "Discover", 1),
            _buildBarItem(Icons.forum, "Forum", 2),
            _buildBarItem(Icons.person, "Profile", 3),
          ],
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(IconData icon, String label, int index) {
    final isSelected = pageIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      label: label,
    );
  }
}
