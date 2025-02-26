import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:loot_vault/features/seller/presentation/view_model/seller_state.dart';


class SellerHomePageView extends StatefulWidget {
  const SellerHomePageView({Key? key}) : super(key: key);

  @override
  State<SellerHomePageView> createState() => _SellerHomePageViewState();
}

class _SellerHomePageViewState extends State<SellerHomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOOTVAULT SELLER",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<SellerCubit, SellerState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      floatingActionButton: BlocBuilder<SellerCubit, SellerState>(
        builder: (context, state) {
          // Only show FAB on manage products page
          return state.selectedIndex == 2
              ? FloatingActionButton(
                  onPressed: () {
                    // Navigate to add product directly
                    context.read<SellerCubit>().onTabTapped(1);
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                )
              : const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<SellerCubit, SellerState>(
        builder: (context, state) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BottomNavigationBar(
              items: [
                _buildBarItem(Icons.dashboard, "Dashboard", 0, state.selectedIndex),
                _buildBarItem(Icons.add_circle, "Add Product", 1, state.selectedIndex),
                _buildBarItem(Icons.inventory, "Products", 2, state.selectedIndex),
                _buildBarItem(Icons.person, "Profile", 3, state.selectedIndex),
              ],
              currentIndex: state.selectedIndex,
              onTap: (index) {
                setState(() {
                  context.read<SellerCubit>().onTabTapped(index);
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