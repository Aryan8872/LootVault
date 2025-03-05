import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/cart/presentation/view/cart_view.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_state.dart';
import 'dart:async';
import 'dart:math';

class GyroscopeLogoutManager {
  // Configuration constants
  static const double CIRCULAR_ROTATION_THRESHOLD = 5.0; // Radians per second for circular motion
  static const int COOLDOWN_PERIOD = 7; // Seconds between logout attempts

  // State tracking variables
  DateTime? _lastLogoutTime;
  double _totalRotation = 0.0;

  void startListening(BuildContext context, VoidCallback logoutAction) {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      _detectCircularRotation(context, event, logoutAction);
    });
  }

  void _detectCircularRotation(
    BuildContext context, 
    GyroscopeEvent event, 
    VoidCallback logoutAction
  ) {
    final now = DateTime.now();

    // Check cooldown period
    if (_lastLogoutTime != null && 
        now.difference(_lastLogoutTime!).inSeconds < COOLDOWN_PERIOD) {
      return;
    }

    // Calculate the magnitude of rotation
    final rotationMagnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

    // Accumulate total rotation
    _totalRotation += rotationMagnitude;

    // Trigger logout if total rotation exceeds threshold
    if (_totalRotation >= CIRCULAR_ROTATION_THRESHOLD) {
      logoutAction();
      
      // Reset tracking and record logout time
      _totalRotation = 0.0;
      _lastLogoutTime = now;
    }
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();
  late GyroscopeLogoutManager _gyroscopeLogoutManager;
  
  // Gyroscope debug variables
  double _currentRotationMagnitude = 0.0;

  // Stream subscription to manage gyroscope events
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  // Flag to check if gyroscope is available
  bool _isGyroscopeAvailable = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize gyroscope logout manager
    _gyroscopeLogoutManager = GyroscopeLogoutManager();
    
    // Check gyroscope availability and start listening
    _initializeGyroscope();
  }

  void _initializeGyroscope() {
    try {
      // Start listening for gyroscope events with error handling
      _gyroscopeSubscription = gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          // Only update state if the widget is still mounted
          if (mounted) {
            setState(() {
              // Update rotation magnitude
              _currentRotationMagnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
              
              // Mark gyroscope as available
              _isGyroscopeAvailable = true;
            });
          }
        },
        onError: (error) {
          // Handle potential sensor errors
          print('Gyroscope Error: $error');
          setState(() {
            _isGyroscopeAvailable = false;
          });
        },
        cancelOnError: false,
      );
    
    // Start listening for logout conditions
    _gyroscopeLogoutManager.startListening(
      context, 
      () {
        // Perform logout
        context.read<HomeCubit>().logout(context);
        
        // Show logout notification
        showMySnackBar(
          context: context, 
          message: "Logged out via circular rotation", 
          color: Colors.red
        );
      }
    );
    } catch (e) {
      print('Failed to initialize gyroscope: $e');
      setState(() {
        _isGyroscopeAvailable = false;
      });
    }
  }

  @override
  void dispose() {
    // Cancel the gyroscope subscription to prevent memory leaks
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOOTVAULT"),
        automaticallyImplyLeading: false,
        actions: [
          // Debug gyroscope indicator
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Center(
          //     child: Text(
          //       'Rotation: ${_currentRotationMagnitude.toStringAsFixed(2)}\nGyroscope: ${_isGyroscopeAvailable ? "Available" : "Unavailable"}',
          //       style: TextStyle(
          //         color: _currentRotationMagnitude > GyroscopeLogoutManager.CIRCULAR_ROTATION_THRESHOLD 
          //           ? Colors.red 
          //           : Colors.green,
          //         fontSize: 10,
          //       ),
          //     ),
          //   ),
          // ),
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
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Column(
        children: [
          // Gesture detection indicator
          Container(
            color: _currentRotationMagnitude > GyroscopeLogoutManager.CIRCULAR_ROTATION_THRESHOLD 
              ? Colors.black.withOpacity(0.2) 
              : Colors.transparent,
          
          ),
          
          // Existing body content
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