import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/features/cart/presentation/view/cart_view.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_state.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOOTVAULT",
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () async {
              final userDataResult = await tokenSharedPrefs.getUserData();
              userDataResult.fold(
                (failure) =>
                    print('Failed to get user data: ${failure.message}'),
                (userData) {
                  final userId = userData['userId'];

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: getIt<CartBloc>()
                          ..add(GetCartItemsEvent(userId: userId!)),
                        child: const CartScreen(),
                      ),
                    ),
                  );
                },
              );
            },
            // Navigate to the CartScreen
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BottomNavigationBar(
              items: [
                _buildBarItem(Icons.home, "Home", 0, state.selectedIndex),
                _buildBarItem(
                    Icons.explore, "Discover", 1, state.selectedIndex),
                _buildBarItem(Icons.forum, "Forum", 2, state.selectedIndex),
                _buildBarItem(Icons.person, "Profile", 3, state.selectedIndex),
              ],
              currentIndex: state.selectedIndex,
              onTap: (index) {
                setState(() {
                  context.read<HomeCubit>().onTabTapped(index);
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 10,
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(
      IconData icon, String label, int index, int selectedIndex) {
    final isSelected = selectedIndex == index;
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
