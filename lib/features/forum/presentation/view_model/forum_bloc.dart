import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_comment_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/dislike_post_usecae.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_all_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_comments_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/like_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/reply_comment_usecase.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_state.dart';

class ForumBloc extends Bloc<ForumBlocEvent, ForumState> {
  final CreateCommentUsecase _createCommentUsecase;
  final ReplyCommentUsecase _replyCommentUsecase;

  final GetAllPostUsecase _getAllPostUsecase;
  final GetCommentsUseCase _getCommentsUseCase;
  final CreatePostUsecase _createPostUsecase;
  final LikePostUsecase _likePostUsecase;
  final DislikePostUsecase _dislikePostUsecase;

  ForumBloc({
    required CreateCommentUsecase createCommentUsecase,
    required ReplyCommentUsecase replyCommentUsecase,
    required CreatePostUsecase createPostUseCase,
    required GetCommentsUseCase getCommentsUseCase,
    required GetAllPostUsecase getallPostUseCase,
    required LikePostUsecase likePostUseCase,
    required DislikePostUsecase dislikePostUseCse,
  })  : _createCommentUsecase = createCommentUsecase,
        _replyCommentUsecase = replyCommentUsecase,
        _createPostUsecase = createPostUseCase,
        _getAllPostUsecase = getallPostUseCase,
        _getCommentsUseCase =  getCommentsUseCase,
        _likePostUsecase = likePostUseCase,
        _dislikePostUsecase = dislikePostUseCse,
        super(const ForumState.initial()) {
    on<CreatePostEvent>(_createPost);
    on<CreateCommentEvent>(_createComment);
    on<GetAllPostEvent>(_onLoadPosts);
    on<LikePostEvent>(_onLikePost);
    on<NavigateToAddPost>(_navigateToCreate);
    on<DisLikePostEvent>(_dislikePost);
    on<CreateReplyEvent>(_replyComment);
    on<GetCommentsEvent>(_getComments);
    on<ResetSuccessEvent>((event, emit) {
      emit(state.copyWith(isSuccess: false));
    });
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
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final result = await _createPostUsecase.call(CreatePostPrams(
        content: event.content, title: event.title, userId: event.postUser));
       
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        print("bloc ma succes ma gayo");
        emit(state.copyWith(isLoading: false, error: null));
      
      },
    );
  }

Future<void> _onLoadPosts(
      GetAllPostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));

    final result = await _getAllPostUsecase.call();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (data) {
        print("bloc ma get all post ko data ${data}");
        // Here's the change - don't treat data as a Map
        final posts = data as List<PostEntity>;

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          posts: posts,
          error: null,
        ));
      },
    );
  }

  Future<void> _getComments(GetCommentsEvent event, Emitter<ForumState> emit) async {
  emit(state.copyWith(isLoading: true)); // Show loading state while fetching comments.
  
  final result = await _getCommentsUseCase.call(GetCommentsParams(postId: event.postId)); // Assuming you have a use case to fetch comments.

  result.fold(
    (failure) {
      emit(state.copyWith(isLoading: false, error: failure.message)); // Emit failure state.
    },
    (comments) {
      emit(state.copyWith(isLoading: false, comments: comments)); // Update comments in the state.
    },
  );
}

  Future<void> _createComment(
      CreateCommentEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final result = await _createCommentUsecase.call(CommentParams(
        comment: event.comment, postId: event.postId, userId: event.userId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, isSuccess: true, error: null));
      },
    );

    add(GetCommentsEvent(postId: event.postId));
  }

  Future<void> _onLikePost(
      LikePostEvent event, Emitter<ForumState> emit) async {
    print('LikePostEvent triggered: ${event.postId}, ${event.userId}');
    emit(state.copyWith(isLoading: true, isSuccess: false));

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
        emit(state.copyWith(
            isLoading: false,
            posts: updatedPosts,
            isSuccess: true,
            commentLength: updatedPost.postComments?.length));
        print("Updated state: ${state.posts}");
      },
    );
  }

  Future<void> _dislikePost(
      DisLikePostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
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
        emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            error: null,
            posts: updatedPosts,
            commentLength: updatedPost.postComments?.length));
      },
    );
  }

  Future<void> _replyComment(
      CreateReplyEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _replyCommentUsecase.call(ReplyCommentParams(
        postId: event.postId,
        commentId: event.commentId,
        userId: event.userId,
        comment: event.reply));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (updatedPost) {
        // Refresh the post comments after reply is added.
        final updatedPosts = state.posts
            .map((post) =>
                post.postId == updatedPost.postId ? updatedPost : post)
            .toList();
        emit(state.copyWith(
          isLoading: false,
          posts: updatedPosts,
          isSuccess: true,
          error: null,
          commentLength: updatedPost.postComments?.length,
        ));
      },
    );
  }
}
