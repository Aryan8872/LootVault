import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_comment_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/dislike_post_usecae.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_all_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/like_post_usecase.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_state.dart';

class ForumBloc extends Bloc<ForumBlocEvent, ForumState> {
  final CreateCommentUsecase _createCommentUsecase;
  final GetAllPostUsecase _getAllPostUsecase;
  final CreatePostUsecase _createPostUsecase;
  final LikePostUsecase _likePostUsecase;
  final DislikePostUsecase _dislikePostUsecase;

  ForumBloc(
      {required CreateCommentUsecase createCommentUsecase,
      required CreatePostUsecase createPostUseCase,
      required GetAllPostUsecase getallPostUseCase,
      required LikePostUsecase likePostUseCase,
      required DislikePostUsecase dislikePostUseCse})
      : _createCommentUsecase = createCommentUsecase,
        _createPostUsecase = createPostUseCase,
        _getAllPostUsecase = getallPostUseCase,
        _likePostUsecase = likePostUseCase,
        _dislikePostUsecase = dislikePostUseCse,
        super(ForumState.initial()) {
    print('Initial state posts: ${state.posts}'); // Should print []

    on<CreatePostEvent>(_createPost);

    on<CreateCommentEvent>(_createComment);

    on<GetAllPostEvent>(_onLoadPosts);
    on<LikePostEvent>(_onLikePost);
    on<NavigateToAddPost>(_navigateToCreate);
    on<DisLikePostEvent>(_dislikePost);
    add(const GetAllPostEvent());
  }

  Future<void> _navigateToCreate(
      NavigateToAddPost event, Emitter<ForumState> emit) async {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: getIt<ForumBloc>(),
          child: event.destination,
        ),
      ),
    );
  }

  Future<void> _createPost(
      CreatePostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createPostUsecase.call(CreatePostPrams(
        content: event.content, title: event.title, userId: event.postUser));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
      },
    );
  }

  Future<void> _onLoadPosts(
      GetAllPostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _getAllPostUsecase.call(page: event.page, limit: state.limit);
    result.fold(
      (failure) {
        print('Load posts failed: ${failure.message}');
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (data) {
        final posts = data['posts'] as List<PostEntity>;
        final totalPosts = data['totalPosts'] as int;
        final updatedPosts =
            event.page == 1 ? posts : [...state.posts, ...posts];
        final hasMore = updatedPosts.length < totalPosts;
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          posts: updatedPosts,
          currentPage: event.page,
          totalPosts: totalPosts,
          hasMore: hasMore,
          error: null,
        ));
      },
    );
  }

  Future<void> _createComment(
      CreateCommentEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCommentUsecase.call(CommentParams(
        comment: event.comment, postId: event.postId, userId: event.userId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
      },
    );
    add(GetAllPostEvent());
  }

  Future<void> _onLikePost(
      LikePostEvent event, Emitter<ForumState> emit) async {
    print('LikePostEvent triggered: ${event.postId}, ${event.userId}');
    final result = await _likePostUsecase(
      LikePostParams(userId: event.userId, postId: event.postId),
    );

    result.fold(
      (failure) {
        print('LikePost failed: ${failure.message}');
        emit(state.copyWith(error: failure.message));
      },
      (updatedPost) {
        print('LikePost succeeded: ${updatedPost.likes}');
        final updatedPosts = state.posts.map((post) {
          return post.postId == updatedPost.postId ? updatedPost : post;
        }).toList();
        emit(state.copyWith(posts: updatedPosts));
        print("Updated state: ${state.posts}");
      },
    );
  }

  Future<void> _dislikePost(
      DisLikePostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _dislikePostUsecase
        .call(DislikePostParams(postId: event.postId, userId: event.userId));
        print("dislike");
    result.fold(
      (failure) =>
      
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (updatedPost) {
        print("success vitra");
            final updatedPosts = state.posts.map((post) {
          return post.postId == updatedPost.postId ? updatedPost : post;
        }).toList();
        emit(state.copyWith(isLoading: false, error: null,posts: updatedPosts));
      },
    );
  }
}
