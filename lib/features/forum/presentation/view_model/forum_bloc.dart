import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_comment_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/delete_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/dislike_post_usecae.dart';
import 'package:loot_vault/features/forum/domain/use_case/edit_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_all_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_comments_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_post_usecase.dart';
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
  final EditPostUsecase _editPostUsecase;
  final GetPostUsecase _getPostUsecase;
  final DeletePostUsecase _deletePostUsecase;
  final LikePostUsecase _likePostUsecase;
  final DislikePostUsecase _dislikePostUsecase;

  ForumBloc({
    required CreateCommentUsecase createCommentUsecase,
    required GetPostUsecase getPostUsecase,
    required DeletePostUsecase deletePostUsecase,
    required EditPostUsecase editPostUsecase,
    required ReplyCommentUsecase replyCommentUsecase,
    required CreatePostUsecase createPostUseCase,
    required GetCommentsUseCase getCommentsUseCase,
    required GetAllPostUsecase getallPostUseCase,
    required LikePostUsecase likePostUseCase,
    required DislikePostUsecase dislikePostUseCse,
  })  : _createCommentUsecase = createCommentUsecase,
        _getPostUsecase = getPostUsecase,
        _editPostUsecase = editPostUsecase,
        _replyCommentUsecase = replyCommentUsecase,
        _deletePostUsecase = deletePostUsecase,
        _createPostUsecase = createPostUseCase,
        _getAllPostUsecase = getallPostUseCase,
        _getCommentsUseCase = getCommentsUseCase,
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
    on<EditPostEvent>(_onEditPost);
    on<DeletePostEvent>(_ondeletePost);
    on<GetPostByIdEvent>(_ongetPostById);
    on<ResetPostEditEvent>((event, emit) {
      emit(state.copyWith(postEdit: false));
    });
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

  Future<void> _getComments(
      GetCommentsEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(
        isLoading: true)); // Show loading state while fetching comments.

    final result =
        await _getCommentsUseCase.call(GetCommentsParams(postId: event.postId));

    result.fold(
      (failure) {
        emit(state.copyWith(
            isLoading: false, error: failure.message)); // Emit failure state.
      },
      (comments) {
        emit(state.copyWith(
            isLoading: false,
            comments: comments)); // Update comments in the state.
      },
    );
    emit(state.copyWith(isSuccess: false));
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
    emit(state.copyWith(isSuccess: false));
  }

  Future<void> _onLikePost(
      LikePostEvent event, Emitter<ForumState> emit) async {
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
      },
    );
    emit(state.copyWith(isSuccess: false));
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

  void _onEditPost(EditPostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(
        isLoading: true, postEdit: true)); // Set postEdit to true
    final result = await _editPostUsecase.call(EditPostParams(
      postId: event.postId,
      content: event.content,
      title: event.title,
    ));
    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          postEdit: false, // Reset postEdit on failure
          error: failure.message,
        ));
      },
      (post) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          postEdit: false, // Reset postEdit on success
          error: null,
        ));
        emit(state.copyWith(isSuccess: false));
      },
    );
  }

  void _ondeletePost(DeletePostEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _deletePostUsecase.call(DeletePostParams(id: event.postId));
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (post) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: null,
        ));
        // showMySnackBar(context: context, message: message)
      },
    );
    emit(state.copyWith(isLoading: false));
  }

  void _ongetPostById(GetPostByIdEvent event, Emitter<ForumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getPostUsecase.call(GetPostParams(id: event.postId));
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (data) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          singlPost: data,
          error: null,
        ));
      },
    );
  }
}
