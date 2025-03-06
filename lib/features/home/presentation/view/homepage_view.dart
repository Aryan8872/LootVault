import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/cart/presentation/view/cart_view.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_state.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter/foundation.dart' as foundation;

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();
  StreamSubscription<dynamic>? _proximitySubscription;
  bool _isNear = false;
  bool _isProximityActionAllowed = true;

  @override
  void initState() {
    super.initState();
    _startProximitySensor();
  }

  Future<void> _startProximitySensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    await ProximitySensor.setProximityScreenOff(true).onError((error, stackTrace) {
      if (foundation.kDebugMode) {
        debugPrint("Could not enable screen off functionality");
      }
      return null;
    });

    _proximitySubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });

      if (_isProximityActionAllowed && _isNear) {
        _logout();
      }
    });
  }

  void _logout() {
    _isProximityActionAllowed = false;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logging out...'),
          duration: Duration(seconds: 2),
        ),
      );

      context.read<HomeCubit>().logout(context);
    }

    Future.delayed(const Duration(seconds: 2), () {
      _isProximityActionAllowed = true;
    });
  }

  @override
  void dispose() {
    _proximitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOOTVAULT"),
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
          ),
          IconButton(
              onPressed: () {
                context.read<HomeCubit>().logout(context);
                showMySnackBar(context: context, message: "Logging out");
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return state.views.elementAt(state.selectedIndex);
              },
            ),
          ),
        ],
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
