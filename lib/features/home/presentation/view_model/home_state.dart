import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/auth/presentation/view/profile_view.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_bloc.dart';
import 'package:loot_vault/features/discover/presentation/view/discover_view.dart';
import 'package:loot_vault/features/forum/presentation/view/forum_view.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:loot_vault/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:loot_vault/features/skins/presentation/view_model/skin_bloc.dart';

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
        MultiBlocProvider(
          providers: [
            BlocProvider<SkinBloc>(
              create: (context) =>
                  getIt<SkinBloc>()..add(Loadskins()), // Load skins
            ),
            BlocProvider<GameBloc>(
              create: (context) =>
                  getIt<GameBloc>()..add(LoadGames()), // Load games
            ),
          ],
          child: const DashBoardView(),
        ),
        const DiscoverView(),
        BlocProvider(
          create: (context) => getIt<ForumBloc>()..add(const GetAllPostEvent()),
          child: const ForumView(),
        ),
        BlocProvider(
          create: (context) => getIt<UserBloc>(),
          child: const ProfileView(),
        )
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
