import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class CreatePostPrams extends Equatable {
  final String title;
  final String content;
  final String userId;

  const CreatePostPrams(
      {required this.title, required this.content, required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreatePostUsecase implements UsecaseWithParams<void, CreatePostPrams> {
  final IForumRepository repositoy;

  CreatePostUsecase({required this.repositoy});
  @override
  Future<Either<Failure, void>> call(CreatePostPrams params) async {
    return await repositoy.createPost(PostEntity(
        postUser: params.userId, title: params.title, content: params.content));
  }
}
