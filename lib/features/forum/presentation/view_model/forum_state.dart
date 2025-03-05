// lib/features/forum/presentation/view_model/forum_state.dart
import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

class ForumState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<PostEntity> posts;
  final int currentPage;
  final String? postId;
  final int? commentLength;
  final int totalPosts;
  final PostEntity? singlPost;
  final bool? isLoaded;
  final bool hasMore;
  final bool? postEdit;
  final bool? shouldRefresh;
  final List<CommentEntity> comments; // Store the list of comments here.

  final int limit; // Added limit to state

  const ForumState({
    required this.isLoading,
    required this.isSuccess,
    this.postEdit,
    this.singlPost = const PostEntity.empty(),
    required this.posts,
    this.commentLength,
    this.isLoaded,
    this.postId,
    this.shouldRefresh,
    this.comments = const [],
    required this.currentPage,
    required this.totalPosts,
    required this.hasMore,
    required this.limit,
    this.error,
  });

  const ForumState.initial()
      : isLoading = false,
        singlPost = const PostEntity.empty(),
        isSuccess = false,
        posts = const [],
        postEdit = false,
        currentPage = 1,
        postId = "",
        shouldRefresh = false,
        totalPosts = 0,
        isLoaded = false,
        comments = const [],
        commentLength = 0,
        hasMore = true,
        limit = 2, // Default limit
        error = null;

  ForumState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<PostEntity>? posts,
    int? currentPage,
    int? totalPosts,
    bool? isLoaded,
    bool? hasMore,
    bool? postEdit,
    PostEntity? singlPost,
    bool? shouldRefresh,
    String? postId,
    int? limit,
    List<CommentEntity>? comments, // Store the list of comments here.

    String? error,
    int? commentLength,
  }) {
    return ForumState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      posts: posts ?? this.posts,
      postEdit: postEdit ?? this.postEdit,  
      singlPost: singlPost ?? this.singlPost,
      shouldRefresh: shouldRefresh ?? this.shouldRefresh,
      isLoaded: isLoaded ?? this.isLoaded,
      comments: comments ?? this.comments,
      currentPage: currentPage ?? this.currentPage,
      totalPosts: totalPosts ?? this.totalPosts,
      hasMore: hasMore ?? this.hasMore,
      limit: limit ?? this.limit,
      postId: postId ?? this.postId,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        posts,
        currentPage,
        singlPost,
        shouldRefresh,
        totalPosts,
        hasMore,
        comments,
        postEdit,
        limit,
        postId,
        error,
      ];
}
