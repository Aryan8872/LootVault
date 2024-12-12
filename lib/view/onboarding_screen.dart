import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loot_vault/view/register_view.dart';

class OnboardingScreen extends StatefulWidget {

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to LootVault!",
      "subtitle": "Your ultimate virtual marketplace for gamers. Buy, sell, and discover rare in-game items effortlessly.",
      "image": "./assets/images/onboarding_welcome.jpg",
    },
    {
      "title": "Discover a World of Opportunities",
      "subtitle": "Explore a vast collection of in-game treasures, rare collectibles, and exclusive deals curated just for gamers.",
      "image": "./assets/images/onboarding_discover.jpg",
    },
    {
      "title": "Trade with Confidence",
      "subtitle": "Enjoy safe and secure transactions with LootVault's trusted system, ensuring a seamless experience for buyers and sellers.",
      "image": "./assets/images/onboarding_trade.jpg",
    },
    {
      "title": "Connect and Collaborate",
      "subtitle": "Join a vibrant community of gamers to share tips, trade items, and discuss strategies to level up your gaming experience.",
      "image": "./assets/images/onboarding_connect.jpg",
    },
    {
      "title": "Your Vault Awaits",
      "subtitle": "Sign up now and start exploring the LootVault marketplace. Unlock your gaming potential today!",
      "image": "./assets/images/onboarding_vault.jpg",
    },
  ];

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Navigate to the next screen or main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(9,0,9,2),
        child: Column(
        
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => OnboardingPage(
                  title: _onboardingData[index]["title"]!,
                  subtitle: _onboardingData[index]["subtitle"]!,
                  image: _onboardingData[index]["image"]!,
                ),
              ),
            ),
            Row(
        
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
            
                  style:ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: Text("Skip",style: TextStyle(color: Colors.white),),
                ),
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: _currentPage == index ? 16.0 : 8.0,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
                TextButton(
               style:ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: _onNextPressed,
                  child: Text(_currentPage == _onboardingData.length - 1 ? "Done" : "Next",
                  style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          SizedBox(height: 32.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}


