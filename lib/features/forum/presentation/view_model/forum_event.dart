import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ForumBlocEvent extends Equatable {
  const ForumBlocEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPostDetail extends ForumBlocEvent {
  final BuildContext context;
  final Widget destination;
  final String postId;

  const NavigateToPostDetail(
      {required this.context, required this.postId, required this.destination});
}

class CreatePostEvent extends ForumBlocEvent {
  final String postUser;
  final String title;
  final String content;

  const CreatePostEvent(
      {required this.postUser, required this.title, required this.content});
}

class CreateCommentEvent extends ForumBlocEvent {
  final String comment;
  final String userId;
  final String postId;

  const CreateCommentEvent(
      {required this.comment, required this.postId, required this.userId});
}

class GetAllPostEvent extends ForumBlocEvent {
  final int page;
  final int limit;

  const GetAllPostEvent({this.page = 1, this.limit = 2});
}

class LikePostEvent extends ForumBlocEvent {
  final String userId;
  final String postId;

  const LikePostEvent({required this.userId, required this.postId});
}

class DisLikePostEvent extends ForumBlocEvent {
  final String userId;
  final String postId;

  const DisLikePostEvent({required this.userId, required this.postId});
}

class NavigateToAddPost extends ForumBlocEvent {
  final Widget destination;
  final BuildContext context;

  const NavigateToAddPost({required this.destination, required this.context});
}

class CreateReplyEvent extends ForumBlocEvent {
  final String postId;
  final String commentId;
  final String userId;
  final String reply;

  const CreateReplyEvent({
    required this.postId,
    required this.commentId,
    required this.userId,
    required this.reply,
  });
}

class ResetSuccessEvent extends ForumBlocEvent {
  const ResetSuccessEvent();
}

class GetCommentsEvent extends ForumBlocEvent {
  final String postId;

  const GetCommentsEvent({required this.postId});

 
}
