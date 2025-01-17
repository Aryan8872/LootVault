import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/auth/presentation/view/login_view.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to LootVault!",
      "subtitle":
          "Your ultimate virtual marketplace for gamers. Buy, sell, and discover rare in-game items effortlessly.",
      "image": "./assets/images/onboarding_welcome.jpg",
    },
    {
      "title": "Discover a World of Opportunities",
      "subtitle":
          "Explore a vast collection of in-game treasures, rare collectibles, and exclusive deals curated just for gamers.",
      "image": "./assets/images/onboarding_discover.jpg",
    },
    {
      "title": "Trade with Confidence",
      "subtitle":
          "Enjoy safe and secure transactions with LootVault's trusted system, ensuring a seamless experience for buyers and sellers.",
      "image": "./assets/images/onboarding_trade.jpg",
    },
    {
      "title": "Connect and Collaborate",
      "subtitle":
          "Join a vibrant community of gamers to share tips, trade items, and discuss strategies to level up your gaming experience.",
      "image": "./assets/images/onboarding_connect.jpg",
    },
    {
      "title": "Your Vault Awaits",
      "subtitle":
          "Sign up now and start exploring the LootVault marketplace. Unlock your gaming potential today!",
      "image": "./assets/images/onboarding_vault.jpg",
    },
  ];

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Navigate to the next screen or main app
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: const LoginView(),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(9, 0, 9, 2),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  onboardingCubit.updateCurrentPage(index);
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final item = _onboardingData[index];
                  return OnboardingPage(
                    title: item["title"]!,
                    subtitle: item["subtitle"]!,
                    image: item["image"]!,
                  );
                },
              ),
            ),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        onboardingCubit
                            .skipToLastPage(_onboardingData.length - 1);
                        _pageController.jumpToPage(_onboardingData.length - 1);
                      },
                      child: const Text("Skip",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Row(
                      children: List.generate(
                        _onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: state.currentPage == index ? 16.0 : 8.0,
                          decoration: BoxDecoration(
                            color: state.currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        if (state.currentPage == _onboardingData.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: getIt<LoginBloc>(),
                                child: const LoginView(),
                              ),
                            ),
                          );
                        } else {
                          onboardingCubit.nextPage(_onboardingData.length);
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Text(
                        state.currentPage == _onboardingData.length - 1
                            ? "Get Started"
                            : "Next",
                        style: const TextStyle(
                            color: Colors.white, backgroundColor: Colors.blue),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),
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

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: 32.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
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
