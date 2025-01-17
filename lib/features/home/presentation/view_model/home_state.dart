import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loot_vault/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:loot_vault/features/discover/presentation/view/discover_view.dart';
import 'package:loot_vault/features/forum/presentation/view/forum_view.dart';
import 'package:loot_vault/features/user_profile/presentation/view/profile_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      views: [
        DashBoardView(),
        DiscoverView(),
        ForumView(),
        ProfileView(),

      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
