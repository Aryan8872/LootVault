import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/discover/presentation/view/discover_view.dart';
import 'package:loot_vault/features/forum/presentation/view/forum_view.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/games/presentation/view/add_product.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:loot_vault/features/home/presentation/view/bottom_view/dashboard_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const DashBoardView(),
        const DiscoverView(),
        BlocProvider(
          create: (context) => getIt<GameBloc>(),
          child: const AddGameScreen(),
        ),
        BlocProvider(
          create: (context) => getIt<ForumBloc>()..add(const GetAllPostEvent()),
          child: const ForumView(),
        ),
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
