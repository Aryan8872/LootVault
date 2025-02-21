import 'package:bloc/bloc.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc_event.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc_state.dart';

class ForumBlocBloc extends Bloc<ForumBlocEvent, ForumState> {
  ForumBlocBloc() : super(const ForumState.initial()) {
    on<createPostEvent>((createPostEvent event, Emitter<ForumState> state) {});

    on<createCommentEvent>(
        (createCommentEvent event, Emitter<ForumState> state) {});

    on<getAllPostEvent>(
        (getAllPostEvent event, Emitter<ForumState> state) {});

    
  }
}
