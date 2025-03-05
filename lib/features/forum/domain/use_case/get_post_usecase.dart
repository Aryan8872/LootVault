import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class GetPostParams extends Equatable {
  final String id;

  const GetPostParams({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetPostUsecase implements UsecaseWithParams<PostEntity, GetPostParams> {
  final IForumRepository repository;

  GetPostUsecase({required this.repository});

  @override
  Future<Either<Failure,PostEntity>> call(GetPostParams params) async {
    try {
      final result = await repository.getPostById(params.id);
      return result.fold(
        (failure) => Left(failure),
        (entity) => Right(entity),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
