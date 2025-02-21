
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

class createPostEvent extends ForumBlocEvent {
  final String postUser;
  final String title;
  final String content;

  const createPostEvent(
      {required this.postUser, required this.title, required this.content});
}

class createCommentEvent extends ForumBlocEvent {
  final String comment;

  const createCommentEvent({required this.comment});
}
class getAllPostEvent extends ForumBlocEvent{

}