// lib/features/forum/presentation/view_model/forum_state.dart
import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

class ForumState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<PostEntity> posts;
  final int currentPage;
  final int totalPosts;
  final bool hasMore;
  final int limit; // Added limit to state

   ForumState({
    required this.isLoading,
    required this.isSuccess,
    required this.posts,
    required this.currentPage,
    required this.totalPosts,
    required this.hasMore,
    required this.limit,
    this.error,
  });

   ForumState.initial()
      : isLoading = false,
        isSuccess = false,
        posts = const [],
        currentPage = 1,
        totalPosts = 0,
        hasMore = true,
        limit = 2, // Default limit
        error = null;

  ForumState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<PostEntity>? posts,
    int? currentPage,
    int? totalPosts,
    bool? hasMore,
    int? limit,
    String? error,
  }) {
    return ForumState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      totalPosts: totalPosts ?? this.totalPosts,
      hasMore: hasMore ?? this.hasMore,
      limit: limit ?? this.limit,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        posts,
        currentPage,
        totalPosts,
        hasMore,
        limit,
        error,
      ];
}
